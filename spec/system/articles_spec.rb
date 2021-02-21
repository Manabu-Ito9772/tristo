require 'rails_helper'

RSpec.describe "Articles", type: :system do
  let(:article) { create(:article) }

  describe '記事一覧画面' do
    context '記事一覧画面にアクセス' do
      it '記事一覧が表示される' do
        article
        visit root_path
        expect(page).to have_content(article.title)
        expect(page).to have_content(article.description)
        expect(page).to have_content(article.region.name)
        page.save_screenshot 'screenshot.png'
      end
    end
  end
end
