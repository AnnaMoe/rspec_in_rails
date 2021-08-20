class CommentsChannel < ApplicationCable::Channel
  
  #whenever a user subscribes to the channel, this method is called
  def subscribed
    stream_from "comments"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
