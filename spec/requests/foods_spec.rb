require 'rails_helper'

RSpec.feature "Foods", type: :request do
  subject { page }

  given(:user) { FactoryGirl.create(:user) }
  given(:admin) { FactoryGirl.create(:admin) }
  given(:food) { FactoryGirl.create(:food) }
  given(:food2) { FactoryGirl.create(:food2) }

  context "一般ユーザーのとき" do
    background do
      visit root_path
      click_link 'ログイン'

      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end
    
    feature "#index" do
      before do
        food.reload
        food2.reload
      end

      scenario "エラーなく商品一覧画面へ遷移すること" do
        visit foods_path
        expect(page).to have_http_status(:success)
      end
      
      scenario "並び順はorderの昇順であること" do
        visit foods_path
        expect(first('tbody tr')).to have_content food2.name
      end
    end

    feature "food#show" do
      background { visit food_path(food) }

      scenario "商品が表示されること" do
        expect(page).to have_http_status(200)
      end
    end

    feature "food#new" do
      scenario "権限がないたトップページに遷移すること" do
        visit new_food_path
        expect(current_path).to eq home_show_path
      end
    end
  end
  
  context "管理者のとき" do
    background do
      visit root_path
      click_link 'ログイン'

      fill_in 'メールアドレス', with: admin.email
      fill_in 'パスワード', with: admin.password
      click_button 'ログイン'
    end
    
    feature "food#index" do
      scenario "商品一覧画面へ遷移すること" do
        visit foods_path
        expect(page).to have_http_status(:success)
      end
    end

    feature "food#show" do
      background { visit food_path(food) }

      scenario "商品が表示されること" do
        expect(page).to have_http_status(200)
      end
    end

    feature "food#new/create" do
      scenario "生鮮食品登録" do
        visit new_food_path
        expect(page).to have_http_status(200)
        fill_in '商品名', with: '大根'
        attach_file '商品画像', "#{Rails.root}/spec/factories/test_image.png"
        fill_in '価格', with: 100
        fill_in '商品説明', with: '聖護院大根。今が旬！'
        expect(page).to have_checked_field('表示')
        fill_in '並び順', with: ''
        expect { click_on '登　録' }.to change(Food, :count).by(1)
        expect(page).to have_content '登録しました。'
        expect(current_path).to eq food_path(id: 1)
      end
    end

    feature "food#edit/update" do
      background { visit edit_food_path(food) }

      scenario "表示項目" do
        is_expected.to have_content "商品情報　更新"
        is_expected.to have_field('商品名', with: 'だいこん')
        is_expected.to have_field('価格', with: 200)
        is_expected.to have_field('商品説明', with: 'みずみずしい大根')
        is_expected.to have_checked_field('表示')
        is_expected.to have_link "Show"
      end
    end

    feature "food#edit/update" do
      background { visit edit_food_path(food) }

      scenario "表示項目" do
        #save_and_open_page
        is_expected.to have_content "商品情報　更新"
        is_expected.to have_field('商品名', with: 'だいこん')
        is_expected.to have_field('価格', with: 200)
        is_expected.to have_field('商品説明', with: 'みずみずしい大根')
        is_expected.to have_checked_field('表示')
        is_expected.to have_link "Show"
      end
    end

    feature "food#update" do
      given(:new_name) { "New Name" }
      given(:new_price) { 1500 }
      
      background do
        visit edit_food_path(food) 
        fill_in "商品名", with: new_name
        fill_in "価格", with: new_price
        click_button "更　新"
      end

      scenario "入力項目で更新できること" do
        is_expected.to have_content new_name
        is_expected.to have_content new_price
        is_expected.to have_content 'みずみずしい大根'
        is_expected.to have_content '表示 true'
        
        expect(food.reload.name).to eq new_name
        expect(food.reload.price).to eq new_price
      end
    end

    feature "food#delete" do
      background do
        food.reload
        visit foods_path
      end

      context "削除対象がカートに入ってないとき" do
        scenario "指定項目が削除できること" do
          expect(page).to have_http_status(200) 
          is_expected.to have_link "削除"
          expect { click_link '削除', match: :first }.to change(Food, :count).by(-1)
          expect(page).to have_content '商品を削除しました。'
          expect(current_path).to eq foods_path
        end
      end

      context "削除対象がカートに入っている場合" do
        let(:food) { FactoryGirl.create(:food) }
        let(:cart) { FactoryGirl.create(:cart_valid) }
        let(:line) { FactoryGirl.create(:line_item) }

        background do
          food.reload
          cart.reload
          line.reload
          visit foods_path
        end

        scenario "削除でエラーが出ること" do
          is_expected.to have_link "削除"
          expect { click_link '削除', match: :first }.not_to change(Food, :count)
          expect(page).to have_content '品目が存在します'
          expect(current_path).to eq foods_path
        end
      end
    end
  end
end
