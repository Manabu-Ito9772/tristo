require 'rails_helper'

RSpec.describe '利用規約/プライバシーポリシー', type: :system do
  let(:user) { create(:user) }
  let(:article_normal) { create(:article, :normal) }

  describe 'トップページ' do
    context '利用規約をクリック' do
      it '利用規約が表示される' do
        visit root_path
        find('#term-of-use').click
        within('#term') do
          expect(page).to have_content('利用規約')
        end
      end
    end

    context 'プライバシーポリシーをクリック' do
      it 'プライバシーポリシーが表示される' do
        visit root_path
        find('#privacy-policy').click
        within('#policy') do
          expect(page).to have_content('プライバシーポリシー')
        end
      end
    end

    context 'お問い合わせをクリック' do
      it 'お問い合わせフォームが表示される' do
        visit root_path
        find('#contact').click
        switch_to_window(windows.last)
        expect(page).to have_content('TriStoをご利用頂きありがとうございます')
      end
    end
  end

  describe 'ユーザー登録ページ' do
    context '利用規約をクリック' do
      it '利用規約が表示される' do
        visit '/register'
        find('#term-of-use').click
        within('#term') do
          expect(page).to have_content('利用規約')
        end
      end
    end

    context 'プライバシーポリシーをクリック' do
      it 'プライバシーポリシーが表示される' do
        visit '/register'
        find('#privacy-policy').click
        within('#policy') do
          expect(page).to have_content('プライバシーポリシー')
        end
      end
    end

    context 'お問い合わせをクリック' do
      it 'お問い合わせフォームが表示される' do
        visit '/register'
        find('#contact').click
        switch_to_window(windows.last)
        expect(page).to have_content('TriStoをご利用頂きありがとうございます')
      end
    end
  end

  describe 'ログインページ' do
    context '利用規約をクリック' do
      it '利用規約が表示される' do
        visit '/login'
        find('#term-of-use').click
        within('#term') do
          expect(page).to have_content('利用規約')
        end
      end
    end

    context 'プライバシーポリシーをクリック' do
      it 'プライバシーポリシーが表示される' do
        visit '/login'
        find('#privacy-policy').click
        within('#policy') do
          expect(page).to have_content('プライバシーポリシー')
        end
      end
    end

    context 'お問い合わせをクリック' do
      it 'お問い合わせフォームが表示される' do
        visit '/login'
        find('#contact').click
        switch_to_window(windows.last)
        expect(page).to have_content('TriStoをご利用頂きありがとうございます')
      end
    end
  end

  describe '記事一覧ページ' do
    before {
      login_as(user)
      sleep 2
    }

    context '利用規約をクリック' do
      it '利用規約が表示される' do
        find('#term-of-use').click
        within('#term') do
          expect(page).to have_content('利用規約')
        end
      end
    end

    context 'プライバシーポリシーをクリック' do
      it 'プライバシーポリシーが表示される' do
        find('#privacy-policy').click
        within('#policy') do
          expect(page).to have_content('プライバシーポリシー')
        end
      end
    end

    context 'お問い合わせをクリック' do
      it 'お問い合わせフォームが表示される' do
        find('#contact').click
        switch_to_window(windows.last)
        expect(page).to have_content('TriStoをご利用頂きありがとうございます')
      end
    end

    describe 'プロフィール編集画面' do
      before {
        find('.fa-user').click
        find('.button').click
      }

      context '利用規約をクリック' do
        it '利用規約が表示される' do
          find('#term-of-use').click
          within('#term') do
            expect(page).to have_content('利用規約')
          end
        end
      end

      context 'プライバシーポリシーをクリック' do
        it 'プライバシーポリシーが表示される' do
          find('#privacy-policy').click
          within('#policy') do
            expect(page).to have_content('プライバシーポリシー')
          end
        end
      end

      context 'お問い合わせをクリック' do
        it 'お問い合わせフォームが表示される' do
          find('#contact').click
          switch_to_window(windows.last)
          expect(page).to have_content('TriStoをご利用頂きありがとうございます')
        end
      end
    end

    describe 'アカウント設定画面' do
      before {
        find('.fa-bars').click
        page.all('.dropdown-item')[0].click
      }

      context '利用規約をクリック' do
        it '利用規約が表示される' do
          find('#term-of-use').click
          within('#term') do
            expect(page).to have_content('利用規約')
          end
        end
      end

      context 'プライバシーポリシーをクリック' do
        it 'プライバシーポリシーが表示される' do
          find('#privacy-policy').click
          within('#policy') do
            expect(page).to have_content('プライバシーポリシー')
          end
        end
      end

      context 'お問い合わせをクリック' do
        it 'お問い合わせフォームが表示される' do
          find('#contact').click
          switch_to_window(windows.last)
          expect(page).to have_content('TriStoをご利用頂きありがとうございます')
        end
      end
    end
  end
end
