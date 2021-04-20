require 'rails_helper'

RSpec.describe '記事検索', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user, :another_user) }
  let(:japan) { create(:country, :domestic) }
  let(:usa) { create(:country, :usa) }
  let(:france) { create(:country, :france) }
  let(:china) { create(:country, :china) }

  let(:create_article_tokyo) {
    visit '/create_trip'
    fill_in 'タイトル', with: 'Tokyo'
    within('.prefecture') do
      find('.vs__search').set('東京')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  let(:create_article_osaka) {
    visit '/create_trip'
    fill_in 'タイトル', with: 'Osaka'
    within('.prefecture') do
      find('.vs__search').set('大阪')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  let(:create_article_tokyo_osaka) {
    visit '/create_trip'
    fill_in 'タイトル', with: 'Tokio_And_Osaka'
    within('.prefecture') do
      find('.vs__search').set('東京')
      find('.vs__dropdown-menu').click
    end
    within('.prefecture') do
      find('.vs__search').set('大阪')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  let(:create_article_tokyo_with_tag) {
    visit '/create_trip'
    fill_in 'タイトル', with: 'Tokyo'
    within('.prefecture') do
      find('.vs__search').set('東京')
      find('.vs__dropdown-menu').click
    end
    within('.tag') do
      find('.vs__search').set('Tag')
      find('.vs__dropdown-menu').click
    end
    within('.tag') do
      find('.vs__search').set('Tag2')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  let(:create_article_osaka_with_tag) {
    visit '/create_trip'
    fill_in 'タイトル', with: 'Osaka'
    within('.prefecture') do
      find('.vs__search').set('大阪')
      find('.vs__dropdown-menu').click
    end
    within('.tag') do
      find('.vs__search').set('Tag')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  let(:create_article_fukuoka) {
    visit '/create_trip'
    fill_in 'タイトル', with: 'Fukuoka'
    within('.prefecture') do
      find('.vs__search').set('福岡')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  let(:create_article_california) {
    visit '/create_trip'
    find('.domestic-btn-unselected').click
    fill_in 'タイトル', with: 'California'
    within('.country') do
      find('.vs__search').set('アメリカ')
      find('.vs__dropdown-menu').click
    end
    within('.region') do
      find('.vs__search').set('カリフォルニア')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  let(:create_article_hawaii) {
    visit '/create_trip'
    find('.domestic-btn-unselected').click
    fill_in 'タイトル', with: 'Hawaii'
    within('.country') do
      find('.vs__search').set('アメリカ')
      find('.vs__dropdown-menu').click
    end
    within('.region') do
      find('.vs__search').set('ハワイ')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  let(:create_article_california_hawaii) {
    visit '/create_trip'
    find('.domestic-btn-unselected').click
    fill_in 'タイトル', with: 'LaAloha'
    within('.country') do
      find('.vs__search').set('アメリカ')
      find('.vs__dropdown-menu').click
    end
    within('.region') do
      find('.vs__search').set('カリフォルニア')
      find('.vs__dropdown-menu').click
    end
    within('.region') do
      find('.vs__search').set('ハワイ')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  let(:create_article_california_with_tag) {
    visit '/create_trip'
    find('.domestic-btn-unselected').click
    fill_in 'タイトル', with: 'California'
    within('.country') do
      find('.vs__search').set('アメリカ')
      find('.vs__dropdown-menu').click
    end
    within('.region') do
      find('.vs__search').set('カリフォルニア')
      find('.vs__dropdown-menu').click
    end
    within('.tag') do
      find('.vs__search').set('Tag')
      find('.vs__dropdown-menu').click
    end
    within('.tag') do
      find('.vs__search').set('Tag2')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  let(:create_article_hawaii_with_tag) {
    visit '/create_trip'
    find('.domestic-btn-unselected').click
    fill_in 'タイトル', with: 'Hawaii'
    within('.country') do
      find('.vs__search').set('アメリカ')
      find('.vs__dropdown-menu').click
    end
    within('.region') do
      find('.vs__search').set('ハワイ')
      find('.vs__dropdown-menu').click
    end
    within('.tag') do
      find('.vs__search').set('Tag')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  let(:create_article_paris) {
    visit '/create_trip'
    find('.domestic-btn-unselected').click
    fill_in 'タイトル', with: 'Paris'
    within('.country') do
      find('.vs__search').set('フランス')
      find('.vs__dropdown-menu').click
    end
    within('.region') do
      find('.vs__search').set('パリ')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
    find('.post-button').click
    sleep 2
  }

  before {
    japan
    usa
    france
    china
    login_as(user)
  }

  describe '国内記事' do
    context '国内ボタンをクリック' do
      it '国内記事一覧が表示される' do
        create_article_tokyo
        create_article_osaka
        create_article_california
        find('.area-changer-unselected').click
        expect(page).to have_content('Tokyo')
        expect(page).to have_content('Osaka')
        expect(page).to_not have_content('California')
      end

      context '都道府県を選択して検索' do
        it '記事がある場合は表示される' do
          create_article_tokyo
          create_article_osaka
          within('#prefecture') do
            find('.vs__search').set('大阪')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 2
          expect(page).to have_content('Osaka')
          expect(page).to_not have_content('Tokyo')
          page.save_screenshot 'screenshot.png'
        end

        it '記事がない場合は表示されない' do
          create_article_tokyo
          within('#prefecture') do
            find('.vs__search').set('大阪')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 2
          expect(page).to have_content('投稿がありません')
        end
      end

      context '都道府県を複数選択して検索' do
        it '記事がある場合は表示される' do
          create_article_tokyo
          create_article_tokyo_osaka
          within('#prefecture') do
            find('.vs__search').set('東京')
            find('.vs__dropdown-menu').click
          end
          within('#prefecture') do
            find('.vs__search').set('大阪')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 2
          expect(page).to have_content('Tokio_And_Osaka')
          expect(page).to_not have_content('Tokyo')
          page.save_screenshot 'screenshot.png'
        end
      end

      context 'タグを入力して検索' do
        it '記事がある場合は表示される' do
          create_article_tokyo_with_tag
          create_article_osaka
          within('#tag') do
            find('.vs__search').set('Tag')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 2
          expect(page).to have_content('Tokyo')
          expect(page).to_not have_content('Osaka')
        end

        it '記事がない場合は表示されない' do
          create_article_tokyo
          within('#tag') do
            find('.vs__search').set('Tag')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 2
          expect(page).to have_content('投稿がありません')
          expect(page).to_not have_content('Tokyo')
        end
      end

      context 'タグを複数入力して検索' do
        it '記事がある場合は表示される' do
          create_article_tokyo_with_tag
          create_article_osaka_with_tag
          within('#tag') do
            find('.vs__search').set('Tag')
            find('.vs__dropdown-menu').click
          end
          within('#tag') do
            find('.vs__search').set('Tag2')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 2
          expect(page).to have_content('Tokyo')
          expect(page).to_not have_content('Osaka')
        end
      end

      context 'フリーワードを入力して検索' do
        it '記事がある場合は表示される' do
          create_article_tokyo
          create_article_osaka
          fill_in 'フリーワード', with: 'Tokyo'
          find('.button').click
          sleep 2
          expect(page).to have_content('Tokyo')
          expect(page).to_not have_content('Osaka')
        end

        it '記事がない場合は表示されない' do
          create_article_tokyo
          fill_in 'フリーワード', with: 'test'
          find('.button').click
          sleep 2
          expect(page).to have_content('投稿がありません')
          expect(page).to_not have_content('Tokyo')
        end
      end

      context 'フリーワードを複数入力して検索' do
        it '記事がある場合は表示される' do
          create_article_tokyo
          create_article_osaka
          fill_in 'フリーワード', with: 'a s'
          find('.button').click
          sleep 2
          expect(page).to have_content('Osaka')
          expect(page).to_not have_content('Tokyo')
        end
      end

      context '古い順を選択して検索' do
        before {
          create_article_tokyo
          create_article_osaka
          create_article_fukuoka
          find('#old').click
          find('.button').click
          sleep 2
        }

        it '記事が古い順に並ぶ' do
          expect(page.all('.article-title')[0]).to have_content('Tokyo')
          expect(page.all('.article-title')[1]).to have_content('Osaka')
          expect(page.all('.article-title')[2]).to have_content('Fukuoka')
        end

        context '新しい順を選択して検索' do
          it '記事が新しい順に並ぶ' do
            find('#new').click
            find('.button').click
            sleep 2
            expect(page.all('.article-title')[0]).to have_content('Fukuoka')
            expect(page.all('.article-title')[1]).to have_content('Osaka')
            expect(page.all('.article-title')[2]).to have_content('Tokyo')
            page.save_screenshot 'screenshot.png'
          end
        end
      end

      context 'いいね順を選択して検索' do
        it '記事がいいね順に並ぶ' do
          create_article_tokyo
          create_article_osaka
          page.all('.heart')[1].click
          find('.fa-bars').click
          page.all('.dropdown-item')[1].click
          login_as(another_user)
          sleep 2
          page.all('.heart')[1].click
          create_article_fukuoka
          page.all('.heart')[0].click
          find('#favorites').click
          find('.button').click
          sleep 2
          expect(page.all('.article-title')[0]).to have_content('Tokyo')
          expect(page.all('.article-title')[1]).to have_content('Fukuoka')
          expect(page.all('.article-title')[2]).to have_content('Osaka')
        end
      end

      context 'フォローユーザーのみ表示のラジオボタンをクリック' do
        it 'フォロー中のユーザーの投稿のみ表示される' do
          create_article_tokyo
          create_article_osaka
          find('.fa-bars').click
          page.all('.dropdown-item')[1].click
          login_as(another_user)
          sleep 2
          page.all("#article-user-#{user.id}")[0].click
          find('.follow-button').click
          create_article_fukuoka
          find('#followingRadioButton').click
          sleep 2
          expect(page).to have_content('Tokyo')
          expect(page).to have_content('Osaka')
          expect(page).to_not have_content('Fukuoka')
        end
      end
    end

    context '海外ボタンをクリック' do
      it '海外記事一覧が表示される' do
        create_article_california
        create_article_paris
        create_article_tokyo
        find('.area-changer-unselected').click
        expect(page).to have_content('California')
        expect(page).to have_content('Paris')
        expect(page).to_not have_content('Tokyo')
        page.save_screenshot 'screenshot.png'
      end

      context '国を選択して検索' do
        it '記事がある場合は表示される' do
          create_article_california
          create_article_hawaii
          create_article_paris
          within('#country') do
            find('.vs__search').set('アメリカ')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 2
          expect(page).to have_content('California')
          expect(page).to have_content('Hawaii')
          expect(page).to_not have_content('Paris')
          page.save_screenshot 'screenshot.png'
        end

        it '記事がない場合は表示されない' do
          create_article_california
          within('#country') do
            find('.vs__search').set('フランス')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 2
          expect(page).to have_content('投稿がありません')
          expect(page).to_not have_content('California')
        end

        context '地域を選択して検索' do
          it '記事がある場合は表示される' do
            create_article_california
            create_article_hawaii
            create_article_paris
            within('#country') do
              find('.vs__search').set('アメリカ')
              find('.vs__dropdown-menu').click
            end
            within('#area') do
              find('.vs__search').set('カリフォルニア')
              find('.vs__dropdown-menu').click
            end
            find('.button').click
            sleep 2
            expect(page).to have_content('California')
            expect(page).to_not have_content('Hawaii')
            expect(page).to_not have_content('Paris')
          end

          it '記事がない場合は表示されない' do
            create_article_california
            within('#country') do
              find('.vs__search').set('アメリカ')
              find('.vs__dropdown-menu').click
            end
            within('#area') do
              find('.vs__search').set('ハワイ')
              find('.vs__dropdown-menu').click
            end
            find('.button').click
            sleep 2
            expect(page).to have_content('投稿がありません')
            expect(page).to_not have_content('California')
          end
        end

        context '地域を複数選択して検索' do
          it '記事がある場合は表示される' do
            create_article_california
            create_article_california_hawaii
            within('#country') do
              find('.vs__search').set('アメリカ')
              find('.vs__dropdown-menu').click
            end
            within('#area') do
              find('.vs__search').set('カリフォルニア')
              find('.vs__dropdown-menu').click
            end
            within('#area') do
              find('.vs__search').set('ハワイ')
              find('.vs__dropdown-menu').click
            end
            find('.button').click
            sleep 2
            expect(page).to have_content('LaAloha')
            expect(page).to_not have_content('California')
          end
        end
      end

      context 'タグを入力して検索' do
        it '記事がある場合は表示される' do
          create_article_california_with_tag
          create_article_hawaii
          within('#tag') do
            find('.vs__search').set('Tag')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 2
          expect(page).to have_content('California')
          expect(page).to_not have_content('Hawaii')
        end

        it '記事がない場合は表示されない' do
          create_article_california
          within('#tag') do
            find('.vs__search').set('Tag')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 2
          expect(page).to have_content('投稿がありません')
          expect(page).to_not have_content('California')
        end
      end

      context 'タグを複数入力して検索' do
        it '記事がある場合は表示される' do
          create_article_california_with_tag
          create_article_hawaii_with_tag
          within('#tag') do
            find('.vs__search').set('Tag')
            find('.vs__dropdown-menu').click
          end
          within('#tag') do
            find('.vs__search').set('Tag2')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 2
          expect(page).to have_content('California')
          expect(page).to_not have_content('Hawaii')
        end
      end

      context 'フリーワードを入力して検索' do
        it '記事がある場合は表示される' do
          create_article_california
          create_article_hawaii
          fill_in 'フリーワード', with: 'California'
          find('.button').click
          sleep 2
          expect(page).to have_content('California')
          expect(page).to_not have_content('Hawaii')
        end

        it '記事がない場合は表示されない' do
          create_article_california
          fill_in 'フリーワード', with: 'test'
          find('.button').click
          sleep 2
          expect(page).to have_content('投稿がありません')
          expect(page).to_not have_content('California')
        end
      end

      context 'フリーワードを複数入力して検索' do
        it '記事がある場合は表示される' do
          create_article_california
          create_article_hawaii
          fill_in 'フリーワード', with: 'l f'
          find('.button').click
          sleep 2
          expect(page).to have_content('California')
          expect(page).to_not have_content('Hawaii')
          page.save_screenshot 'screenshot.png'
        end
      end

      context '古い順を選択して検索' do
        before {
          create_article_california
          create_article_hawaii
          create_article_paris
          find('#old').click
          find('.button').click
          sleep 2
        }

        it '記事が古い順に並ぶ' do
          expect(page.all('.article-title')[0]).to have_content('California')
          expect(page.all('.article-title')[1]).to have_content('Hawaii')
          expect(page.all('.article-title')[2]).to have_content('Paris')
        end

        context '新しい順を選択して検索' do
          it '記事が新しい順に並ぶ' do
            find('#new').click
            find('.button').click
            sleep 2
            expect(page.all('.article-title')[0]).to have_content('Paris')
            expect(page.all('.article-title')[1]).to have_content('Hawaii')
            expect(page.all('.article-title')[2]).to have_content('California')
          end
        end
      end

      context 'いいね順を選択して検索' do
        it '記事がいいね順に並ぶ' do
          create_article_california
          create_article_hawaii
          page.all('.heart')[1].click
          find('.fa-bars').click
          page.all('.dropdown-item')[1].click
          login_as(another_user)
          sleep 2
          create_article_paris
          page.all('.heart')[0].click
          page.all('.heart')[2].click
          find('#favorites').click
          find('.button').click
          sleep 2
          expect(page.all('.article-title')[0]).to have_content('California')
          expect(page.all('.article-title')[1]).to have_content('Paris')
          expect(page.all('.article-title')[2]).to have_content('Hawaii')
        end
      end

      context 'フォローユーザーのみ表示のラジオボタンをクリック' do
        it 'フォロー中のユーザーの投稿のみ表示される' do
          create_article_california
          create_article_hawaii
          find('.fa-bars').click
          page.all('.dropdown-item')[1].click
          login_as(another_user)
          sleep 2
          find('.area-changer-unselected').click
          sleep 2
          page.all("#article-user-#{user.id}")[0].click
          find('.follow-button').click
          create_article_paris
          find('#followingRadioButton').click
          sleep 2
          expect(page).to have_content('California')
          expect(page).to have_content('Hawaii')
          expect(page).to_not have_content('Paris')
          page.save_screenshot 'screenshot.png'
        end
      end
    end
  end
end
