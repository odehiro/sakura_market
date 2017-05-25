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
end
