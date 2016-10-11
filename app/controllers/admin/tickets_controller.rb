class Admin::TicketsController < AdminBaseController
  before_action :validate_user, only: [:index]

  def index
    tickets = Ticket.all.order(created_at: :desc).page(params[:page] ? params[:page][:number] : 1)
    render json: tickets, meta: pagination_meta(tickets).merge(default_meta), include: [:customer, :agent]
  end
end
