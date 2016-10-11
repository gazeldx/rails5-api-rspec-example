class Agent::SessionsController < ApplicationController
  def create
    data = ActiveModelSerializers::Deserialization.jsonapi_parse(params)

    agent = Agent.where(email: data[:email]).first
    head 406 and return unless agent

    if agent.authenticate(data[:password])
      agent.regenerate_token
      @current_user = agent
      render json: agent, status: :created, meta: default_meta, serializer: ActiveModel::Serializer::SessionSerializer
    else
      head 403
    end
  end

  def destroy
    agent = Agent.where(token: ActiveModelSerializers::Deserialization.jsonapi_parse(params)[:token]).first
    head 404 and return unless agent

    agent.regenerate_token
    head 204
  end
end