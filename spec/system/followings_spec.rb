require 'rails_helper'

RSpec.describe 'フォロー/フォロワー', type: :system do
  let(:user) { create(:user) }
  let(:article_normal) { create(:article, :normal) }
  let(:another_user_article) { create(:article, :another_user) }

  describe 'マイページ' do
    before {
      article_normal
      another_user_article
      login_as(another_user_article.user)
      sleep 2
      click_on article_normal.user.name
      click_on 'フォロー'
      find('.fa-bars').click
      page.all('.dropdown-item')[1].click
      login_as(article_normal.user)
      sleep 2
      click_on another_user_article.user.name
      click_on 'フォロー'
      find('.fa-user').click
    }

    context 'フォローとフォロー数をクリック' do
      before { find('#following-count').click}

      it 'フォローしているユーザーを確認できる' do
        expect(current_path).to eq('/following')
        within('.follow-selected') do
          expect(page).to have_content('フォロー')
        end
        within('.follow-unselected') do
          expect(page).to have_content('フォロワー')
        end
        expect(page).to have_content(another_user_article.user.name)
        expect(page).to have_button('フォロー中')
      end

      context 'ユーザー名の隣の「フォロー中」をクリックし、確認ダイアログで「OK」をクリック' do
        before {
          page.accept_confirm do
            click_on 'フォロー中'
          end
        }

        it 'ユーザーのフォローを解除できる' do
          expect(page).to have_button('フォロー')
          visit current_path
          expect(page).to_not have_content(another_user_article.user.name)
        end

        context '「フォロー」をクリック' do
          it '再びユーザーをフォローできる' do
            click_on 'フォロー'
            expect(page).to have_content(another_user_article.user.name)
            expect(page).to have_button('フォロー中')
            visit current_path
            expect(page).to have_content(another_user_article.user.name)
            expect(page).to have_button('フォロー中')
          end
        end
      end

      context 'ユーザー名をクリック' do
        it 'そのユーザーのユーザー詳細ページに遷移' do
          find('#user-info').click
          expect(current_path).to eq('/user')
          expect(page).to have_content(another_user_article.user.name)
          expect(page).to have_content(another_user_article.user.description)
        end
      end

      context '「フォロワー」をクリック' do
        it 'フォロワーを確認できる' do
          find('.follow-unselected').click
          within('.follow-unselected') do
            expect(page).to have_content('フォロー')
          end
          within('.follow-selected') do
            expect(page).to have_content('フォロワー')
          end
          expect(page).to have_content(another_user_article.user.name)
          expect(page).to have_button('フォロー中')
        end
      end
    end

    context 'フォローとフォロー数をクリック' do
      before { find('#followers-count').click }

      it 'フォローしているユーザーを確認できる' do
        expect(current_path).to eq('/followers')
        within('.follow-unselected') do
          expect(page).to have_content('フォロー')
        end
        within('.follow-selected') do
          expect(page).to have_content('フォロワー')
        end
        expect(page).to have_content(another_user_article.user.name)
        expect(page).to have_button('フォロー中')
      end

      context 'ユーザー名の隣の「フォロー中」をクリックし、確認ダイアログで「OK」をクリック' do
        before {
          page.accept_confirm do
            click_on 'フォロー中'
          end
        }

        it 'ユーザーのフォローを解除できる' do
          expect(page).to have_button('フォロー')
          visit current_path
          expect(page).to have_content(another_user_article.user.name)
          find('.follow-unselected').click
          expect(page).to_not have_content(another_user_article.user.name)
        end

        context '「フォロー」をクリック' do
          it '再びユーザーをフォローできる' do
            click_on 'フォロー'
            expect(page).to have_content(another_user_article.user.name)
            expect(page).to have_button('フォロー中')
            visit current_path
            expect(page).to have_content(another_user_article.user.name)
            expect(page).to have_button('フォロー中')
          end
        end
      end

      context 'ユーザー名をクリック' do
        it 'そのユーザーのユーザー詳細ページに遷移' do
          find('#user-info').click
          expect(current_path).to eq('/user')
          expect(page).to have_content(another_user_article.user.name)
          expect(page).to have_content(another_user_article.user.description)
        end
      end

      context '「フォロー」をクリック' do
        it 'フォローしているユーザーを確認できる' do
          find('.follow-unselected').click
          within('.follow-selected') do
            expect(page).to have_content('フォロー')
          end
          within('.follow-unselected') do
            expect(page).to have_content('フォロワー')
          end
          expect(page).to have_content(another_user_article.user.name)
          expect(page).to have_button('フォロー中')
        end
      end
    end
  end

  describe 'ユーザーページ' do
    before {
      user
      article_normal
      another_user_article
      login_as(article_normal.user)
      sleep 2
      click_on another_user_article.user.name
      click_on 'フォロー'
      find('.fa-bars').click
      page.all('.dropdown-item')[1].click
      login_as(another_user_article.user)
      sleep 2
      click_on article_normal.user.name
      click_on 'フォロー'
      find('.fa-bars').click
      page.all('.dropdown-item')[1].click
      login_as(user)
      click_on another_user_article.user.name
    }

    context 'フォローボタンをクリック' do
      before { click_on 'フォロー' }

      it 'そのユーザーをフォローできる' do
        expect(page).to have_button('フォロー中')
        find('.fa-user').click
        find('#following-count').click
        expect(page).to have_content(another_user_article.user.name)
        expect(page).to have_button('フォロー中')
      end

      context 'フォロー中ボタンをクリック' do
        it 'フォローを解除できる' do
          page.accept_confirm do
            click_on 'フォロー中'
          end
          expect(page).to have_button('フォロー')
          find('.fa-user').click
          find('#following-count').click
          expect(page).to_not have_content(another_user_article.user.name)
        end
      end
    end

    context 'フォローとフォロー数をクリック' do
      before { find('#following-count').click}

      it 'フォローしているユーザーを確認できる' do
        expect(current_path).to eq('/following')
        within('.follow-selected') do
          expect(page).to have_content('フォロー')
        end
        within('.follow-unselected') do
          expect(page).to have_content('フォロワー')
        end
        expect(page).to have_content(article_normal.user.name)
      end

      context 'ユーザー名をクリック' do
        it 'そのユーザーのユーザー詳細ページに遷移' do
          find('#user-info').click
          expect(current_path).to eq('/user')
          expect(page).to have_content(article_normal.user.name)
          expect(page).to have_content(article_normal.user.description)
        end
      end

      context '「フォロワー」をクリック' do
        it 'フォロワーを確認できる' do
          find('.follow-unselected').click
          within('.follow-unselected') do
            expect(page).to have_content('フォロー')
          end
          within('.follow-selected') do
            expect(page).to have_content('フォロワー')
          end
          expect(page).to have_content(article_normal.user.name)
        end
      end
    end

    context 'フォロワーとフォロワー数をクリック' do
      before { find('#followers-count').click}

      it 'フォロワーを確認できる' do
        expect(current_path).to eq('/followers')
        within('.follow-unselected') do
          expect(page).to have_content('フォロー')
        end
        within('.follow-selected') do
          expect(page).to have_content('フォロワー')
        end
        expect(page).to have_content(article_normal.user.name)
      end

      context 'ユーザー名をクリック' do
        it 'そのユーザーのユーザー詳細ページに遷移' do
          find('#user-info').click
          expect(current_path).to eq('/user')
          expect(page).to have_content(article_normal.user.name)
          expect(page).to have_content(article_normal.user.description)
        end
      end

      context '「フォロー」をクリック' do
        it 'フォローしているユーザーを確認できる' do
          find('.follow-unselected').click
          within('.follow-selected') do
            expect(page).to have_content('フォロー')
          end
          within('.follow-unselected') do
            expect(page).to have_content('フォロワー')
          end
          expect(page).to have_content(article_normal.user.name)
        end
      end
    end
  end
end
