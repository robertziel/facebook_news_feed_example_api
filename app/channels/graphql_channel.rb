class GraphqlChannel < ApplicationCable::Channel
  def subscribed
    @subscription_ids = []
  end

  def execute(data)
    query = data['query']
    variables = ensure_hash(data['variables'])
    operation_name = data['operationName']

    result = GraphqlSchema.execute(
      {
        query: query,
        context: context,
        variables: variables,
        operation_name: operation_name
      }
    )

    # Track the subscription here so we can remove it
    # on unsubscribe.
    @subscription_ids << result.context[:subscription_id] if result.context[:subscription_id]

    transmit(payload(result))
  end

  def unsubscribed
    @subscription_ids.each do |sid|
      GraphqlSchema.subscriptions.delete_subscription(sid)
    end
  end

  private

  def context
    token = params['authToken']
    {
      # Re-implement whatever context methods you need
      # in this channel or ApplicationCable::Channel
      current_user: Warden::JWTAuth::UserDecoder.new.call(token, :user, nil),
      # Make sure the channel is in the context
      channel: self
    }
  end

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def payload(result)
    {
      result: result.subscription? ? { data: nil } : result.to_h,
      more: result.subscription?
    }
  end
end
