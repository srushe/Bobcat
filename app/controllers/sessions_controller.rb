class SessionsController < ApplicationController
  ACCEPTED_EMAIL_ADDRESSES = []

  def callback
    auth = request.env["omniauth.auth"]
    
    if ACCEPTED_EMAIL_ADDRESSES.include?(auth['info']['email'])
      auth = request.env["omniauth.auth"]  
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)  
      session[:user_id] = user.id
      if request.env["HTTP_REFERER"]
        redirect_to :back
      else
        redirect_to root_url, :notice => "Signed in!"
      end
    else
      @email_address = auth['info']['email']
      render '/sessions/email_not_permitted'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  def failure; end

end
