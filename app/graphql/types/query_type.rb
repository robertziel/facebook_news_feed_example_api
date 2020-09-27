module Types
  class QueryType < BaseObject
    # Comments
    field :comments, resolver: Resolvers::Comments::AllComments

    # Posts
    field :posts, resolver: Resolvers::Posts::AllPosts
    field :post, resolver: Resolvers::Posts::ShowPost

    # Profile
    field :profile, resolver: Resolvers::Profile
  end
end
