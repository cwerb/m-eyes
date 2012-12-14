class MailresponseController < ApplicationController
  def accept
    if user = User.find_by_register_token(params[:token])
      case @action = params[:do]
        when 'accept'
          user.register_token = nil
          user.save
        when 'cancel'
          user.delete
      end
    else
      render nothing: true
    end
  end
end
