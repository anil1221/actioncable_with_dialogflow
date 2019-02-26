module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :current_user
    identified_by :current_user
    def connect
      self.current_user = request.session.fetch('name', nil)
      reject_unauthorized_connection unless current_user
      # self.uuid = SecureRandom.urlsafe_base64
      # reject_unauthorized_connection unless uuid
    end
  end
end
