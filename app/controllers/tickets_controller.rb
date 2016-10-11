class TicketsController < CustomerBaseController
  before_action :validate_user, only: [:index, :create]
  before_action :validate_type, only: [:create]
  before_action :set_ticket, only: [:show]

  def index
    pdf = WickedPdf.new.pdf_from_string('<h1>Hello There!</h1>')
    send_data(pdf, :filename => "my_pdf_name.pdf",
                   :disposition => 'attachment')


    # TODO: add includes ?
    # tickets = current_user.tickets.order(created_at: :desc).page(params[:page] ? params[:page][:number] : 1)
    # render json: tickets, meta: pagination_meta(tickets).merge(default_meta), include: [:agent]
  end

  def show
    render json: @ticket, meta: default_meta, include: [:customer, :agent, :ticket_items]
  end

  def create
    puts "--------------- ticket_params is #{ticket_params.inspect}"
    ticket = current_user.tickets.build(ticket_params)
    if ticket.save
      render json: ticket, status: :created, meta: default_meta
    else
      render_error(ticket, :unprocessable_entity)
    end
  end

  private

  def set_ticket
    begin
      @ticket = Ticket.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      ticket = Ticket.new
      ticket.errors.add(:id, "Wrong ID provided")
      render_error(ticket, 404) and return
    end
  end

  def ticket_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:title, :content, :state, :customer, :agent_id])
  end
end
