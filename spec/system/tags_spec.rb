require 'rails_helper'

RSpec.describe 'タグ', type: :system do
  let(:user) { create(:user) }
  let(:articles_normal) { create_list(:article, 2, :normal) }

  describe '記事一覧画面' do
    context 'タグをクリック' do
      it 'クリックしたタグで記事が検索される' do
        articles_normal
        login_as(articles_normal.first.user)
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find("#tag-#{articles_normal.first.tags.first.name}").click
        sleep 2
        expect(page).to have_content(articles_normal.first.title)
        expect(page).to_not have_content(articles_normal.second.title)
        within('.search') do
          expect(page).to have_content(articles_normal.first.tags.first.name)
        end
      end
    end
  end

  describe '記事詳細画面' do
    context 'タグをクリック' do
      it '記事一覧ページに遷移し、クリックしたタグで記事が検索される' do
        articles_normal
        login_as(articles_normal.first.user)
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find("#article-item-#{articles_normal.first.id}").click
        sleep 2
        find("#tag-#{articles_normal.first.tags.first.name}").click
        sleep 2
        expect(current_path).to eq('/trips')
        expect(page).to have_content(articles_normal.first.title)
        expect(page).to_not have_content(articles_normal.second.title)
        within('.search') do
          expect(page).to have_content(articles_normal.first.tags.first.name)
        end
      end
    end
  end

  describe 'マイページ' do
    context '投稿一覧の投稿のタグをクリック' do
      it '記事一覧ページに遷移し、クリックしたタグで記事が検索される' do
        articles_normal
        login_as(articles_normal.first.user)
        sleep 2
        find('.fa-user').click
        sleep 2
        find("#tag-#{articles_normal.first.tags.first.name}").click
        sleep 2
        expect(current_path).to eq('/trips')
        expect(page).to have_content(articles_normal.first.title)
        expect(page).to_not have_content(articles_normal.second.title)
        within('.search') do
          expect(page).to have_content(articles_normal.first.tags.first.name)
        end
      end
    end

    context '非公開一覧の投稿のタグをクリック' do
      it '記事一覧ページに遷移し、クリックしたタグで記事が検索される' do
        articles_normal
        login_as(articles_normal.first.user)
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find("#article-item-#{articles_normal.first.id}").click
        sleep 2
        find('#edit-menu').click
        find('#edit-btn').click
        sleep 2
        find('.draft-button').click
        sleep 2
        find("#tag-#{articles_normal.first.tags.first.name}").click
        sleep 2
        expect(current_path).to eq('/trips')
        expect(page).to_not have_content(articles_normal.first.title)
        expect(page).to_not have_content(articles_normal.second.title)
        within('.search') do
          expect(page).to have_content(articles_normal.first.tags.first.name)
        end
      end
    end

    context 'いいね一覧の投稿のタグをクリック' do
      it '記事一覧ページに遷移し、クリックしたタグで記事が検索される' do
        articles_normal
        login_as(articles_normal.first.user)
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        page.all('.heart')[1].click
        sleep 2
        find('.fa-user').click
        sleep 2
        page.all('.post-changer-unselect')[1].click
        sleep 2
        find("#tag-#{articles_normal.first.tags.first.name}").click
        sleep 2
        expect(current_path).to eq('/trips')
        expect(page).to have_content(articles_normal.first.title)
        expect(page).to_not have_content(articles_normal.second.title)
        within('.search') do
          expect(page).to have_content(articles_normal.first.tags.first.name)
        end
      end
    end
  end

  describe 'ユーザーページ' do
    context '投稿一覧の投稿のタグをクリック' do
      it '記事一覧ページに遷移し、クリックしたタグで記事が検索される' do
        articles_normal
        login_as(user)
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find("#article-user-#{articles_normal.first.user.id}").click
        sleep 2
        find("#tag-#{articles_normal.first.tags.first.name}").click
        sleep 2
        expect(page).to have_content(articles_normal.first.title)
        expect(page).to_not have_content(articles_normal.second.title)
        within('.search') do
          expect(page).to have_content(articles_normal.first.tags.first.name)
        end
      end
    end

    context 'いいね一覧の投稿のタグをクリック' do
      it '記事一覧ページに遷移し、クリックしたタグで記事が検索される' do
        articles_normal
        login_as(articles_normal.first.user)
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        page.all('.heart')[1].click
        find('.fa-bars').click
        page.all('.dropdown-item')[1].click
        login_as(user)
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find("#article-user-#{articles_normal.first.user.id}").click
        sleep 2
        find('.post-changer-unselect').click
        sleep 2
        find("#tag-#{articles_normal.first.tags.first.name}").click
        sleep 2
        expect(current_path).to eq('/trips')
        expect(page).to have_content(articles_normal.first.title)
        expect(page).to_not have_content(articles_normal.second.title)
        within('.search') do
          expect(page).to have_content(articles_normal.first.tags.first.name)
        end
      end
    end
  end
end
