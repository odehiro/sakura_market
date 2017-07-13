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

    feature "devise/registrations#new" do
      background do
        click_link 'ログアウト'
        visit new_user_registration_path
      end

      scenario "項目確認" do
        is_expected.to have_content('名前')
        is_expected.to have_content('メールアドレス')
        is_expected.to have_content('パスワード')
        is_expected.to have_content('確認用パスワード')
        is_expected.to have_content('Sign up')
      end

      scenario "一般ユーザーが登録できること" do
        fill_in '名前', with: 'テストユーザー'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: user.password
        fill_in '確認用パスワード', with: user.password
        expect { click_button 'Sign up' }.to change(User, :count).by(1)
        expect(page).to have_content 'アカウント登録が完了しました。'
        expect(current_path).to eq home_show_path
        #save_and_open_page
        click_link 'ログアウト'
      end
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
    
    feature "devise/registrations#edit" do
      background { visit edit_user_registration_path(user) }

      scenario "項目確認" do
        is_expected.to have_content('名前')
        is_expected.to have_content('メールアドレス')
        is_expected.to have_content('パスワード')
        is_expected.to have_content('確認用パスワード')
        is_expected.to have_content('現在のパスワード')
        is_expected.to have_button('Update')
      end

      scenario "自分アカウントを編集できること" do
        fill_in '名前', with: 'テストユーザー２'
        fill_in 'メールアドレス', with: 'test2@example.com'
        fill_in 'パスワード', with: 'foobar2'
        fill_in '確認用パスワード', with: 'foobar2'
        fill_in '現在のパスワード', with: user.password

        expect { click_button 'Update' }.not_to change(User, :count)
        expect(page).to have_content 'アカウント情報を変更しました。'
        
        #save_and_open_page
        #expect(current_path).to eq user_path(user)
        #FIXME: after_update_path_for()をOverrideできなかった
        visit user_path(user)
        #expect(user2.name).to eq 'テストユーザー２'
        #expect(page).to have_content 'テストユーザー２'
      end
    
      scenario "住所が登録できること" do
        fill_in '現在のパスワード', with: user.password
        fill_in '住所', with: user.to_address

        expect { click_button 'Update' }.not_to change(User, :count)
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
    end

    feature "#destroy" do
      scenario "ユーザーを削除できないこと"
    end

  end

  context "管理者のとき" do
    background do
      user.reload
      admin.reload

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

    #FIXME
    feature "#destroy" do
      scenario "ユーザーを削除できること" do
      #, js: true do
        visit users_path
        expect(page).to have_link '削除'

        #page.accept_confirm 'Are you sure?' do
        #  first('tbody tr').click_link '削除'
        #end
      end
    end
  end
end
