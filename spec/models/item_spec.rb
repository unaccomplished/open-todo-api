require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  let(:list) { List.create!(user: user, title: "List Title") }
  let(:item) { Item.create!(text: "Sample to do item", list: list)}

  it { is_expected.to belong_to(:list) }
end
