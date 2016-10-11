class CustomerBaseController < ApplicationController
  before_action :validate_customer_login

  private

  def validate_customer_login
    token = request.headers["X-Api-Key"]
    return unless token

    customer = Customer.find_by(token: token)
    return unless customer

    customer.touch if Time.now - customer.updated_at > 5.minutes
    @current_user = customer
  end
end
