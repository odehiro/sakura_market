require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "cart.create" do
    context "正常系" do
      it "create valid" do
        cart = Cart.create
        expect(cart).to be_valid
      end
    end
  end

  describe "cart.add_food" do
    let(:cart){ FactoryGirl.create(:cart_valid) }
    let(:food) { FactoryGirl.create(:food) }
    let(:food2) { FactoryGirl.create(:food2) }

    before do
      cart.line_items.create(food: food)
    end

    context "同じ品目の場合" do
      it "対象品目の個数が増えること" do
        line_item = cart.line_items.find_by_food_id(food.id)
        expect(line_item.quantity).to eq 1

        line_item = cart.add_food(food.id) 
        expect(line_item.quantity).to eq 2
      end
    end

    context "違う商品の場合" do
      it "品目が増えること" do
        line_item = cart.line_items.find_by_food_id(food.id)
        expect(line_item.quantity).to eq 1

        line_item = cart.add_food(food2.id) 
        expect(line_item.food_id).to eq food2.id
        expect(line_item.quantity).to eq 1
      end
    end
  end
end
