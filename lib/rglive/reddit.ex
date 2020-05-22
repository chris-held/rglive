defmodule Rglive.Reddit do
  alias Rglive.Reddit.Reddit

  def get_reddit_feed(subreddits) do
    Enum.map(subreddits, fn sub ->
      %{
        name: sub
      }
    end)
    |> Reddit.get_feeds()
  end
end
