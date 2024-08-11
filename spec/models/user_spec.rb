require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with validations' do
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:role).with_values(basic: 0, admin: 1) }
  end

  describe '.admin?' do
    subject { user.admin? }

    let(:user) { create(:user, role: role) }

    context "when the user is a basic user" do
      let(:role) { "basic" }

      it "returns a false value" do
        expect(subject).to be_falsey
      end
    end

    context "when the user is an admin" do
      let(:role) { "admin" }

      it "returns a true value" do
        expect(subject).to be_truthy
      end
    end
  end
end
