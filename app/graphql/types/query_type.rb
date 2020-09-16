module Types
  class QueryType < BaseObject
    field :news_feeds, resolver: Resolvers::NewsFeeds
    field :profile, resolver: Resolvers::Profile
  end
end
