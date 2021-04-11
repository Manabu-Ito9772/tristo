require 'rails_helper'

RSpec.describe '記事検索', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user, :another_user) }
  let(:japan) { create(:country, :domestic) }
  let(:usa) { create(:country, :usa) }
  let(:france) { create(:country, :france) }
  let(:china) { create(:country, :china) }

  before {
    japan
    usa
    france
    china
    login_as(user)

    visit '/create_trip'
    fill_in 'タイトル', with: 'Tokyo'
    within('.prefecture') do
      find('.vs__search').set('東京')
      find('.vs__dropdown-menu').click
    end
    click_on '詳細入力ページへ進む'
    sleep 3
    fill_in 'イベント', with: 'TestEvent'
    page.all('.save-button')[2].click
    find('.post-button').click
    sleep 3

    visit '/create_trip'
    fill_in 'タイトル', with: 'Osaka'
    within('.prefecture') do
      find('.vs__search').set('大阪')
      find('.vs__dropdown-menu').click
    end
    within('.prefecture') do
      find('.vs__search').set('福岡')
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
    click_on '詳細入力ページへ進む'
    sleep 3
    fill_in 'イベント', with: 'TestEvent'
    page.all('.save-button')[2].click
    find('.post-button').click
    sleep 3
    page.all('.heart')[0].click

    visit '/create_trip'
    click_on '海外'
    fill_in 'タイトル', with: 'California'
    within('.country') do
      find('.vs__search').set('アメリカ')
      find('.vs__dropdown-menu').click
    end
    within('.region') do
      find('.vs__search').set('カリフォルニア')
      find('.vs__dropdown-menu').click
    end
    click_on '詳細入力ページへ進む'
    sleep 3
    fill_in 'イベント', with: 'TestEvent'
    page.all('.save-button')[2].click
    find('.post-button').click
    sleep 3

    visit '/create_trip'
    click_on '海外'
    fill_in 'タイトル', with: 'Hawaii'
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
    within('.tag') do
      find('.vs__search').set('Tag')
      find('.vs__dropdown-menu').click
    end
    within('.tag') do
      find('.vs__search').set('Tag2')
      find('.vs__dropdown-menu').click
    end
    click_on '詳細入力ページへ進む'
    sleep 3
    fill_in 'イベント', with: 'TestEvent'
    page.all('.save-button')[2].click
    find('.post-button').click
    sleep 3
    page.all('.heart')[0].click

    find('.fa-bars').click
    page.all('.dropdown-item')[1].click

    login_as(another_user)

    visit '/create_trip'
    fill_in 'タイトル', with: 'Fukuoka'
    within('.prefecture') do
      find('.vs__search').set('福岡')
      find('.vs__dropdown-menu').click
    end
    within('.tag') do
      find('.vs__search').set('Tag')
      find('.vs__dropdown-menu').click
    end
    click_on '詳細入力ページへ進む'
    sleep 3
    fill_in 'イベント', with: 'TestEvent'
    page.all('.save-button')[2].click
    find('.post-button').click
    sleep 3
    page.all('.heart')[0].click
    page.all('.heart')[1].click

    visit '/create_trip'
    click_on '海外'
    fill_in 'タイトル', with: 'Paris'
    within('.country') do
      find('.vs__search').set('フランス')
      find('.vs__dropdown-menu').click
    end
    within('.region') do
      find('.vs__search').set('パリ')
      find('.vs__dropdown-menu').click
    end
    within('.tag') do
      find('.vs__search').set('Tag')
      find('.vs__dropdown-menu').click
    end
    click_on '詳細入力ページへ進む'
    sleep 3
    fill_in 'イベント', with: 'TestEvent'
    page.all('.save-button')[2].click
    find('.post-button').click
    sleep 3
    page.all('.heart')[0].click
    page.all('.heart')[1].click

    page.all('.user-name')[1].click
    click_on 'フォロー'
    visit root_path
    sleep 3
    find('.area-changer-unselected').click
    sleep 3
  }

  describe '国内記事' do
    context '国内ボタンをクリック' do
      it '国内記事一覧が表示される' do
        expect(page).to have_content('Tokyo')
        expect(page).to have_content('Osaka')
        expect(page).to have_content('Fukuoka')
        expect(page).to_not have_content('California')
        expect(page).to_not have_content('Hawaii')
        expect(page).to_not have_content('Paris')
      end

      context '都道府県を選択して検索' do
        it '記事がある場合は表示される' do
          within('#prefecture') do
            find('.vs__search').set('福岡')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 3
          expect(page).to have_content('Osaka')
          expect(page).to have_content('Fukuoka')
          expect(page).to_not have_content('Tokyo')
        end

        it '記事がない場合は表示されない' do
          within('#prefecture') do
            find('.vs__search').set('沖縄')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 3
          expect(page).to have_content('投稿がありません')
          expect(page).to_not have_content('Tokyo')
          expect(page).to_not have_content('Osaka')
          expect(page).to_not have_content('Fukuoka')
        end
      end

      context '都道府県を複数選択して検索' do
        it '記事がある場合は表示される' do
          within('#prefecture') do
            find('.vs__search').set('大阪')
            find('.vs__dropdown-menu').click
          end
          within('#prefecture') do
            find('.vs__search').set('福岡')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 3
          expect(page).to have_content('Osaka')
          expect(page).to_not have_content('Tokyo')
          expect(page).to_not have_content('Fukuoka')
        end
      end

      context 'タグを入力して検索' do
        it '記事がある場合は表示される' do
          within('#tag') do
            find('.vs__search').set('Tag')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 3
          expect(page).to have_content('Osaka')
          expect(page).to have_content('Fukuoka')
          expect(page).to_not have_content('Tokyo')
        end

        it '記事がない場合は表示されない' do
          within('#tag') do
            find('.vs__search').set('TagAnother')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 3
          expect(page).to have_content('投稿がありません')
          expect(page).to_not have_content('Osaka')
          expect(page).to_not have_content('Fukuoka')
          expect(page).to_not have_content('Tokyo')
        end
      end

      context 'タグを複数入力して検索' do
        it '記事がある場合は表示される' do
          within('#tag') do
            find('.vs__search').set('Tag')
            find('.vs__dropdown-menu').click
          end
          within('#tag') do
            find('.vs__search').set('Tag2')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 3
          expect(page).to have_content('Osaka')
          expect(page).to_not have_content('Fukuoka')
          expect(page).to_not have_content('Tokyo')
        end
      end

      context 'フリーワードを入力して検索' do
        it '記事がある場合は表示される' do
          fill_in 'フリーワード', with: 'a'
          find('.button').click
          sleep 3
          expect(page).to have_content('Osaka')
          expect(page).to have_content('Fukuoka')
          expect(page).to_not have_content('Tokyo')
        end

        it '記事がない場合は表示されない' do
          fill_in 'フリーワード', with: 'test'
          find('.button').click
          sleep 3
          expect(page).to have_content('投稿がありません')
          expect(page).to_not have_content('Osaka')
          expect(page).to_not have_content('Fukuoka')
          expect(page).to_not have_content('Tokyo')
        end
      end

      context 'フリーワードを複数入力して検索' do
        it '記事がある場合は表示される' do
          fill_in 'フリーワード', with: 'a s'
          find('.button').click
          sleep 3
          expect(page).to have_content('Osaka')
          expect(page).to_not have_content('Fukuoka')
          expect(page).to_not have_content('Tokyo')
        end
      end

      context '古い順を選択して検索' do
        before {
          find('#old').click
          find('.button').click
          sleep 3
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
            sleep 3
            expect(page.all('.article-title')[0]).to have_content('Fukuoka')
            expect(page.all('.article-title')[1]).to have_content('Osaka')
            expect(page.all('.article-title')[2]).to have_content('Tokyo')
          end
        end
      end

      context 'いいね順を選択して検索' do
        it '記事がいいね順に並ぶ' do
          find('#favorites').click
          find('.button').click
          sleep 3
          expect(page.all('.article-title')[0]).to have_content('Osaka')
          expect(page.all('.article-title')[1]).to have_content('Fukuoka')
          expect(page.all('.article-title')[2]).to have_content('Tokyo')
        end
      end

      context 'フォローユーザーのみ表示のラジオボタンをクリック' do
        before {
          find('#followingRadioButton').click
          sleep 3
        }

        it 'フォロー中のユーザーの投稿のみ表示される' do
          expect(page).to have_content('Tokyo')
          expect(page).to have_content('Osaka')
          expect(page).to_not have_content('Fukuoka')
        end

        context '都道府県を選択して検索' do
          before {
            within('#prefecture') do
              find('.vs__search').set('大阪')
              find('.vs__dropdown-menu').click
            end
            find('.button').click
            sleep 3
          }

          it '記事がある場合は表示される' do
            expect(page).to have_content('Osaka')
            expect(page).to_not have_content('Fukuoka')
            expect(page).to_not have_content('Tokyo')
          end

          context 'タグを入力して検索' do
            before {
              within('#tag') do
                find('.vs__search').set('Tag')
                find('.vs__dropdown-menu').click
              end
              find('.button').click
              sleep 3
            }

            it '記事がある場合は表示される' do
              expect(page).to have_content('Osaka')
              expect(page).to_not have_content('Fukuoka')
              expect(page).to_not have_content('Tokyo')
            end

            context 'フリーワードを入力して検索' do
              it '記事がある場合は表示される' do
                fill_in 'フリーワード', with: 'Osaka'
                find('.button').click
                sleep 3
                expect(page).to have_content('Osaka')
                expect(page).to_not have_content('Fukuoka')
                expect(page).to_not have_content('Tokyo')
              end
            end
          end
        end
      end
    end

    context '海外ボタンをクリック' do
      before {
        find('.area-changer-unselected').click
        sleep 3
      }

      it '海外記事一覧が表示される' do
        expect(page).to have_content('California')
        expect(page).to have_content('Hawaii')
        expect(page).to have_content('Paris')
        expect(page).to_not have_content('Tokyo')
        expect(page).to_not have_content('Osaka')
        expect(page).to_not have_content('Fukuoka')
      end

      context '国を選択して検索' do
        before {
          within('#country') do
            find('.vs__search').set('アメリカ')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 3
        }

        it '記事がある場合は表示される' do
          expect(page).to have_content('California')
          expect(page).to have_content('Hawaii')
          expect(page).to_not have_content('Paris')
        end

        it '記事がない場合は表示されない' do
          find('.vs__clear').click
          within('#country') do
            find('.vs__search').set('中国')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 3
          expect(page).to have_content('投稿がありません')
          expect(page).to_not have_content('California')
          expect(page).to_not have_content('Hawaii')
          expect(page).to_not have_content('Paris')
        end

        context '地域を選択して検索' do
          it '記事がある場合は表示される' do
            within('#area') do
              find('.vs__search').set('カリフォルニア')
              find('.vs__dropdown-menu').click
            end
            find('.button').click
            sleep 3
            expect(page).to have_content('California')
            expect(page).to have_content('Hawaii')
            expect(page).to_not have_content('Paris')
          end

          it '記事がない場合は表示されない' do
            within('#area') do
              find('.vs__search').set('ニューヨーク')
              find('.vs__dropdown-menu').click
            end
            find('.button').click
            sleep 3
            expect(page).to have_content('投稿がありません')
            expect(page).to_not have_content('California')
            expect(page).to_not have_content('Hawaii')
            expect(page).to_not have_content('Paris')
          end
        end

        context '地域を複数選択して検索' do
          it '記事がある場合は表示される' do
            within('#area') do
              find('.vs__search').set('カリフォルニア')
              find('.vs__dropdown-menu').click
            end
            within('#area') do
              find('.vs__search').set('ハワイ')
              find('.vs__dropdown-menu').click
            end
            find('.button').click
            sleep 3
            expect(page).to have_content('Hawaii')
            expect(page).to_not have_content('California')
            expect(page).to_not have_content('Paris')
          end
        end
      end

      context 'タグを入力して検索' do
        it '記事がある場合は表示される' do
          within('#tag') do
            find('.vs__search').set('Tag')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 3
          expect(page).to have_content('Hawaii')
          expect(page).to have_content('Paris')
          expect(page).to_not have_content('California')
        end

        it '記事がない場合は表示されない' do
          within('#tag') do
            find('.vs__search').set('TagAnother')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 3
          expect(page).to have_content('投稿がありません')
          expect(page).to_not have_content('California')
          expect(page).to_not have_content('Hawaii')
          expect(page).to_not have_content('Paris')
        end
      end

      context 'タグを複数入力して検索' do
        it '記事がある場合は表示される' do
          within('#tag') do
            find('.vs__search').set('Tag')
            find('.vs__dropdown-menu').click
          end
          within('#tag') do
            find('.vs__search').set('Tag2')
            find('.vs__dropdown-menu').click
          end
          find('.button').click
          sleep 3
          expect(page).to have_content('Hawaii')
          expect(page).to_not have_content('California')
          expect(page).to_not have_content('Paris')
        end
      end

      context 'フリーワードを入力して検索' do
        it '記事がある場合は表示される' do
          fill_in 'フリーワード', with: 'w'
          find('.button').click
          sleep 3
          expect(page).to have_content('Hawaii')
          expect(page).to_not have_content('California')
          expect(page).to_not have_content('Paris')
        end

        it '記事がない場合は表示されない' do
          fill_in 'フリーワード', with: 'test'
          find('.button').click
          sleep 3
          expect(page).to have_content('投稿がありません')
          expect(page).to_not have_content('California')
          expect(page).to_not have_content('Hawaii')
          expect(page).to_not have_content('Paris')
        end
      end

      context 'フリーワードを複数入力して検索' do
        it '記事がある場合は表示される' do
          fill_in 'フリーワード', with: 'l f'
          find('.button').click
          sleep 3
          expect(page).to have_content('California')
          expect(page).to_not have_content('Hawaii')
          expect(page).to_not have_content('Paris')
        end
      end

      context '古い順を選択して検索' do
        before {
          find('#old').click
          find('.button').click
          sleep 3
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
            sleep 3
            expect(page.all('.article-title')[0]).to have_content('Paris')
            expect(page.all('.article-title')[1]).to have_content('Hawaii')
            expect(page.all('.article-title')[2]).to have_content('California')
          end
        end
      end

      context 'いいね順を選択して検索' do
        it '記事がいいね順に並ぶ' do
          find('#favorites').click
          find('.button').click
          sleep 3
          expect(page.all('.article-title')[0]).to have_content('Hawaii')
          expect(page.all('.article-title')[1]).to have_content('Paris')
          expect(page.all('.article-title')[2]).to have_content('California')
        end
      end

      context 'フォローユーザーのみ表示のラジオボタンをクリック' do
        before {
          find('#followingRadioButton').click
          sleep 3
        }

        it 'フォロー中のユーザーの投稿のみ表示される' do
          expect(page).to have_content('California')
          expect(page).to have_content('Hawaii')
          expect(page).to_not have_content('Paris')
        end

        context '国を選択して検索' do
          before {
            within('#country') do
              find('.vs__search').set('アメリカ')
              find('.vs__dropdown-menu').click
            end
            find('.button').click
            sleep 3
          }

          it '記事がある場合は表示される' do
            expect(page).to have_content('California')
            expect(page).to have_content('Hawaii')
            expect(page).to_not have_content('Paris')
          end

          context '地域を選択して検索' do
            before {
              within('#area') do
                find('.vs__search').set('カリフォルニア')
                find('.vs__dropdown-menu').click
              end
              find('.button').click
              sleep 3
            }

            it '記事がある場合は表示される' do
              expect(page).to have_content('California')
              expect(page).to have_content('Hawaii')
              expect(page).to_not have_content('Paris')
            end

            context 'タグを入力して検索' do
              before {
                within('#tag') do
                  find('.vs__search').set('Tag')
                  find('.vs__dropdown-menu').click
                end
                find('.button').click
                sleep 3
              }

              it '記事がある場合は表示される' do
                expect(page).to have_content('Hawaii')
                expect(page).to_not have_content('California')
                expect(page).to_not have_content('Paris')
              end

              context 'フリーワードを入力して検索' do
                it '記事がある場合は表示される' do
                  fill_in 'フリーワード', with: 'w'
                  find('.button').click
                  sleep 3
                  expect(page).to have_content('Hawaii')
                  expect(page).to_not have_content('California')
                  expect(page).to_not have_content('Paris')
                  page.save_screenshot 'screenshot.png'
                end
              end
            end
          end
        end
      end
    end
  end
end
