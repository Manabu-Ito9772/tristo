require 'rails_helper'

RSpec.describe '404ページ', type: :system do
  let(:article_draft) { create(:article, :draft) }

  context '存在しないページにアクセス' do
    before { visit 'aaaaaaaa' }

    it '404ページが表示される' do
      expect(page).to have_content('404 NotFound')
      expect(page).to have_css('.button')
    end

    context '「トップページに戻る」をクリック' do
      it '投稿一覧に遷移' do
        find('.button').click
        expect(current_path).to eq('/trip_notes')
      end
    end
  end

  context '記事IDで他人の非公開記事にアクセス' do
    before {
      article_draft
      visit "/trip_note?id=#{article_draft.id}"
    }

    it '404ページが表示される' do
      expect(page).to have_content('404 NotFound')
      expect(page).to have_css('.button')
    end

    context '「トップページに戻る」をクリック' do
      it '投稿一覧に遷移' do
        find('.button').click
        expect(current_path).to eq('/trip_notes')
      end
    end
  end
end
