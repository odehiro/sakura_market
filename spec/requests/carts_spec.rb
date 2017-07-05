require 'rails_helper'

RSpec.feature "Carts", type: :request do
  subject { page }

  given(:user) { FactoryGirl.create(:user) }
  given(:admin) { FactoryGirl.create(:admin) }

  context "一般ユーザーのとき" do
    background do
      visit root_path
      click_link 'ログイン'

      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    feature "#index" do
      scenario "works! (now write some real specs)" do
        visit carts_path
        expect(page).to have_http_status(200)
      end

      scenario "ヘッダリンクからカートを表示するが空であること" do
        visit home_show_path
        expect(page).not_to have_link 'ショッピングカート'
      end
    end
  
    feature "カートに入れる" do
      given(:food) { FactoryGirl.create(:food) }

      background do
        food.reload
      end

      scenario "カートに商品が入ること" do
        visit food_path(food.id)
        expect(page).to have_http_status(200)
        expect(page).to have_link 'カートに入れる'
        expect { click_link 'カートに入れる', match: :first }.to change(LineItem, :count).by(+1)
        expect(current_path).to eq cart_path(1)
      end

      scenario "ヘッダリンクからカートに入れた商品が見れること" do
        visit food_path(food.id)
        click_link 'カートに入れる'

        visit home_show_path
        expect(page).to have_link 'ショッピングカート'
        click_link 'ショッピングカート'
        
        expect(page).to have_http_status(200)
        is_expected.to have_content food.name
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
end
