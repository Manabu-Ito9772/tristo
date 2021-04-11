require 'rails_helper'

RSpec.describe 'いいね', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user, :another_user) }
  let(:article_normal) { create(:article, :normal) }
  let(:another_user_article) { create(:article, :another_user) }
  let(:country_japan) { create(:country, :japan_tokyo_kanagawa) }

  describe '記事一覧画面' do
    context '記事のハートボタンをクリック' do
      before {
        article_normal
        login_as(user)
        sleep 3
        find('.area-changer-unselected').click
        sleep 3
        find('.heart').click
      }

      it 'その記事をいいねできる' do
        within('#heart-favorited') do
          expect(page).to have_css('.fa-heart')
        end
        within('.favorite-count') do
          expect(page).to have_content('1')
        end
      end

      context '再度ハートボタンをクリック' do
        it 'その記事のいいねを解除できる' do
          find('.heart-favorited').click
          within('#heart') do
            expect(page).to have_css('.fa-heart')
          end
          expect(page).to_not have_css('.favorite-count')
        end
      end

      context 'ログアウトして記事一覧画面にアクセス' do
        it '記事にクリック不可のハートボタンが表示される' do
          find('.fa-bars').click
          page.all('.dropdown-item')[1].click
          visit root_path
          within('#heart-notlogin') do
            expect(page).to have_css('.fa-heart')
          end
          within('.favorite-count') do
            expect(page).to have_content('1')
          end
        end
      end
    end
  end

  describe '記事詳細画面' do
    context 'ハートボタンをクリック' do
      before {
        article_normal
        login_as(user)
        sleep 3
        find('.area-changer-unselected').click
        sleep 3
        find("#article-item-#{article_normal.id}").click
        find('.heart').click
      }

      it 'その記事をいいねできる' do
        within('#heart-favorited') do
          expect(page).to have_css('.fa-heart')
        end
        within('.favorites') do
          expect(page).to have_content('1')
        end
      end

      context '再度ハートボタンをクリック' do
        it 'その記事のいいねを解除できる' do
          find('.heart-favorited').click
          within('#heart') do
            expect(page).to have_css('.fa-heart')
          end
          expect(page).to_not have_css('.favorites')
        end
      end

      context 'ログアウトして記事詳細画面にアクセス' do
        it '記事にクリック不可のハートボタンが表示される' do
          find('.fa-bars').click
          page.all('.dropdown-item')[1].click
          visit root_path
          find("#article-item-#{article_normal.id}").click
          within('#heart-notlogin') do
            expect(page).to have_css('.fa-heart')
          end
          within('.favorites') do
            expect(page).to have_content('1')
          end
        end
      end
    end
  end

  describe 'ユーザー詳細ページ' do
    before {
      article_normal
      another_user_article
      login_as(article_normal.user)
      sleep 3
      find('.area-changer-unselected').click
      sleep 3
      page.all('.heart')[0].click
      find('.fa-bars').click
      page.all('.dropdown-item')[1].click
      login_as(user)
      sleep 3
      find("#article-user-#{article_normal.user.id}").click
      sleep 3
    }

    describe '投稿記事' do
      context '記事のハートボタンをクリック' do
        before{ find('.heart').click }

        it 'その記事をいいねできる' do
          within('#heart-favorited') do
            expect(page).to have_css('.fa-heart')
          end
          within('.favorite-count') do
            expect(page).to have_content('1')
          end
        end

        context '再度ハートボタンをクリック' do
          it 'その記事のいいねを解除できる' do
            find('.heart-favorited').click
            within('#heart') do
              expect(page).to have_css('.fa-heart')
            end
            expect(page).to_not have_css('.favorite-count')
          end
        end

        context 'ログアウトしてユーザー詳細ページにアクセス' do
          it '投稿記事にクリック不可のハートボタンが表示される' do
            find('.fa-bars').click
            page.all('.dropdown-item')[1].click
            visit root_path
            sleep 3
            find("#article-user-#{article_normal.user.id}").click
            within('#heart-notlogin') do
              expect(page).to have_css('.fa-heart')
            end
            within('.favorite-count') do
              expect(page).to have_content('1')
            end
          end
        end
      end
    end

    describe 'いいねした記事' do
      before {
        find('.post-changer-unselect').click
        sleep 3
      }

      context '記事のハートボタンをクリック' do
        before{ find('.heart').click }

        it 'その記事をいいねできる' do
          within('#heart-favorited') do
            expect(page).to have_css('.fa-heart')
          end
          within('.favorite-count') do
            expect(page).to have_content('2')
          end
        end

        context '再度ハートボタンをクリック' do
          it 'その記事のいいねを解除できる' do
            find('.heart-favorited').click
            within('#heart') do
              expect(page).to have_css('.fa-heart')
            end
            within('.favorite-count') do
              expect(page).to have_content('1')
            end
          end
        end

        context 'ログアウトしてユーザー詳細ページにアクセスし、いいね一覧を表示' do
          it 'いいねした記事にクリック不可のハートボタンが表示される' do
            find('.fa-bars').click
            page.all('.dropdown-item')[1].click
            visit root_path
            sleep 3
            find("#article-user-#{article_normal.user.id}").click
            sleep 3
            find('.post-changer-unselect').click
            within('#heart-notlogin') do
              expect(page).to have_css('.fa-heart')
            end
            within('.favorite-count') do
              expect(page).to have_content('2')
            end
          end
        end
      end
    end
  end

  describe 'マイページ' do
    before {
      country_japan
      article_normal
      another_user_article
      login_as(article_normal.user)
      sleep 3
      find('.area-changer-unselected').click
      sleep 3
      page.all('.heart')[0].click
      visit '/create_trip'
      fill_in 'タイトル', with: 'TestTitle'
      within('.prefecture') do
        find('.vs__search').set('東京')
        find('.vs__dropdown-menu').click
      end
      click_on '詳細入力ページへ進む'
      sleep 3
      find('.draft-button').click
      sleep 3
      page.all('.post-changer-unselect')[0].click
      sleep 3
    }

    describe '投稿記事' do
      context '記事のハートボタンをクリック' do
        before{ find('.heart').click }

        it 'その記事をいいねできる' do
          within('#heart-favorited') do
            expect(page).to have_css('.fa-heart')
          end
          within('.favorite-count') do
            expect(page).to have_content('1')
          end
        end

        context '再度ハートボタンをクリック' do
          it 'その記事のいいねを解除できる' do
            find('.heart-favorited').click
            within('#heart') do
              expect(page).to have_css('.fa-heart')
            end
            expect(page).to_not have_css('.favorite-count')
          end
        end
      end
    end

    describe '下書き記事' do
      before {
        page.all('.post-changer-unselect')[0].click
        sleep 3
      }

      it 'ハートボタンが表示されない' do
        expect(page).to_not have_css('.fa-heart')
        expect(page).to_not have_css('.heart')
        expect(page).to_not have_css('.heart-favorited')
      end
    end

    describe '投稿記事' do
      before {
        page.all('.post-changer-unselect')[1].click
        sleep 3
      }

      context '記事のハートボタンをクリック' do
        before{ find('.heart-favorited').click }

        it 'その記事のいいねを解除できる' do
          within('#heart') do
            expect(page).to have_css('.fa-heart')
          end
          expect(page).to_not have_css('.favorite-count')
          visit '/mypage'
          sleep 3
          page.all('.post-changer-unselect')[1].click
          sleep 3
          expect(page).to have_content('いいねした投稿がありません')
        end
      end
    end
  end
end
