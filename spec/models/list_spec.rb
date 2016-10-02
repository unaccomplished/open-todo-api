require 'rails_helper'

RSpec.describe List, type: :model do
  let(:user) { create(:user) }
  let(:list) { List.create!(user: user, title: 'List Title', permissions: 'open') }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:items) }

  describe "attributes" do
    it "responds to permissions" do
      expect(list).to respond_to(:permissions)
    end

    it "responds to open?" do
      expect(list).to respond_to(:open?)
    end

    it "responds to viewable?" do
      expect(list).to respond_to(:viewable?)
    end

    it "responds to admin_only?" do
      expect(list).to respond_to(:admin_only?)
    end
  end

  describe "permissions" do
    it "is open by default" do
      expect(list.permissions).to eq("open")
    end

    context "open list" do
      it "returns true for #open?" do
        expect(list.open?).to be_truthy
      end

      it "returns false for #viewable?" do
        expect(list.viewable?).to be_falsey
      end

      it "returns false for #admin_only?" do
        expect(list.admin_only?).to be_falsey
      end
    end

    context "viewable list" do
      before do
        list.viewable!
      end

      it "returns false for #open?" do
        expect(list.open?).to be_falsey
      end

      it "returns true for #viewable?" do
        expect(list.viewable?).to be_truthy
      end

      it "returns false for #admin_only?" do
        expect(list.admin_only?).to be_falsey
      end
    end

    context "private list" do
      before do
        list.admin_only!
      end

      it "returns false for #open?" do
        expect(list.open?).to be_falsey
      end

      it "returns false for #viewable?" do
        expect(list.viewable?).to be_falsey
      end

      it "returns true for #admin_only?" do
        expect(list.admin_only?).to be_truthy
      end
    end
  end
end
