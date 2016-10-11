class Agent::TicketItemsController < AgentBaseController
  before_action :validate_user, only: [:create]
  before_action :validate_type, only: [:create]

  def create
    ticket_item = TicketItem.new(ticket_item_params.merge(agent_id: current_user.id))
    if ticket_item.save
      render json: ticket_item, status: :created, meta: default_meta
    else
      render_error(ticket_item, :unprocessable_entity)
    end
  end

  private

  def ticket_item_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:ticket_id, :content, :state])
  end
end
