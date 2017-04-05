require 'rails_helper'

RSpec.describe "foods/edit", type: :view do
  before(:each) do
    @food = assign(:food, Food.create!(
      :name => "MyString",
      :image => "",
      :price => 1,
      :caption => "MyText",
      :display => false,
      :order => "MyString"
    ))
  end

  it "renders the edit food form" do
    render

    assert_select "form[action=?][method=?]", food_path(@food), "post" do

      assert_select "input#food_name[name=?]", "food[name]"

      assert_select "input#food_image[name=?]", "food[image]"

      assert_select "input#food_price[name=?]", "food[price]"

      assert_select "textarea#food_caption[name=?]", "food[caption]"

      assert_select "input#food_display[name=?]", "food[display]"

      assert_select "input#food_order[name=?]", "food[order]"
    end
  end
end
