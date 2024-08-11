require 'rails_helper'

RSpec.describe "CustomersControllers", type: :request do
  let(:user) { create(:user, role: "admin") }
  let(:headers) { {'Authorization' => "Bearer #{get_authentication(user)}"} }

  describe "GET /customers" do
    context 'when authentication is provided' do
      it "returns a successful code" do
        get customers_path, headers: headers
        expect(response.code).to eq "200"
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { {} }

      it "returns an unauthorized code" do
        get customers_path, headers: headers
        expect(response.code).to eq "401"
      end
    end
  end

  describe "POST /customers" do
    pending
  end

  describe "GET /customers" do
    pending
  end

  describe "PUT /customers" do
    pending
  end

  describe "DELETE /customers" do
    pending
  end
end
