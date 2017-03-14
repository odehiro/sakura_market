require 'rails_helper'

RSpec.describe "SiteLayouts", type: :request do
  describe "GET /site_layouts" do
    it "layout links" do
      visit root_path
      expect(page).to have_http_status(200)
      #expect(page).to have_selector 'a'
      expect(page).to have_link 'さくらマーケット'
      expect(page).to have_link '日記を見る'
      expect(page).to have_link 'お買い物'
      expect(page).to have_link 'ショッピングカート'
      expect(page).to have_link 'ログアウト'
    end
  end
end
