require 'rails_helper'

RSpec.describe 'ユーザー', type: :system do
  let(:user) { create(:user) }
  let(:country_japan) { create(:country, :japan_tokyo_kanagawa) }
  let(:article_normal) { create(:article, :normal) }
  let(:article_draft) { create(:article, :draft) }
  let(:article_another_user) { create(:article, :another_user) }

  describe 'ユーザー登録' do
    context 'ユーザー登録ボタンをクリック' do
      before {
        visit root_path
        find('#register-button').click
      }

      it 'フォームが表示される' do
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

      context 'フォームを入力して「登録」をクリック' do
        it 'ユーザーが登録され記事一覧ページに遷移' do
          fill_in 'ユーザーネーム', with: 'TestUser'
          fill_in 'メールアドレス', with: 'test@test.com'
          fill_in 'パスワード', with: 'password'
          attach_file('プロフィール画像', 'public/images/sample.png')
          find('.button').click
          sleep 2
          expect(current_path).to eq('/trip_notes')
          find('.fa-user').click
          expect(current_path).to eq('/mypage')
          expect(page).to have_content('TestUser')
          expect(page).to have_selector("img[src$='sample.png']")
        end

        it 'プロフィール画像を設定しない場合はデフォルトの画像が表示される' do
          fill_in 'ユーザーネーム', with: 'TestUser'
          fill_in 'メールアドレス', with: 'test@test.com'
          fill_in 'パスワード', with: 'password'
          find('.button').click
          sleep 2
          expect(current_path).to eq('/trip_notes')
          find('.fa-user').click
          expect(current_path).to eq('/mypage')
          expect(page).to have_content('TestUser')
          expect(page).to have_css('#default-avatar')
        end
      end

      context 'プロフィール画像を選択後にXボタンをクリック' do
        it 'プロフィール画像の選択が解除される' do
          attach_file('プロフィール画像', 'public/images/sample.png')
          expect(page).to have_css('#preview-avatar')
          find('.icon').click
          expect(page).to have_css('#default-avatar')
          expect(page).to_not have_css('#preview-image')
        end
      end

      context '何も入力せずに「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          find('.button').click
          expect(page).to have_content('ユーザーネームは必須項目です')
          expect(page).to have_content('メールアドレスは必須項目です')
          expect(page).to have_content('パスワードは必須項目です')
        end
      end

      context '不適切な形式のメールアドレスを入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'メールアドレス', with: 'test'
          find('.button').click
          expect(page).to have_content('メールアドレスの形式で入力してください')
        end
      end

      context '既に存在しているメールアドレスを入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          user
          fill_in 'ユーザーネーム', with: 'TestUser'
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password'
          find('.button').click
          sleep 2
          expect(page).to have_content('このメールアドレスは既に使われています')
        end
      end

      context 'パスワードを半角英数字以外で入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'パスワード', with: 'テスト'
          find('.button').click
          expect(page).to have_content('半角英数字・記号で入力してください')
        end
      end

      context 'パスワードを5文字未満で入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'パスワード', with: 'aaaa'
          find('.button').click
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
        find('#login-button').click
      }

      it 'フォームが表示される' do
        within('.container-fluid') do
          expect(page).to have_content('ログイン')
        end
        expect(page).to have_field('メールアドレス')
        expect(page).to have_field('パスワード')
        expect(page).to have_css('.button')
      end

      context 'フォームを入力して「ログイン」をクリック' do
        it 'ログインして記事一覧ページに遷移' do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password'
          find('.button').click
          sleep 2
          expect(current_path).to eq('/trip_notes')
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
          sleep 2
          expect(page).to have_content('メールアドレスまたはパスワードが正しくありません')
        end
      end

      context 'パスワードを半角英数字以外で入力して「ログイン」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'パスワード', with: 'テスト'
          find('.button').click
          expect(page).to have_content('半角英数字・記号で入力してください')
        end
      end

      context '間違えたパスワードを入力して「ログイン」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'wrong'
          find('.button').click
          sleep 2
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
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        expect(current_path).to eq('/trip_notes')
        expect(page).to have_content(article_normal.title)
        find("#article-item-#{article_normal.id}").click
        expect(current_path).to eq('/trip_note')
        expect(page).to have_content(article_normal.title)
        visit '/trip_notes'
        sleep 2
        find("#article-user-#{article_normal.user.id}").click
        expect(current_path).to eq('/user')
        expect(page).to have_content(article_normal.user.name)
      end
    end

    context 'ログインせずにログインが必要なページにアクセス' do
      it 'ログインページに遷移する' do
        visit '/create_trip_note'
        expect(current_path).to eq('/login')
        within('.container-fluid') do
          expect(page).to have_content('ログイン')
        end
        visit 'create_trip_note_detail'
        expect(current_path).to eq('/login')
        within('.container-fluid') do
          expect(page).to have_content('ログイン')
        end
        visit 'edit_trip_note'
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
    context 'ヘッダーのユーザーアイコンをクリック' do
      it 'マイページが表示される' do
        article_normal
        login_as(article_normal.user)
        sleep 2
        find('.fa-user').click
        sleep 2
        expect(page).to have_content(article_normal.user.name)
        expect(page).to have_content(article_normal.description)
        expect(page).to have_css('#default-avatar')
        expect(page).to have_content('編集')
        expect(page).to have_content('投稿')
        expect(page).to have_content('フォロー')
        expect(page).to have_content('フォロワー')
        expect(page).to have_content('投稿')
        expect(page).to have_content('下書き')
        expect(page).to have_content('いいね')
      end

      describe '投稿一覧' do
        before {
          article_normal
          login_as(article_normal.user)
          sleep 2
          find('.fa-user').click
          sleep 2
        }

        it '自分の投稿一覧が表示される' do
          within('.post-changer') do
            expect(page).to have_content('投稿')
          end
          expect(page).to have_content('TestTitle')
        end

        context '自分の投稿一覧の投稿をクリック' do
          before { find('.article-title').click }

          it '記事詳細ページに遷移する' do
            expect(current_path).to eq('/trip_note')
            expect(page).to have_content('TestTitle')
            expect(page).to have_content(article_normal.user.name)
          end

          context 'メニューボタンをクリックし、「旅行記録を編集」をクリック' do
            before {
              find('#edit-menu').click
              find('#edit-btn').click
            }

            it '記事編集ページに遷移する' do
              expect(current_path).to eq('/edit_trip_note')
            end

            context '「保存する」をクリック' do
              it '記事が保存され記事詳細ページに遷移' do
                find('.post-button').click
                sleep 2
                expect(current_path).to eq('/trip_note')
                expect(page).to have_content(article_normal.user.name)
                expect(page).to have_content('TestTitle')
              end
            end

            context '「下書き状態にする」をクリック' do
              it '記事が非公開になりマイページに遷移' do
                find('.draft-button').click
                sleep 2
                within('.post-changer') do
                  expect(page).to have_content('下書き')
                end
                expect(current_path).to eq('/mypage')
                expect(page).to have_content('TestTitle')
                expect(page).to have_content(article_normal.user.name)
              end
            end
          end
        end
      end

      context '「下書き」をクリック' do
        before {
          article_draft
          login_as(article_draft.user)
          sleep 2
          find('.fa-user').click
          sleep 2
          page.all('.post-changer-unselect')[0].click
          sleep 2
        }

        it '自分の下書き記事一覧が表示される' do
          within('.post-changer') do
            expect(page).to have_content('下書き')
          end
          expect(page).to have_content(article_draft.title)
        end

        context '自分の下書き記事一覧の記事をクリック' do
          before {
            find("#article-item-#{article_draft.id}").click
            sleep 2
          }

          it '記事詳細ページに遷移する' do
            expect(current_path).to eq('/trip_note')
            expect(page).to have_content(article_draft.title)
            expect(page).to have_content(article_draft.user.name)
          end

          context 'メニューボタンをクリックし、「旅行記録を編集」をクリック' do
            before {
              find('#edit-menu').click
              find('#edit-btn').click
              sleep 2
            }

            it '記事編集ページに遷移する' do
              expect(current_path).to eq('/edit_trip_note')
            end

            context '「公開する」をクリック' do
              it '記事が投稿され記事一覧ページに遷移' do
                find('.post-button').click
                sleep 2
                expect(current_path).to eq('/trip_notes')
                expect(page).to have_content(article_draft.title)
                expect(page).to have_content(article_draft.user.name)
              end
            end

            context '「保存」をクリック' do
              it '記事は下書き状態のままマイページに遷移' do
                find('.draft-button').click
                sleep 2
                within('.post-changer') do
                  expect(page).to have_content('下書き')
                end
                expect(current_path).to eq('/mypage')
                expect(page).to have_content(article_draft.title)
                expect(page).to have_content(article_draft.user.name)
              end
            end
          end
        end
      end

      context '「いいね」をクリック' do
        before {
          article_normal
          login_as(article_normal.user)
          sleep 2
          find('.area-changer-unselected').click
          sleep 2
          find('.heart').click
          find('.fa-user').click
          sleep 2
          page.all('.post-changer-unselect')[1].click
          sleep 2
        }

        it 'いいね一覧が表示される' do
          within('.post-changer') do
            expect(page).to have_content('いいね')
          end
          expect(page).to have_content(article_normal.title)
          expect(page).to have_content(article_normal.description)
        end

        context 'いいね一覧の記事をクリック' do
          it '記事詳細ページに遷移する' do
            find("#article-item-#{article_normal.id}").click
            sleep 2
            expect(current_path).to eq('/trip_note')
            expect(page).to have_content(article_normal.title)
            expect(page).to have_content(article_normal.description)
            expect(page).to have_content(article_normal.user.name)
          end
        end
      end

      context '編集をクリック' do
        before {
          article_normal
          login_as(article_normal.user)
          sleep 2
          find('.fa-user').click
          sleep 2
          find('.button').click
        }

        it 'プロフィール編集フォームが表示される' do
          expect(page).to have_content('プロフィール編集')
          expect(page).to have_content('プロフィール画像')
          expect(page).to have_css('#default-avatar')
          expect(page).to have_field('プロフィール画像')
          expect(page).to have_content('ユーザーネーム')
          expect(page).to have_field('ユーザーネーム')
          expect(page).to have_content('自己紹介')
          expect(page).to have_field('説明')
          expect(page).to have_css('.button')
          expect(find_field('ユーザーネーム').value).to eq(article_normal.user.name)
          expect(find_field('説明').value).to eq(article_normal.user.description)
        end

        context 'プロフィールを編集して「保存」をクリック' do
          it 'プロフィールがアップデートされマイページに遷移' do
            fill_in 'ユーザーネーム', with: 'UpdatedUser'
            fill_in '説明', with: 'UpdatedDescription'
            attach_file('プロフィール画像', 'public/images/sample.png')
            find('.button').click
            sleep 2
            expect(current_path).to eq('/mypage')
            expect(page).to have_selector("img[src$='sample.png']")
            expect(page).to have_content('UpdatedUser')
            expect(page).to have_content('UpdatedDescription')
          end
        end

        context 'ユーザーネームを空欄にしたまま「保存」をクリック' do
          it 'バリデーションメッセージが表示される' do
            fill_in 'ユーザーネーム', with: ' '
            find('.button').click
            expect(page).to have_content('ユーザーネームは必須項目です')
          end
        end

        context 'プロフィール画像のXボタンをクリック' do
          it 'デフォルト画像が表示される' do
            attach_file('プロフィール画像', 'public/images/sample.png')
            expect(page).to have_css('#preview-avatar')
            find('.icon').click
            expect(page).to have_css('#default-avatar')
            expect(page).to_not have_css('#preview-avatar')
            attach_file('プロフィール画像', 'public/images/sample.png')
            find('.button').click
            sleep 2
            find('.button').click
            expect(page).to have_selector("img[src$='sample.png']")
            find('.icon').click
            expect(page).to have_css('#default-avatar')
            expect(page).to_not have_selector("img[src$='sample.png']")
          end
        end
      end
    end

    context '記事一覧の自分の記事のユーザー名をクリック' do
      it 'マイページに遷移' do
        article_normal
        login_as(article_normal.user)
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find("#article-user-#{article_normal.user.id}").click
        expect(page).to have_content(article_normal.user.name)
        expect(page).to have_content(article_normal.user.description)
        expect(page).to have_content('編集')
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
        login_as(article_normal.user)
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find('.heart').click
        find('.fa-bars').click
        page.all('.dropdown-item')[1].click
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        sleep 2
        find("#article-user-#{article_normal.user.id}").click
        sleep 2
      }

      it 'ユーザーページが表示される' do
        expect(current_path).to eq('/user')
        expect(page).to have_css('#default-avatar')
        expect(page).to have_content(article_normal.user.name)
        expect(page).to have_content(article_normal.user.description)
        expect(page).to_not have_content('編集')
        expect(page).to have_content('投稿')
        expect(page).to have_content('フォロー')
        expect(page).to have_content('フォロワー')
        expect(page).to have_content('投稿')
        expect(page).to_not have_content('非公開')
        expect(page).to have_content('いいね')
      end

      it '投稿一覧が表示される' do
        expect(page).to have_content(article_normal.title)
      end

      context '投稿一覧の記事をクリック' do
        it '記事詳細が表示される' do
          find("#article-item-#{article_normal.id}").click
          expect(current_path).to eq('/trip_note')
          expect(page).to have_content(article_normal.title)
        end
      end

      context '「いいね」をクリック' do
        it 'いいねした記事一覧が表示される' do
          find('.post-changer-unselect').click
          sleep 2
          expect(page).to have_content(article_normal.title)
        end

        context 'いいねした記事をクリック' do
          it '記事詳細が表示される' do
            find("#article-item-#{article_normal.id}").click
            sleep 2
            expect(current_path).to eq('/trip_note')
            expect(page).to have_content(article_normal.title)
          end
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
        expect(page).to have_css('.button')
        expect(page).to have_field('メールアドレス')
        expect(page).to have_field('パスワード')
        expect(find_field('メールアドレス').value).to eq(user.email)
      end

      context 'メールアドレスとパスワードを編集して「保存」をクリック' do
        it 'アカウント設定がアップデートされる' do
          fill_in 'メールアドレス', with: 'update@update.com'
          fill_in 'パスワード', with: 'update'
          find('.button').click
          find('.fa-bars').click
          page.all('.dropdown-item')[0].click
          expect(find_field('メールアドレス').value).to eq('update@update.com')
          page.save_screenshot 'screenshot.png'
        end
      end

      context 'メールアドレスのみを編集して「保存」をクリック' do
        it 'メールアドレスがアップデートされる' do
          fill_in 'メールアドレス', with: 'update@update.com'
          find('.button').click
          sleep 2
          find('.fa-bars').click
          page.all('.dropdown-item')[0].click
          expect(find_field('メールアドレス').value).to eq('update@update.com')
        end
      end

      context 'メールアドレスを空欄にして「保存」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'メールアドレス', with: ' '
          find('.button').click
          expect(page).to have_content('メールアドレスは必須項目です')
        end
      end

      context '不適切な形式のメールアドレスを入力して「保存」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'メールアドレス', with: 'test'
          find('.button').click
          expect(page).to have_content('メールアドレスの形式で入力してください')
        end
      end

      context 'パスワードを半角英数字以外で入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'パスワード', with: 'テスト'
          find('.button').click
          expect(page).to have_content('半角英数字・記号で入力してください')
        end
      end

      context 'パスワードを5文字未満で入力して「登録」をクリック' do
        it 'バリデーションメッセージが表示される' do
          fill_in 'パスワード', with: 'aaaa'
          find('.button').click
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
          expect(current_path).to eq('/trip_notes')
          expect(page).to have_content('退会しました。ご利用ありがとうございました。')
          find('#login-button').click
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
