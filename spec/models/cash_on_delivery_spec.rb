require 'rails_helper'

RSpec.describe CashOnDelivery, type: :model do
  xdescribe ".create" do
    context "正常系" do
      it "create valid" do
        cash = CashOnDelivery.create
        expect(cash).to be_valid
      end
    end
  end
end
