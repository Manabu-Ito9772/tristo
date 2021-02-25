require 'rails_helper'

RSpec.describe "Articles", type: :system do
  let(:article) { create(:article) }
  let(:info_block) { create(:with_cost) }

  describe '記事一覧画面' do
    context '記事一覧画面にアクセス' do
      it '記事一覧が表示される' do
        article
        visit root_path
        expect(page).to have_content(article.title)
        expect(page).to have_content(article.description)
        expect(page).to have_content(article.region.name)
      end
    end
  end

  describe '記事詳細画面' do
    context '記事一覧画面から記事詳細画面にアクセス' do
      it '記事詳細が表示される' do
        info_block
        visit root_path
        find('.article-main').click
        expect(page).to have_content('TestEvent1')
        expect(page).to have_content('TestPlace1')
        expect(page).to have_content('https://manabu-ito.hatenablog.com/archive')
        expect(page).to have_content('TestComment1')
        expect(page).to have_content('TestSpending1')
        expect(page).to have_content('TestTransportation1')
        page.save_screenshot 'screenshot.png'
      end
    end
  end
end
