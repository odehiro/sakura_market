require 'rails_helper'

RSpec.describe "foods/index", type: :view do
  before(:each) do
    assign(:foods, [
      Food.create!(
        :name => "Name",
        :image => "",
        :price => 2,
        :caption => "MyText",
        :display => false,
        :order => "Order"
      ),
      Food.create!(
        :name => "Name",
        :image => "",
        :price => 2,
        :caption => "MyText",
        :display => false,
        :order => "Order"
      )
    ])
  end

  it "renders a list of foods" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Order".to_s, :count => 2
  end
end
