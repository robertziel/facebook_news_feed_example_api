module GraphqlSubscriptionsSpecHelper
  def stream_event_name(event, post_id = nil)
    post_id_str = post_id.nil? ? '' : "postId:#{post_id}"

    "#{GraphQL::Subscriptions::ActionCableSubscriptions::EVENT_PREFIX}:#{event}:#{post_id_str}"
  end

  def model_object_gid(object)
    if object.new_record?
      # check next id in object's table
      # Postgres' next_sequence_value does not work with MySQL, quick workaround supported by all databases
      temporary_object = create object.class.to_s.underscore
      object.id = temporary_object.id.next
      temporary_object.delete
    end
    object.to_gid_param
  end
end
