class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def getSuccessMsg(session)
    if (session[:success_msg])
      msg = session[:success_msg]
      session[:success_msg] = nil
      return msg
    end
  end
end
