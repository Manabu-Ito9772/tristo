require 'rails_helper'

RSpec.describe 'コメント', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user, :another_user) }
  let(:article_normal) { create(:article, :normal) }

  before {
    article_normal
    login_as(user)
    sleep 2
    find('.area-changer-unselected').click
    sleep 2
    find("#article-item-#{article_normal.id}").click
  }

  context '記事詳細ページのコメントボタンをクリック' do
    before {
      click_on 'コメント'
    }

    it 'コメント入力フォームが表示される' do
      expect(page).to have_field('コメント')
      expect(page).to have_button('投稿')
    end

    context 'コメントを入力して投稿をクリック' do
      before {
        fill_in 'コメント', with: 'Comment'
        click_on '投稿'
      }

      it 'コメントが投稿される' do
        expect(page).to have_content(user.name)
        expect(page).to have_content('Comment')
      end

      context '編集ボタンをクリック' do
        before {
          find('.fa-edit').click
        }

        it '編集フォームが表示される' do
          expect(page).to have_field('コメント編集')
          expect(page).to have_content('保存')
        end

        context 'コメントを編集して保存をクリック' do
          it 'コメントがアップデートされる' do
            fill_in 'コメント編集', with: 'UpdatedComment'
            find('.save-button').click
            expect(page).to have_content('UpdatedComment')
            expect(page).to_not have_content('保存')
          end
        end
      end

      context 'ゴミ箱ボタンをクリックして、確認モーダルで「OK」をクリック' do
        it 'コメントが削除される' do
          page.accept_confirm do
            find('.fa-trash-alt').click
          end
          expect(page).to_not have_content('Comment')
        end
      end
    end

    context 'コメントのユーザー名もしくはユーザーアイコンをクリック' do
      it 'ユーザー詳細/マイページに遷移' do
        fill_in 'コメント', with: 'Comment'
        click_on '投稿'
        find('.fa-bars').click
        page.all('.dropdown-item')[1].click
        login_as(another_user)
        sleep 2
        find("#article-item-#{article_normal.id}").click
        click_on 'コメント'
        find("#user-name-#{user.id}").click
        expect(current_path).to eq('/user')
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.description)
        visit root_path
        sleep 2
        find("#article-item-#{article_normal.id}").click
        click_on 'コメント'
        fill_in 'コメント', with: 'MyComment'
        click_on '投稿'
        find("#user-name-#{another_user.id}").click
        expect(current_path).to eq('/mypage')
        expect(page).to have_content(another_user.name)
        expect(page).to have_content(another_user.description)
      end
    end
  end

  describe '未ログイン状態' do
    it 'コメントフォーム、投稿ボタン、編集ボタン、ゴミ箱ボタンが表示されない' do
      click_on 'コメント'
      fill_in 'コメント', with: 'Comment'
      click_on '投稿'
      find('.fa-bars').click
      page.all('.dropdown-item')[1].click
      sleep 2
      visit root_path
      sleep 2
      find("#article-item-#{article_normal.id}").click
      click_on 'コメント'
      expect(page).to_not have_field('コメント')
      expect(page).to_not have_button('投稿')
      expect(page).to have_content(user.name)
      expect(page).to have_content('Comment')
      expect(page).to_not have_content('.fa-edit')
      expect(page).to_not have_content('.fa-trash-alt')
    end

    it 'コメントがない場合はコメントボタンが表示されない' do
      find('.fa-bars').click
      page.all('.dropdown-item')[1].click
      sleep 2
      visit root_path
      sleep 2
      find("#article-item-#{article_normal.id}").click
      expect(page).to_not have_css('.comment')
      expect(page).to_not have_button('コメント')
    end

    context 'コメントのユーザー名もしくはユーザーアイコンをクリック' do
      it 'ユーザー詳細ページに遷移' do
        click_on 'コメント'
        fill_in 'コメント', with: 'Comment'
        click_on '投稿'
        find('.fa-bars').click
        page.all('.dropdown-item')[1].click
        visit root_path
        sleep 2
        find("#article-item-#{article_normal.id}").click
        click_on 'コメント'
        find("#user-name-#{user.id}").click
        sleep 2
        expect(current_path).to eq('/user')
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.description)
      end
    end
  end

  it '他人のコメントは編集/削除できない' do
    click_on 'コメント'
    fill_in 'コメント', with: 'Comment'
    click_on '投稿'
    find('.fa-bars').click
    page.all('.dropdown-item')[1].click
    login_as(another_user)
    sleep 2
    find("#article-item-#{article_normal.id}").click
    click_on 'コメント'
    expect(page).to have_content(user.name)
    expect(page).to have_content('Comment')
    expect(page).to_not have_content('.fa-edit')
    expect(page).to_not have_content('.fa-trash-alt')
  end
end
