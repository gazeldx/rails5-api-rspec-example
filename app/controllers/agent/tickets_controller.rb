class Agent::TicketsController < AgentBaseController
  before_action :validate_user, only: [:index, :update]
  before_action :validate_type, only: [:update]
  before_action :set_ticket, only: [:show, :update, :update_state]

  def index
    tickets = Ticket.all.includes(:customer, :agent, :ticket_items).order(created_at: :desc).page(params[:page] ? params[:page][:number] : 1)
    render json: tickets, meta: pagination_meta(tickets).merge(default_meta), include: [:customer, :agent]
  end

  def show
    render json: @ticket, meta: default_meta, include: [:customer, :agent, :ticket_items]
  end

  def update
    if @ticket.update_attributes(ticket_params)
      render json: @ticket, status: :ok, meta: default_meta
    else
      render_error(@ticket, :unprocessable_entity)
    end
  end

  def update_state
    @ticket.update_attribute(:state, ticket_params[:state])
    render json: @ticket, status: :ok, meta: default_meta
  end

  private

  def set_ticket
    begin
      @ticket = Ticket.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      # TODO: refactor
      ticket = Ticket.new
      ticket.errors.add(:id, "Wrong ID provided")
      render_error(ticket, 404) and return
    end
  end

  def ticket_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:title, :content, :state, :customer, :agent])
  end
end
