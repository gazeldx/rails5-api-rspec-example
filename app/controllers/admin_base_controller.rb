class AdminBaseController < ApplicationController
  before_action :validate_administrator_login

  private

  def validate_administrator_login
    token = request.headers["X-Api-Key"]
    return unless token

    administrator = Administrator.find_by(token: token)
    return unless administrator

    administrator.touch if Time.now - administrator.updated_at > 5.minutes
    @current_user = administrator
  end
end
