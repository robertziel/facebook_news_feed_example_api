module Resolvers
  class NewsFeeds < GraphQL::Schema::Resolver
    include ::GraphqlAuthenticationConcerns

    type [Types::NewsFeedType], null: false
    description 'Returns news feeds'

    def resolve
      authenticate_user!
      NewsFeed.limit(5)
    end
  end
end
