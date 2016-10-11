class Admin::CustomersController < AdminBaseController
  before_action :validate_user, only: [:index]

  def index
    customers = Customer.all.order(created_at: :desc).page(params[:page] ? params[:page][:number] : 1)
    render json: customers, meta: pagination_meta(customers).merge(default_meta)
  end
end
