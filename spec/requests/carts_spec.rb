require 'rails_helper'

RSpec.feature "Carts", type: :request do
  feature "GET /carts" do
    scenario "works! (now write some real specs)" do
      visit carts_path
      expect(page).to have_http_status(200)
    end
  end

  feature "カートに入れる" do
    given(:food) { FactoryGirl.create(:food) }

    background do
      food.reload
    end

    scenario "カートに商品が入ること" do
      visit foods_path
      expect(page).to have_http_status(200)
      expect(page).to have_link 'カートに入れる'
      expect { click_link 'カートに入れる', match: :first }.to change(LineItem, :count).by(+1)
      expect(current_path).to eq cart_path(1)
    end
  end
end
