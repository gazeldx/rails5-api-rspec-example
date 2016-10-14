class SessionsController < ApplicationController
  def create
    puts "params is #{params.inspect}"

    data = ActiveModelSerializers::Deserialization.jsonapi_parse(params)

    puts "data is #{data.inspect}"

    puts "Customer.all is #{Customer.all.inspect}"
    customer = Customer.where(email: data[:email]).first
    head 406 and return unless customer

    if customer.authenticate(data[:password])
      customer.regenerate_token
      @current_user = customer
      render json: customer, status: :created, meta: default_meta, serializer: ActiveModel::Serializer::SessionSerializer
    else
      head 403
    end
  end

  def destroy
    customer = Customer.where(token: ActiveModelSerializers::Deserialization.jsonapi_parse(params)[:token]).first
    head 404 and return unless customer

    customer.regenerate_token
    head 204
  end
end