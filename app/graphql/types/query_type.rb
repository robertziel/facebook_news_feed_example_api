module Types
  class QueryType < BaseObject
    field :posts, resolver: Resolvers::Posts
    field :profile, resolver: Resolvers::Profile
  end
end
