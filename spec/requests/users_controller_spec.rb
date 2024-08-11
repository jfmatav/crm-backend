require 'rails_helper'

RSpec.describe "UsersControllers", type: :request do
  let(:user) { create(:user, role: "admin") }
  let(:headers) { {'Authorization' => "Bearer #{get_authentication(user)}"} }

  describe "GET /users" do
    context 'when authentication is provided' do
      it 'failing test' do
        skip
        get users_path
        expect(1).to eq 0
      end
    end

    context 'when authentication is NOT provided' do
      pending
    end
  end

  describe "POST /users" do
    pending
  end

  describe "GET /users" do
    pending
  end

  describe "PUT /users" do
    pending
  end

  describe "DELETE /users" do
    pending
  end
end
