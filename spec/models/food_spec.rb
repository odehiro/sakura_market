require 'rails_helper'

RSpec.describe Food, type: :model do
  it "商品の項目 商品名,商品画像,価格（業者を超えても同一価格）,説明文,
    非表示フラグ,表示順" do
    is_expected.to respond_to(:name)
    is_expected.to respond_to(:image)
    is_expected.to respond_to(:price)
    is_expected.to respond_to(:caption)
    is_expected.to respond_to(:display)
    is_expected.to respond_to(:order)
  end
end
