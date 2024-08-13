require 'rails_helper'

RSpec.describe "CustomersControllers", type: :request do
  let(:user) { create(:user, role: "admin") }
  let(:headers) { {'Authorization' => "Bearer #{get_authentication(user)}"} }

  describe "GET /customers" do
    before do
      get customers_path, headers: headers
    end

    context 'when authentication is provided' do
      it "returns a successful code" do
        expect(response.code).to eq "200"
      end

      context 'when there are customers in the db' do
        before do
          create(:customer, name: "cx1")
        end

        it 'returns the appropriate data' do
          get customers_path, headers: headers
          expect(response.parsed_body.count).to eq 1
        end

        it 'returns a non empty array' do
          get customers_path, headers: headers
          expect(response.parsed_body.first["name"]).to eq "cx1"
        end
      end

      context 'when there are NO customers in the db' do
        it 'returns an empty array' do
          expect(response.parsed_body.count).to eq 0
        end
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { {} }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
      end
    end
  end

  describe "POST /customers" do
    let(:headers) { {'Authorization' => "Bearer #{get_authentication(user)}", "Content" => "application/json"} }
    let(:customer_params) { { name: "a", surname: "b", cx_id: "c" } }

    before do
      post customers_path, params: customer_params, headers: headers
    end

    context 'when authentication is provided' do
      it "returns a successful code" do
        expect(response.code).to eq "201"
      end

      it "creates the expected customer" do
        expect(Customer.count).to eq 1
      end

      it "sets the appropriate data" do
        customer = Customer.first
        expect(customer.name).to eq "a"
        expect(customer.surname).to eq "b"
        expect(customer.cx_id).to eq "c"
      end

      it "sets the created_by to the appropriate customer" do
        expect(Customer.first.created_by_id).to eq 1
      end

      it "sets the updated_by to the same customer" do
        expect(Customer.first.updated_by_id).to eq 1
      end

      context 'when a required attribute is missing' do
        let(:customer_params) { { customer: {name: "a", surname: "b"} } }

        it "returns a failure code" do
          expect(response.code).to eq "422"
        end
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { {} }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
      end
    end
  end

  describe "GET /customer" do
    let(:headers) { {'Authorization' => "Bearer #{get_authentication(user)}"} }
    let(:customer) { create(:customer) }
    let(:id) { customer.id }

    before do
      get customer_path(id), headers: headers
    end

    context 'when authentication is provided' do
      it "returns a successful code" do
        expect(response.code).to eq "200"
      end

      context "when searching for an existing customer" do
        it "finds an existing customer" do
          customer_data = response.parsed_body
          expect(customer_data["name"]).to eq customer.name
        end
      end

      context 'when searching for a non-existing customer' do
        let(:id) { 500 }

        it "fails to find a non-existing customer" do
          expect(response.code).to eq "404"
        end
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { {} }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
      end
    end
  end

  describe "PUT /customer" do
    let(:headers) { {'Authorization' => "Bearer #{get_authentication(editing_user)}", "Content" => "application/json"} }
    let(:user) { create(:user) }
    let(:editing_user) { create(:user) }
    let(:customer) { create(:customer, name: "a", surname: "b", cx_id: "c", created_by_id: user.id, updated_by_id: user.id) }
    let(:customer_params) { { cx_id: "d" } }
    let(:id) { customer.id }

    before do
      put customer_path(id), params: customer_params, headers: headers
    end

    context 'when authentication is provided' do
      it "returns a successful code" do
        expect(response.code).to eq "200"
      end

      context "when editing an existing customer" do
        it "edits the provided value" do
          customer_data = response.parsed_body
          expect(customer_data["cx_id"]).to eq "d"
        end

        it "sets the updated_by_id value" do
          customer_data = response.parsed_body
          expect(customer_data["updated_by_id"]).to eq editing_user.id
        end
      end

      context 'when editing a non-existing customer' do
        let(:id) { 500 }

        it "fails to edit a non-existing customer" do
          expect(response.code).to eq "404"
        end
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { {} }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
      end
    end
  end

  describe "DELETE /customer" do
    let(:headers) { {'Authorization' => "Bearer #{get_authentication(user)}"} }
    let(:user) { create(:user) }
    let(:customer) { create(:customer) }
    let(:id) { customer.id }

    before do
      delete customer_path(id), headers: headers
    end

    context 'when authentication is provided' do
      it "returns a deleted code" do
        expect(response.code).to eq "204"
      end

      context "when deleting an existing customer" do
        it "deletes the customer" do
          expect(Customer.count).to eq 0
        end
      end

      context 'when editing a non-existing customer' do
        let(:id) { 500 }

        it "fails to edit a non-existing customer" do
          expect(response.code).to eq "404"
        end
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { {} }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
      end
    end
  end
end
