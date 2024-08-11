require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:surname) }
    it { is_expected.to validate_presence_of(:cx_id) }
  end
end
