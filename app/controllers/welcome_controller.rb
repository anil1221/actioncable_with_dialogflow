class WelcomeController < ApplicationController
  def index
    redirect_to chat_path if session['name']
  end
end
