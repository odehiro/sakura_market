require 'rails_helper'

RSpec.feature "IndexPages", type: :request do
  subject { page }
  
  feature "GET /index_pages" do
    background { visit root_path }

    feature "項目確認" do
      scenario { is_expected.to have_http_status(200) }
      scenario { is_expected.to have_link("サインイン") }
    end

    feature "ヘッダー項目" do
      scenario { is_expected.to have_link("さくらマーケット", href: root_path) }
      scenario { is_expected.not_to have_link("日記を見る") }
      scenario { is_expected.not_to have_link("お買い物") }
      scenario { is_expected.not_to have_link("ショッピングカート") }
      scenario { is_expected.to have_link("ログイン", href: new_user_session_path) }
    end

    feature "devise#registrations/new" do
      scenario "サインイン画面へ遷移できること" do
        click_on "サインイン"
        expect(current_path).to eq new_user_registration_path
      end
    end

    feature "devise#sessions/new" do
      scenario "ログイン画面へ遷移できること" do
        click_on "ログイン"
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end
