require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  before do
    @customer = Customer.find_by_email('stevejobs@apple.com')
    request.content_type = 'application/vnd.api+json'
    request.headers.merge!('X-Api-Key': @customer.token)
  end

  let(:valid_attributes) {
    { title: 'What OS is the best OS?', content: 'Mac?', customer: @customer, agent: Agent.default }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "return customer's tickets" do
      ticket = Ticket.create!(valid_attributes)
      get :index, params: {}
      expect(assigns(:tickets)).to eq([ticket])
    end
  end

  describe "GET #show" do
    it "return a ticket" do
      ticket = Ticket.create!(valid_attributes)
      get :show, params: { id: ticket.id }
      expect(assigns(:ticket)).to eq(ticket)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "create a ticket" do
        expect {
          post :create, params: { data: { type: 'ticket', attributes: valid_attributes } }
        }.to change(Ticket, :count).by(1)
        expect(assigns(:ticket)).to be_a(Ticket)
        expect(assigns(:ticket)).to be_persisted
        expect(response.response_code).to eq 201
      end
    end

    context "with invalid params" do
      it "with invalid type" do
        post :create, params: { data: { type: 'post', attributes: valid_attributes } }
        expect(response.response_code).to eq 409
      end
    end
  end
end
