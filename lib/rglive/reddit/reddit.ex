defmodule Rglive.Reddit.Reddit do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://www.reddit.com/r/")
  plug(Tesla.Middleware.JSON)

  defp get_feed_for_subreddit(subreddit) do
    case get("#{subreddit.name}.json") do
      {:ok, response} ->
        Enum.map(response.body["data"]["children"], fn o ->
          %{
            title: o["data"]["title"],
            url: "https://reddit.com/#{o["data"]["permalink"]}",
            score: o["data"]["score"],
            subreddit: o["data"]["subreddit_name_prefixed"],
            thumbnail: o["data"]["thumbnail"]
          }
        end)

      {:error, error} ->
        IO.puts("Error querying subreddit #{subreddit.name}: #{inspect(error)}")
        []
    end
  end

  def get_feeds(feeds) do
    Enum.map(feeds, fn feed ->
      Task.async(fn -> get_feed_for_subreddit(feed) end)
    end)
    |> Enum.flat_map(&Task.await/1)
    |> Enum.sort_by(fn o -> o.score end, &>=/2)
  end
end
