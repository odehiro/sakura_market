require 'rails_helper'

RSpec.feature "User pages", type: :request do
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
      background { visit users_path }

      scenario "表示されないこと" do
        expect(page).to have_http_status(:success)
        expect(current_path).to eq home_show_path
      end
    end

    feature "#show" do
      scenario "自分の情報は表示されること" do
        visit user_path(user)
        expect(page).to have_http_status(:success)
        expect(current_path).to eq user_path(user)

        expect(page).to have_content user.name
      end
      
      scenario "自分以外の情報は表示されないこと" do
        visit user_path(admin)
        #save_and_open_page
        expect(page).to have_http_status(:success)
        expect(current_path).not_to eq user_path(admin)
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

    feature "#index" do
      background { visit users_path }

      scenario "登録されているユーザーが表示されること" do
        expect(page).to have_http_status(:success)
        expect(current_path).to eq users_path

        expect(page).to have_content user.name
        expect(page).to have_content admin.name
      end 
    end

    feature "#show" do
      background { visit user_path(admin) }

      scenario "ログインユーザーの情報が表示できること" do
        expect(page).to have_http_status(:success)
        expect(current_path).to eq user_path(admin)

        expect(page).to have_content admin.name
      end

      scenario "自分以外の情報も表示できること" do
        visit user_path(user)

        expect(page).to have_http_status(:success)
        expect(current_path).to eq user_path(user)
      end
    end
  end

  feature "devise#registrations" do
    background { visit new_user_registration_path }

    scenario "項目確認" do
      is_expected.to have_content('Sign up') 
    end

    scenario "一般ユーザー登録"
  end

  feature "#edit" do
    scenario "ユーザー情報を更新できること"
  end
  feature "#destroy" do
    scenario "ユーザーを削除できること"
  end
end
