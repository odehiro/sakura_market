require 'rails_helper'

RSpec.describe LineItem, type: :model do
  let(:cart) { FactoryGirl.create(:cart_valid) }
  let(:food) { FactoryGirl.create(:food) }

  before do
    cart.reload
    food.reload
  end

  describe "line_item.create" do
    context "正常系" do
      it "valid" do
        line_item = LineItem.create(food_id: 1, cart_id: 1)
        expect(line_item).to be_valid
      end
    end

    context "存在しないIDが指定された場合エラー" do
      it "food_id invalid" do
        line_item = LineItem.create(food_id: 2, cart_id: 1)
        expect(line_item).not_to be_valid
      end
      it "cart_id invalid" do
        line_item = LineItem.create(food_id: 1, cart_id: 2)
        expect(line_item).not_to be_valid
      end
      it "both id invalid" do
        line_item = LineItem.create(food_id: 2, cart_id: 2)
        expect(line_item).not_to be_valid
      end
    end
  end
end
