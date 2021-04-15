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
      find('.area-changer-unselected').click
      sleep 2
      find("#article-user-#{article_normal.user.id}").click
      click_on 'フォロー'
      find('.fa-bars').click
      page.all('.dropdown-item')[1].click
      login_as(article_normal.user)
      sleep 2
      find("#article-user-#{another_user_article.user.id}").click
      click_on 'フォロー'
      find('.fa-user').click
    }

    context 'フォローとフォロー数をクリック' do
      before {
        find('#following-count').click
        sleep 2
      }

      it 'フォローしているユーザーを確認できる' do
        expect(current_path).to eq('/following')
        within('.follow-selected') do
          expect(page).to have_content('フォロー')
        end
        within('.follow-unselected') do
          expect(page).to have_content('フォロワー')
        end
        expect(page).to have_selector("img[src$='default-image.jpg']")
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
          find('.user-name').click
          sleep 2
          expect(current_path).to eq('/user')
          expect(page).to have_content(another_user_article.user.name)
          expect(page).to have_content(another_user_article.user.description)
        end
      end

      context 'ユーザーアイコンをクリック' do
        it 'そのユーザーのユーザー詳細ページに遷移' do
          find('.user-icon').click
          sleep 2
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

    context 'フォロワーとフォロワー数をクリック' do
      before {
        find('#followers-count').click
        sleep 2
      }

      it 'フォロワーを確認できる' do
        expect(current_path).to eq('/followers')
        within('.follow-unselected') do
          expect(page).to have_content('フォロー')
        end
        within('.follow-selected') do
          expect(page).to have_content('フォロワー')
        end
        expect(page).to have_selector("img[src$='default-image.jpg']")
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
          find('.user-name').click
          sleep 2
          expect(current_path).to eq('/user')
          expect(page).to have_content(another_user_article.user.name)
          expect(page).to have_content(another_user_article.user.description)
        end
      end

      context 'ユーザーアイコンをクリック' do
        it 'そのユーザーのユーザー詳細ページに遷移' do
          find('.user-icon').click
          sleep 2
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
      find('.area-changer-unselected').click
      sleep 2
      find("#article-user-#{another_user_article.user.id}").click
      click_on 'フォロー'
      find('.fa-bars').click
      page.all('.dropdown-item')[1].click
      login_as(another_user_article.user)
      sleep 2
      find("#article-user-#{article_normal.user.id}").click
      click_on 'フォロー'
      find('.fa-bars').click
      page.all('.dropdown-item')[1].click
      login_as(user)
      sleep 2
      find("#article-user-#{another_user_article.user.id}").click
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
      before {
        find('#following-count').click
        sleep 2
      }

      it 'フォローしているユーザーを確認できる' do
        expect(current_path).to eq('/following')
        within('.follow-selected') do
          expect(page).to have_content('フォロー')
        end
        within('.follow-unselected') do
          expect(page).to have_content('フォロワー')
        end
        expect(page).to have_selector("img[src$='default-image.jpg']")
        expect(page).to have_content(article_normal.user.name)
      end

      context 'ユーザー名をクリック' do
        it 'そのユーザーのユーザー詳細ページに遷移' do
          find('.user-name').click
          sleep 2
          expect(current_path).to eq('/user')
          expect(page).to have_content(article_normal.user.name)
          expect(page).to have_content(article_normal.user.description)
        end

        it 'マイページに遷移' do
          visit root_path
          sleep 2
          find("#article-user-#{another_user_article.user.id}").click
          sleep 2
          click_on 'フォロー'
          find('.fa-bars').click
          page.all('.dropdown-item')[1].click
          login_as(another_user_article.user)
          find('.fa-user').click
          find('#followers-count').click
          sleep 2
          click_on 'フォロー'
          find('.fa-bars').click
          page.all('.dropdown-item')[1].click
          login_as(user)
          sleep 2
          find("#article-user-#{another_user_article.user.id}").click
          sleep 2
          find('#following-count').click
          sleep 2
          page.all('.user-name')[0].click
          sleep 2
          expect(current_path).to eq('/mypage')
          expect(page).to have_content(user.name)
          expect(page).to have_content(user.description)
        end
      end

      context 'ユーザーアイコンをクリック' do
        it 'そのユーザーのユーザー詳細ページに遷移' do
          find('.user-icon').click
          sleep 2
          expect(current_path).to eq('/user')
          expect(page).to have_content(article_normal.user.name)
          expect(page).to have_content(article_normal.user.description)
        end

        it 'マイページに遷移' do
          visit root_path
          sleep 2
          find("#article-user-#{another_user_article.user.id}").click
          sleep 2
          click_on 'フォロー'
          find('.fa-bars').click
          page.all('.dropdown-item')[1].click
          login_as(another_user_article.user)
          find('.fa-user').click
          find('#followers-count').click
          sleep 2
          click_on 'フォロー'
          find('.fa-bars').click
          page.all('.dropdown-item')[1].click
          login_as(user)
          sleep 2
          find("#article-user-#{another_user_article.user.id}").click
          sleep 2
          find('#following-count').click
          sleep 2
          page.all('.user-icon')[0].click
          sleep 2
          expect(current_path).to eq('/mypage')
          expect(page).to have_content(user.name)
          expect(page).to have_content(user.description)
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
      before {
        find('#followers-count').click
        sleep 2
      }

      it 'フォロワーを確認できる' do
        expect(current_path).to eq('/followers')
        within('.follow-unselected') do
          expect(page).to have_content('フォロー')
        end
        within('.follow-selected') do
          expect(page).to have_content('フォロワー')
        end
        expect(page).to have_selector("img[src$='default-image.jpg']")
        expect(page).to have_content(article_normal.user.name)
      end

      context 'ユーザー名をクリック' do
        it 'そのユーザーのユーザー詳細ページに遷移' do
          find('.user-name').click
          sleep 2
          expect(current_path).to eq('/user')
          expect(page).to have_content(article_normal.user.name)
          expect(page).to have_content(article_normal.user.description)
        end

        it 'マイページに遷移' do
          visit root_path
          sleep 2
          find("#article-user-#{another_user_article.user.id}").click
          sleep 2
          click_on 'フォロー'
          find('#followers-count').click
          sleep 2
          page.all('.user-name')[0].click
          sleep 2
          expect(current_path).to eq('/mypage')
          expect(page).to have_content(user.name)
          expect(page).to have_content(user.description)
        end
      end

      context 'ユーザーアイコンをクリック' do
        it 'そのユーザーのユーザー詳細ページに遷移' do
          find('.user-icon').click
          sleep 2
          expect(current_path).to eq('/user')
          expect(page).to have_content(article_normal.user.name)
          expect(page).to have_content(article_normal.user.description)
        end

        it 'マイページに遷移' do
          visit root_path
          sleep 2
          find("#article-user-#{another_user_article.user.id}").click
          sleep 2
          click_on 'フォロー'
          find('#followers-count').click
          sleep 2
          page.all('.user-icon')[0].click
          sleep 2
          expect(current_path).to eq('/mypage')
          expect(page).to have_content(user.name)
          expect(page).to have_content(user.description)
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
