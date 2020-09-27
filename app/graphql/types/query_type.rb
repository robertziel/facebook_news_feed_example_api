module Types
  class QueryType < BaseObject
    # Comments
    field :comments, resolver: Resolvers::Comments::Index

    # Posts
    field :posts, resolver: Resolvers::Posts::Index
    field :post, resolver: Resolvers::Posts::Show

    # Profile
    field :profile, resolver: Resolvers::Profile
  end
end
