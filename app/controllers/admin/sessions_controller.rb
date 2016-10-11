class Admin::SessionsController < ApplicationController
  def create
    data = ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    puts "======= administrator session data is #{data.inspect} =================="
    Rails.logger.info params.to_yaml

    administrator = Administrator.where(email: data[:email]).first
    head 406 and return unless administrator

    if administrator.authenticate(data[:password])
      administrator.regenerate_token
      @current_user = administrator
      render json: administrator, status: :created, meta: default_meta, serializer: ActiveModel::Serializer::SessionSerializer
    else
      head 403
    end
  end

  def destroy
    administrator = Administrator.where(token: ActiveModelSerializers::Deserialization.jsonapi_parse(params)[:token]).first
    head 404 and return unless administrator

    administrator.regenerate_token
    head 204
  end
end