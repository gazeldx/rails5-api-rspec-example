class AgentBaseController < ApplicationController
  before_action :validate_agent_login

  private

  def validate_agent_login
    token = request.headers["X-Api-Key"]
    return unless token

    agent = Agent.find_by(token: token)
    return unless agent

    agent.touch if Time.now - agent.updated_at > 5.minutes
    @current_user = agent
  end
end
