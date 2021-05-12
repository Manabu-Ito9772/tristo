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
    before { find('.comment').click }

    it 'コメント入力フォームが表示される' do
      expect(page).to have_field('コメント')
      expect(page).to have_css('.button')
    end

    context 'コメントを入力して投稿をクリック' do
      before {
        fill_in 'コメント', with: 'Comment'
        find('.button').click
      }

      it 'コメントが投稿される' do
        expect(page).to have_selector('#default-avatar')
        expect(page).to have_content(user.name)
        expect(page).to have_content('Comment')
      end

      context '編集ボタンをクリック' do
        before { find('.fa-edit').click }

        it '編集フォームが表示される' do
          within ('.comment-all') do
            expect(page).to have_field('コメント')
            expect(page).to have_content('保存')
          end
        end

        context 'コメントを編集して保存をクリック' do
          it 'コメントがアップデートされる' do
            within ('.comment-all') do
              fill_in 'コメント', with: 'UpdatedComment'
              find('.save-button').click
            end
            expect(page).to have_content('UpdatedComment')
            expect(page).to_not have_content('保存')
          end
        end

        context 'コメントを空欄にして保存をクリック' do
          it 'コメントがアップデートされない' do
            within ('.comment-all') do
              fill_in 'コメント', with: ''
              find('.save-button').click
              expect(page).to have_field('コメント')
              expect(page).to have_content('保存')
            end
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

    context 'コメントのユーザー名をクリック' do
      it 'ユーザー詳細に遷移' do
        fill_in 'コメント', with: 'Comment'
        find('.button').click
        find('.fa-bars').click
        page.all('.dropdown-item')[1].click
        login_as(another_user)
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find("#article-item-#{article_normal.id}").click
        find('.comment').click
        find("#user-name-#{user.id}").click
        sleep 2
        expect(current_path).to eq('/user')
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.description)
      end

      it 'マイページに遷移' do
        fill_in 'コメント', with: 'MyComment'
        find('.button').click
        find("#user-name-#{user.id}").click
        sleep 2
        expect(current_path).to eq('/mypage')
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.description)
      end
    end

    context 'コメントのユーザーアイコンをクリック' do
      it 'ユーザー詳細に遷移' do
        fill_in 'コメント', with: 'Comment'
        find('.button').click
        find('.fa-bars').click
        page.all('.dropdown-item')[1].click
        login_as(another_user)
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find("#article-item-#{article_normal.id}").click
        find('.comment').click
        sleep 2
        within('.comment-all') do
          find('.user-icon').click
        end
        sleep 2
        expect(current_path).to eq('/user')
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.description)
      end

      it 'マイページに遷移' do
        fill_in 'コメント', with: 'MyComment'
        find('.button').click
        within('.comment-all') do
          find('.user-icon').click
        end
        sleep 2
        expect(current_path).to eq('/mypage')
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.description)
      end
    end
  end

  describe '未ログイン状態' do
    it 'コメントフォーム、投稿ボタン、編集ボタン、ゴミ箱ボタンが表示されない' do
      find('.comment').click
      fill_in 'コメント', with: 'Comment'
      find('.button').click
      find('.fa-bars').click
      page.all('.dropdown-item')[1].click
      sleep 2
      visit '/trip_notes'
      sleep 2
      find('.area-changer-unselected').click
      sleep 2
      find("#article-item-#{article_normal.id}").click
      find('.comment').click
      expect(page).to_not have_field('コメント')
      expect(page).to_not have_button('投稿')
      expect(page).to have_css('#default-avatar')
      expect(page).to have_content(user.name)
      expect(page).to have_content('Comment')
      expect(page).to_not have_content('.fa-edit')
      expect(page).to_not have_content('.fa-trash-alt')
    end

    it 'コメントがない場合はコメントボタンが表示されない' do
      find('.fa-bars').click
      page.all('.dropdown-item')[1].click
      sleep 2
      visit '/trip_notes'
      sleep 2
      find('.area-changer-unselected').click
      sleep 2
      find("#article-item-#{article_normal.id}").click
      expect(page).to_not have_css('.comment')
      expect(page).to_not have_button('コメント')
    end

    context 'コメントのユーザー名をクリック' do
      it 'ユーザー詳細ページに遷移' do
        find('.comment').click
        fill_in 'コメント', with: 'Comment'
        find('.button').click
        find('.fa-bars').click
        page.all('.dropdown-item')[1].click
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find("#article-item-#{article_normal.id}").click
        find('.comment').click
        find("#user-name-#{user.id}").click
        sleep 2
        expect(current_path).to eq('/user')
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.description)
      end
    end

    context 'ユーザーアイコンをクリック' do
      it 'ユーザー詳細ページに遷移' do
        find('.comment').click
        fill_in 'コメント', with: 'Comment'
        find('.button').click
        find('.fa-bars').click
        page.all('.dropdown-item')[1].click
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find("#article-item-#{article_normal.id}").click
        find('.comment').click
        within('.comment-all') {
          find('.user-icon').click
        }
        sleep 2
        expect(current_path).to eq('/user')
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.description)
      end
    end
  end

  it '他人のコメントは編集/削除できない' do
    find('.comment').click
    fill_in 'コメント', with: 'Comment'
    find('.button').click
    find('.fa-bars').click
    page.all('.dropdown-item')[1].click
    login_as(another_user)
    sleep 2
    find('.area-changer-unselected').click
    sleep 2
    find("#article-item-#{article_normal.id}").click
    find('.comment').click
    sleep 2
    expect(page).to have_content(user.name)
    expect(page).to have_content('Comment')
    expect(page).to_not have_content('.fa-edit')
    expect(page).to_not have_content('.fa-trash-alt')
  end
end
