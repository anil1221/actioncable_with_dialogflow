class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{current_user}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(content: data['message'], uuid: current_user, user_name: current_user)
    diagloflow_response(data['message'])
  end

  def diagloflow_response(message)
    response = CLIENT.text_request(message)
    new_message = Message.create!(content: response, uuid: current_user, user_name: 'Bot')
    @room = RoomsController.new
    @room.post_response(new_message)
  end
end
