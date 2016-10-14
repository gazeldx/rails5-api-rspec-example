require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:valid_attributes) {
    { email: 'stevejobs@apple.com', password: 'password2', token: 'token2' }
  }

  let(:invalid_attributes) {
    { email: 'stevejobs@apple.com', password: 'password3_is_incorrect', token: 'token_is_incorrect' }
  }

  let(:email_not_found_attributes) {
    { email: 'this_email_is_not_exist@apple.com', password: 'will_be_skipped' }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before do
    request.content_type = 'application/vnd.api+json'
  end

  describe "POST #create" do
    context "with valid params" do
      it "login success" do
        post :create, params: { data: { attributes: valid_attributes } }
        expect(response.response_code).to eq 201
      end

      it "incorrect password" do
        post :create, params: { data: { attributes: invalid_attributes } }
        expect(response.response_code).to eq 403
      end

      it "email not found" do
        post :create, params: { data: { attributes: email_not_found_attributes } }
        expect(response.response_code).to eq 406
      end
    end
  end

  describe "POST #destroy" do
    context "with valid params" do
      it "logout success" do
        post :destroy, params: { data: { attributes: valid_attributes } }
        expect(response.response_code).to eq 204
      end

      it "token not match any customer" do
        post :destroy, params: { data: { attributes: invalid_attributes } }
        expect(response.response_code).to eq 404
      end
    end
  end
end
