class Message < ApplicationRecord
  # after_create_commit { MessageBroadcastJob.perform_later self}
  after_create_commit :broacast_to_subscribers

  def broacast_to_subscribers
    ActionCable.server.broadcast "user_#{uuid}", message: render_message(user, bot_message, quick_replies)
  end

  def render_message(user, bot_message, quick_replies)
    ApplicationController.renderer.render(partial: 'messages/message', locals: {user: user, message: bot_message, qr: quick_replies})
  end

  def user
    user_name
  end

  def bot_message
    content = user_name.eql?('Bot') ? eval(self.content) : self.content
    user_name.eql?('Bot') ? content[:result][:fulfillment][:speech] : content
  end

  def quick_replies
    return unless user_name.eql?('Bot')
    content = user_name.eql?('Bot') ? eval(self.content) : self.content
    content[:result][:fulfillment][:messages].map {|m| m[:replies]}.compact.first
  end
end
