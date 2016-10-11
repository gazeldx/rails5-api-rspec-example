class Admin::AgentsController < AdminBaseController
  before_action :validate_user, only: [:index]

  def index
    agents = Agent.all.order(created_at: :desc).page(params[:page] ? params[:page][:number] : 1)
    render json: agents, meta: pagination_meta(agents).merge(default_meta)
  end
end
