require 'rails_helper'

RSpec.describe 'ユーザー', type: :system do
  let(:user) { create(:user) }
  let(:country_japan) { create(:country, :japan_tokyo_kanagawa) }
  let(:article_normal) { create(:article, :normal) }

  describe 'ユーザー登録' do
    context 'ユーザー登録ボタンをクリック' do
      before {
        visit root_path
        find('.register-button').click
      }

      it 'フォームが表示される' do
        within('.container-fluid') do
          expect(page).to have_content('ユーザー登録')
        end
        expect(page).to have_field('ユーザーネーム')
        expect(page).to have_field('メールアドレス')
        expect(page).to have_field('パスワード')
        expect(page).to have_button('登録')
      end

      context 'フォームを入力して「登録」をクリック' do
        it 'ユーザーが登録され記事一覧ページに遷移' do
          fill_in 'ユーザーネーム', with: 'TestUser'
          fill_in 'メールアドレス', with: 'test@test.com'
          fill_in 'パスワード', with: 'password'
          click_on '登録'
          sleep 3
          expect(current_path).to eq('/trips')
          find('.fa-user').click
          expect(page).to have_content('TestUser')
        end
      end

      context '何も入力せずに「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          click_on '登録'
          expect(page).to have_content('ユーザーネームは必須項目です')
          expect(page).to have_content('メールアドレスは必須項目です')
          expect(page).to have_content('パスワードは必須項目です')
        end
      end

      context '不適切な形式のメールアドレスを入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'メールアドレス', with: 'test'
          click_on '登録'
          expect(page).to have_content('メールアドレスの形式で入力してください')
        end
      end

      context '既に存在しているメールアドレスを入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          user
          fill_in 'ユーザーネーム', with: 'TestUser'
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password'
          click_on '登録'
          sleep 3
          expect(page).to have_content('このメールアドレスは既に使われています')
        end
      end

      context 'パスワードを半角英数字以外で入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'パスワード', with: 'テスト'
          click_on '登録'
          expect(page).to have_content('半角英数字で入力してください')
        end
      end

      context 'パスワードを5文字未満で入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'パスワード', with: 'aaaa'
          click_on '登録'
          expect(page).to have_content('パスワードは5文字以上で入力してください')
        end
      end

      context 'パスワードを入力して目のアイコンをクリック' do
        it 'パスワードの表示非表示が切り替わる' do
          fill_in 'パスワード', with: 'password'
          find('.fa-eye').click
          expect(page).to have_css('.fa-eye-slash')
          find('.fa-eye-slash').click
          expect(page).to have_css('.fa-eye')
        end
      end
    end
  end

  describe 'ログイン' do
    context 'ログインボタンをクリック' do
      before {
        user
        visit root_path
        find('.login-button').click
      }

      it 'フォームが表示される' do
        within('.container-fluid') do
          expect(page).to have_content('ログイン')
        end
        expect(page).to have_field('メールアドレス')
        expect(page).to have_field('パスワード')
        expect(page).to have_button('ログイン')
      end

      context 'フォームを入力して「ログイン」をクリック' do
        it 'ログインして記事一覧ページに遷移' do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password'
          find('.button').click
          sleep 3
          expect(current_path).to eq('/trips')
          find('.fa-user').click
          expect(page).to have_content(user.name)
        end
      end

      context '何も入力せずに「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          find('.button').click
          expect(page).to have_content('メールアドレスを入力してください')
          expect(page).to have_content('パスワードを入力してください')
        end
      end

      context '不適切な形式のメールアドレスを入力して「ログイン」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'メールアドレス', with: 'test'
          find('.button').click
          expect(page).to have_content('メールアドレスの形式で入力してください')
        end
      end

      context '間違えたメールアドレスを入力して「ログイン」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'メールアドレス', with: 'wrong@test.com'
          fill_in 'パスワード', with: 'password'
          find('.button').click
          sleep 3
          expect(page).to have_content('メールアドレスまたはパスワードが正しくありません')
        end
      end

      context 'パスワードを半角英数字以外で入力して「ログイン」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'パスワード', with: 'テスト'
          find('.button').click
          expect(page).to have_content('半角英数字で入力してください')
        end
      end

      context '間違えたパスワードを入力して「ログイン」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'wrong'
          find('.button').click
          sleep 3
          expect(page).to have_content('メールアドレスまたはパスワードが正しくありません')
        end
      end

      context 'パスワードを入力して目のアイコンをクリック' do
        it 'パスワードの表示非表示が切り替わる' do
          fill_in 'パスワード', with: 'password'
          find('.fa-eye').click
          expect(page).to have_css('.fa-eye-slash')
          find('.fa-eye-slash').click
          expect(page).to have_css('.fa-eye')
        end
      end
    end

    context 'ログインせずに記事一覧、記事詳細、ユーザーページにアクセス' do
      it 'アクセスできる' do
        article_normal
        visit 'trips'
        expect(current_path).to eq('/trips')
        expect(page).to have_content(article_normal.title)
        click_on article_normal.title
        expect(current_path).to eq('/trip')
        expect(page).to have_content(article_normal.title)
        visit 'trips'
        click_on article_normal.user.name
        expect(current_path).to eq('/user')
        expect(page).to have_content(article_normal.user.name)
      end
    end

    context 'ログインせずに記事作成、記事詳細作成、マイページ、プロフィール編集、アカウント設定にアクセス' do
      it 'ログインページに遷移する' do
        visit 'create_trip'
        expect(current_path).to eq('/login')
        within('.container-fluid') do
          expect(page).to have_content('ログイン')
        end
        visit 'create_trip_detail'
        expect(current_path).to eq('/login')
        within('.container-fluid') do
          expect(page).to have_content('ログイン')
        end
        visit 'mypage'
        expect(current_path).to eq('/login')
        within('.container-fluid') do
          expect(page).to have_content('ログイン')
        end
        visit 'edit_mypage'
        expect(current_path).to eq('/login')
        within('.container-fluid') do
          expect(page).to have_content('ログイン')
        end
        visit 'account_settings'
        expect(current_path).to eq('/login')
        within('.container-fluid') do
          expect(page).to have_content('ログイン')
        end
      end
    end
  end

  describe 'マイページ' do
    before {
      country_japan
      login_as(user)
      find('.fa-pen').click
      fill_in 'タイトル', with: 'TestTitleDraft'
      within('.prefecture') do
        find('.vs__search').set('東京')
        find('.vs__dropdown-menu').click
      end
      click_on '詳細入力ページへ進む'
      sleep 3
      find('.draft-button').click
      sleep 3
      find('.fa-pen').click
      fill_in 'タイトル', with: 'TestTitle'
      within('.prefecture') do
        find('.vs__search').set('東京')
        find('.vs__dropdown-menu').click
      end
      click_on '詳細入力ページへ進む'
      sleep 3
      find('.post-button').click
      sleep 3
    }

    context 'ヘッダーのユーザーアイコンをクリック' do
      before { find('.fa-user').click }

      it 'マイページが表示される' do
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.description)
        expect(page).to have_button('編集')
        expect(page).to have_content('投稿')
        expect(page).to have_content('フォロー')
        expect(page).to have_content('フォロワー')
        expect(page).to have_content('投稿')
        expect(page).to have_content('下書き')
        expect(page).to have_content('いいね')
      end

      it '自分の投稿一覧が表示される' do
        within('.post-changer') do
          expect(page).to have_content('投稿')
        end
        expect(page).to have_content('TestTitle')
      end

      context '自分の投稿一覧の投稿をクリック' do
        before { click_on 'TestTitle' }

        it '記事詳細ページに遷移する' do
          expect(current_path).to eq('/trip')
          expect(page).to have_content('TestTitle')
          expect(page).to have_content(user.name)
        end

        context 'メニューボタンをクリックし、「旅行記録を編集」をクリック' do
          before {
            find('.edit-menu').click
            find('.edit-button').click
          }

          it '記事編集ページに遷移する' do
            expect(current_path).to eq('/edit_trip')
          end

          context '「保存する」をクリック' do
            it '記事が保存され記事詳細ページに遷移' do
              find('.post-button').click
              sleep 3
              expect(current_path).to eq('/trip')
              expect(page).to have_content(user.name)
              expect(page).to have_content('TestTitle')
            end
          end

          context '「下書き状態にする」をクリック' do
            it '記事が下書き状態になりマイページに遷移' do
              find('.draft-button').click
              sleep 3
              within('.post-changer') do
                expect(page).to have_content('下書き')
              end
              expect(current_path).to eq('/mypage')
              expect(page).to have_content('TestTitle')
              expect(page).to have_content(user.name)
            end
          end
        end
      end

      context '「下書き」をクリック' do
        before { page.all('.post-changer-unselect')[0].click }

        it '自分の下書き一覧が表示される' do
          within('.post-changer') do
            expect(page).to have_content('下書き')
          end
          expect(page).to have_content('TestTitleDraft')
        end

        context '自分の下書き一覧の下書きをクリック' do
          before { click_on 'TestTitleDraft' }

          it '記事詳細ページに遷移する' do
            expect(current_path).to eq('/trip')
            expect(page).to have_content('TestTitleDraft')
            expect(page).to have_content(user.name)
          end

          context 'メニューボタンをクリックし、「旅行記録を編集」をクリック' do
            before {
              find('.edit-menu').click
              find('.edit-button').click
              sleep 1
            }

            it '記事編集ページに遷移する' do
              expect(current_path).to eq('/edit_trip')
            end

            context '「投稿する」をクリック' do
              it '記事が投稿され記事一覧ページに遷移' do
                find('.post-button').click
                sleep 3
                expect(current_path).to eq('/trips')
                expect(page).to have_content('TestTitleDraft')
                expect(page).to have_content(user.name)
              end
            end

            context '「下書き保存」をクリック' do
              it '記事は下書き状態のままマイページに遷移' do
                find('.draft-button').click
                sleep 3
                within('.post-changer') do
                  expect(page).to have_content('下書き')
                end
                expect(current_path).to eq('/mypage')
                expect(page).to have_content('TestTitleDraft')
                expect(page).to have_content(user.name)
              end
            end
          end
        end
      end

      context '編集をクリック' do
        before { find('.button').click }

        it 'プロフィール編集フォームが表示される' do
          expect(page).to have_content('プロフィール編集')
          expect(page).to have_content('プロフィール画像')
          expect(page).to have_content('ユーザーネーム')
          expect(page).to have_content('自己紹介')
          expect(page).to have_button('保存')
          expect(page).to have_field('プロフィール画像')
          expect(page).to have_field('ユーザーネーム')
          expect(page).to have_field('説明')
          expect(find_field('ユーザーネーム').value).to eq(user.name)
          expect(find_field('説明').value).to eq(user.description)
        end

        context 'プロフィールを編集して「保存」をクリック' do
          it 'プロフィールがアップデートされマイページに遷移' do
            fill_in 'ユーザーネーム', with: 'UpdatedUser'
            fill_in '説明', with: 'UpdatedDescription'
            click_on '保存'
            expect(current_path).to eq('/mypage')
            expect(page).to have_content('UpdatedUser')
            expect(page).to have_content('UpdatedDescription')
          end
        end

        context 'ユーザーネームを空欄にしたまま「保存」をクリック' do
          it 'バリデーションメッセージが表示される' do
            fill_in 'ユーザーネーム', with: ' '
            click_on '保存'
            expect(page).to have_content('ユーザーネームは必須項目です')
          end
        end
      end
    end

    context '記事一覧の自分の記事のユーザー名をクリック' do
      it 'マイページに遷移' do
        click_on user.name
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.description)
        expect(page).to have_button('編集')
        expect(page).to have_content('投稿')
        expect(page).to have_content('フォロー')
        expect(page).to have_content('フォロワー')
        expect(page).to have_content('投稿')
        expect(page).to have_content('下書き')
        expect(page).to have_content('いいね')
      end
    end
  end

  describe 'ユーザーページ' do
    context '記事一覧の記事のユーザー名をクリック' do
      before {
        article_normal
        visit root_path
        click_on article_normal.user.name
      }

      it 'ユーザーページが表示される' do
        expect(current_path).to eq('/user')
        expect(page).to have_content(article_normal.user.name)
        expect(page).to have_content(article_normal.user.description)
        expect(page).to_not have_button('編集')
        expect(page).to have_content('投稿')
        expect(page).to have_content('フォロー')
        expect(page).to have_content('フォロワー')
        expect(page).to have_content('投稿')
        expect(page).to_not have_content('下書き')
        expect(page).to have_content('いいね')
      end

      context '投稿一覧の記事をクリック' do
        it '記事詳細が表示される' do
          click_on article_normal.title
          expect(current_path).to eq('/trip')
          expect(page).to have_content(article_normal.title)
        end
      end
    end
  end

  describe 'アカウント設定ページ' do
    before { login_as(user) }

    context 'ヘッダーのメニューバーをクリックし、「アカウント設定」をクリック' do
      before{
        find('.fa-bars').click
        page.all('.dropdown-item')[0].click
      }
      it 'アカウント設定ページが表示される' do
        expect(page).to have_content('アカウント設定')
        expect(page).to have_content('メールアドレス')
        expect(page).to have_content('パスワード')
        expect(page).to have_button('保存')
        expect(page).to have_field('メールアドレス')
        expect(page).to have_field('パスワード')
        expect(find_field('メールアドレス').value).to eq(user.email)
      end

      context 'メールアドレスとパスワードを編集して「保存」をクリック' do
        it 'アカウント設定がアップデートされる' do
          fill_in 'メールアドレス', with: 'update@update.com'
          fill_in 'パスワード', with: 'update'
          click_on '保存'
          page.all('.dropdown-item')[1].click
          fill_in 'メールアドレス', with: 'update@update.com'
          fill_in 'パスワード', with: 'update'
          find('.button').click
          find('.fa-bars').click
          page.all('.dropdown-item')[0].click
          expect(find_field('メールアドレス').value).to eq('update@update.com')
        end
      end

      context 'メールアドレスのみを編集して「保存」をクリック' do
        it 'メールアドレスがアップデートされる' do
          fill_in 'メールアドレス', with: 'update@update.com'
          click_on '保存'
          page.all('.dropdown-item')[0].click
          expect(find_field('メールアドレス').value).to eq('update@update.com')
        end
      end

      context 'メールアドレスを空欄にして「保存」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'メールアドレス', with: ' '
          click_on '保存'
          expect(page).to have_content('メールアドレスは必須項目です')
        end
      end

      context '不適切な形式のメールアドレスを入力して「保存」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'メールアドレス', with: 'test'
          click_on '保存'
          expect(page).to have_content('メールアドレスの形式で入力してください')
        end
      end

      context 'パスワードを半角英数字以外で入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'パスワード', with: 'テスト'
          click_on '保存'
          expect(page).to have_content('半角英数字で入力してください')
        end
      end

      context 'パスワードを5文字未満で入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'パスワード', with: 'aaaa'
          click_on '保存'
          expect(page).to have_content('パスワードは5文字以上で入力してください')
        end
      end

      context 'パスワードを入力して目のアイコンをクリック' do
        it 'パスワードの表示非表示が切り替わる' do
          fill_in 'パスワード', with: 'password'
          find('.fa-eye').click
          expect(page).to have_css('.fa-eye-slash')
          find('.fa-eye-slash').click
          expect(page).to have_css('.fa-eye')
        end
      end

      context '「退会する」をクリックして、確認ダイアログの「OK」をクリック' do
        it 'ユーザーが削除される' do
          page.accept_confirm do
            find('#delete-membership').click
          end
          expect(current_path).to eq('/trips')
          find('.login-button').click
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password'
          find('.button').click
          expect(page).to have_content('メールアドレスまたはパスワードが正しくありません')
        end
      end
    end
  end

  describe 'ログアウト' do
    context 'ヘッダーのメニューアイコンをクリックし、ログアウトをクリック' do
      it 'ログアウトし、ログインページに遷移' do
        login_as(user)
        sleep 2
        find('.fa-bars').click
        page.all('.dropdown-item')[1].click
        expect(current_path).to eq('/login')
        within('.container-fluid') do
          expect(page).to have_content('ログイン')
        end
      end
    end
  end
end
