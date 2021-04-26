require 'rails_helper'

RSpec.describe 'トップページ', type: :system do
  let(:user) { create(:user) }
  let(:article_normal) { create(:article, :normal) }

  context 'ルートにアクセス' do
    it 'ログインしていない場合はトップページが表示される' do
      visit root_path
      expect(current_path).to eq('/')
      within('#buttons') do
        expect(page).to have_css('.register-btn')
      end
      expect(page).to have_css('.login-btn')
      expect(page).to have_css('.articles-btn')
      expect(page).to have_content('旅行記録作成の流れ')
      within('#click-now') do
        expect(page).to have_css('.register-btn')
      end
    end

    it 'ログインしている場合は記事一覧ページに遷移する' do
      article_normal
      login_as(user)
      visit '/'
      sleep 3
      expect(current_path).to eq('/trip_notes')
      find('.area-changer-unselected').click
      sleep 2
      expect(page).to have_content(article_normal.title)
    end
  end

  context 'ユーザー登録ボタンをクリック' do
    it 'ユーザー登録フォームが表示される' do
      visit root_path
      within('#buttons') do
        find('.register-btn').click
      end
      expect(current_path).to eq('/register')
      within('.container-fluid') do
        expect(page).to have_content('ユーザー登録')
      end
      expect(page).to have_field('ユーザーネーム')
      expect(page).to have_field('メールアドレス')
      expect(page).to have_field('パスワード')
      expect(page).to have_content('プロフィール画像')
      expect(page).to have_field('プロフィール画像')
      expect(page).to have_css('.user-icon')
      expect(page).to have_css('.button')
    end
  end

  context 'ログインボタンをクリック' do
    it 'ログインフォームが表示される' do
      visit root_path
      find('.login-btn').click
      expect(current_path).to eq('/login')
      within('.container-fluid') do
        expect(page).to have_content('ログイン')
      end
      expect(page).to have_field('メールアドレス')
      expect(page).to have_field('パスワード')
      expect(page).to have_css('.button')
    end
  end

  context '投稿一覧をクリック' do
    it '記事一覧ページが表示される' do
      article_normal
      visit root_path
      find('.articles-btn').click
      sleep 2
      expect(current_path).to eq('/trip_notes')
      find('.area-changer-unselected').click
      sleep 2
      expect(page).to have_content(article_normal.title)
    end
  end

  context '今すぐ始めるをクリック' do
    it 'ユーザー登録フォームが表示される' do
      visit root_path
      within('#buttons') do
        find('.register-btn').click
      end
      expect(current_path).to eq('/register')
      within('.container-fluid') do
        expect(page).to have_content('ユーザー登録')
      end
      expect(page).to have_field('ユーザーネーム')
      expect(page).to have_field('メールアドレス')
      expect(page).to have_field('パスワード')
      expect(page).to have_content('プロフィール画像')
      expect(page).to have_field('プロフィール画像')
      expect(page).to have_css('.user-icon')
      expect(page).to have_css('.button')
    end
  end
end