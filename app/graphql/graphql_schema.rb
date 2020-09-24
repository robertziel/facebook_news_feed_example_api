class GraphqlSchema < GraphQL::Schema
  use GraphQL::Subscriptions::ActionCableSubscriptions

  query Types::QueryType
  mutation Types::MutationType
  subscription Types::SubscriptionType
end
