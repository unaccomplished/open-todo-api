require 'rails_helper'

RSpec.describe List, type: :model do
  let(:user) { create(:user) }
  let(:list) { List.create!(user: user, title: 'List Title', private: false) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:items) }
end
