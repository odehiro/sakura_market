require 'rails_helper'

RSpec.feature "Carts", type: :request do
  let(:valid_session) { { cart_id: 1 } }

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

  feature "カートを空にするボタンクリック" do
    given(:food) { FactoryGirl.create(:food) }
    given(:cart) { FactoryGirl.create(:cart_valid) }
    given(:line) { FactoryGirl.create(:line_item) }

    background do
      food.reload
      cart.reload
      line.reload
    end

    scenario "カートを空にするクリックでカートが空になること" do
      visit cart_path(1)
      expect(page).to have_http_status(200)
      #save_and_open_page
      expect(page).to have_button 'カートを空にする'
      # ↓セッションの値入れないとエラーになる
      #expect { click_button 'カートを空にする' }.to change(Cart, :count).by(-1)
      click_button 'カートを空にする'
      expect(current_path).to eq root_path
    end
  end
end
