class RoomsController < ApplicationController
  before_action :authorize

  def show
    @messages = Message.where(uuid: session['name'])
  end

end
