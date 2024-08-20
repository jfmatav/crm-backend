require 'rails_helper'

RSpec.describe "UsersControllers", type: :request do
  let!(:admin) { create(:user, role: "admin") }
  let!(:basic) { create(:user, role: "basic") }
  let(:admin_headers) { { 'Authorization' => "Bearer #{get_authentication(admin)}" } }
  let(:basic_headers) { { 'Authorization' => "Bearer #{get_authentication(basic)}" } }
  let(:headers) { admin_headers }

  describe "GET /users" do
    before do
      get users_path, headers: headers
    end

    context 'when authentication is provided' do
      it "returns a successful code" do
        expect(response.code).to eq "200"
      end

      context 'when there are customers in the db' do
        it 'returns a non empty array' do
          expect(response.parsed_body.count).to eq 2
        end

        it 'returns the appropriate admin data' do
          admin_data = response.parsed_body.select { |user| user["role"] == "admin" }.first
          expect(admin_data["name"]).to eq admin.name
        end

        it 'returns the appropriate basic data' do
          basic_data = response.parsed_body.select { |user| user["role"] == "basic" }.first
          expect(basic_data["name"]).to eq basic.name
        end
      end
    end

    context 'when authentication is provided for a regular user' do
      let(:headers) { basic_headers }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { {} }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
      end
    end
  end

  describe "POST /users" do
    let(:admin_headers) { { 'Authorization' => "Bearer #{get_authentication(admin)}", "Content" => "application/json" } }
    let(:basic_headers) { { 'Authorization' => "Bearer #{get_authentication(basic)}", "Content" => "application/json" } }
    let(:headers) { admin_headers }
    let(:user_params) { { user: { name: "a", email: "b", role: "basic", password: "password123" } } }

    before do
      post users_path, params: user_params, headers: headers
    end

    context 'when authentication is provided' do
      it "returns a successful code" do
        expect(response.code).to eq "201"
      end

      it "creates the expected user" do
        expect(User.count).to eq 3
      end

      it "sets the appropriate data" do
        user = User.last
        expect(user.name).to eq "a"
        expect(user.email).to eq "b"
        expect(user.role).to eq "basic"
      end

      context 'when a required attribute is missing' do
        let(:user_params) { { user: { name: "a", email: "b" } } }

        it "returns a failure code" do
          expect(response.code).to eq "422"
        end
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { basic_headers }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { {} }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
      end
    end
  end

  describe "GET /user" do
    let(:user) { create(:user) }
    let(:id) { user.id }

    before do
      get user_path(id), headers: headers
    end

    context 'when authentication is provided' do
      it "returns a successful code" do
        expect(response.code).to eq "200"
      end

      context "when searching for an existing user" do
        it "finds an existing user" do
          user_data = response.parsed_body
          expect(user_data["name"]).to eq user.name
        end
      end

      context 'when searching for a non-existing user' do
        let(:id) { 500 }

        it "fails to find a non-existing user" do
          expect(response.code).to eq "404"
        end
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { basic_headers }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { {} }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
      end
    end
  end

  describe "PUT /user" do
    let(:admin_headers) { { 'Authorization' => "Bearer #{get_authentication(admin)}", "Content" => "application/json" } }
    let(:basic_headers) { { 'Authorization' => "Bearer #{get_authentication(basic)}", "Content" => "application/json" } }
    let(:user) { create(:user, name: "a", email: "b", role: "basic", password: "password123") }
    let(:user_params) { { user: { role: "admin" } } }
    let(:id) { user.id }

    before do
      put user_path(id), params: user_params, headers: headers
    end

    context 'when authentication is provided' do
      it "returns a successful code" do
        expect(response.code).to eq "200"
      end

      context "when editing an existing customer" do
        it "edits the provided value" do
          customer_data = response.parsed_body
          expect(customer_data["role"]).to eq "admin"
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
      let(:headers) { basic_headers }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
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
    let(:user) { create(:user) }
    let(:id) { user.id }

    before do
      delete user_path(id), headers: headers
    end

    context 'when authentication is provided' do
      it "returns a deleted code" do
        expect(response.code).to eq "204"
      end

      context "when deleting an existing user" do
        it "deletes the user" do
          expect(User.count).to eq 2
        end
      end

      context 'when editing a non-existing user' do
        let(:id) { 500 }

        it "fails to edit a non-existing user" do
          expect(response.code).to eq "404"
        end
      end
    end

    context 'when authentication is NOT provided' do
      let(:headers) { basic_headers }

      it "returns an unauthorized code" do
        expect(response.code).to eq "401"
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
