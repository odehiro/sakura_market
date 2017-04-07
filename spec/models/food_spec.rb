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

  before do
    #path = Rails.root.join("画像が置いてあるパス")
    #testImage = File.open(path, "rb").read
    @food = Food.new(
      name: "玄米",
      image: "",
      price: 1000,
      caption: "発芽すると栄養豊富",
      display: true,
      order: ""
    )
  end

  subject { @food }

  it { should be_valid }

  describe "名称が空白でないこと" do
    before {@food.name = ""}
    it { should_not be_valid }
  end

  describe "金額が空白でないこと" do
    before {@food.price = ""}
    it { should_not be_valid }
  end

  describe "商品説明が空白でないこと" do
    before {@food.caption = ""}
    it { should_not be_valid }
  end
end
