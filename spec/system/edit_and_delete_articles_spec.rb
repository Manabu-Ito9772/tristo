require 'rails_helper'

RSpec.describe "記事編集/削除", type: :system do
  let(:country) { create_list(:country, 3, :normal) }
  let(:country_japan) { create(:country, :japan_tokyo_kanagawa) }
  let(:create_article_japan) {
    country_japan
    visit '/create_trip'
    fill_in 'タイトル', with: 'TestTitle'
    fill_in '説明', with: 'TestDescription'
    within('.prefecture') do
      find('.vs__search').set('東京')
      find('.vs__dropdown-menu').click
    end
    find("input[name='旅行開始日']").click
    page.all('.cell')[8].click
    find("input[name='旅行終了日']").click
    page.all('.cell')[10].click
    fill_in 'マップ', with: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=17HzQVLk9-3JyLYxvCBQmvWjtlaomn4xd" width="640" height="480"></iframe>'
    within('.tag') do
      find('.vs__search').set('Tag')
      find('.vs__dropdown-menu').click
    end
    click_on '詳細入力ページへ進む'
    sleep 5
  }
  let(:create_article_overseas) {
    country
    visit '/create_trip'
    click_on '海外'
    fill_in 'タイトル', with: 'TestTitle'
    fill_in '説明', with: 'TestDescription'
    within('.country') do
      find('.vs__search').set(country[1].name)
      find('.vs__dropdown-menu').click
    end
    within('.region') do
      find('.vs__search').set(country[1].regions.first.name)
      find('.vs__dropdown-menu').click
    end
    find("input[name='旅行開始日']").click
    page.all('.cell')[8].click
    find("input[name='旅行終了日']").click
    page.all('.cell')[10].click
    fill_in 'マップ', with: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=17HzQVLk9-3JyLYxvCBQmvWjtlaomn4xd" width="640" height="480"></iframe>'
    within('.tag') do
      find('.vs__search').set('Tag')
      find('.vs__dropdown-menu').click
    end
    click_on '詳細入力ページへ進む'
    sleep 5
  }
  let(:create_block) {
    find('.arriving_time').click
    find('.hours').click
    find('.minutes').click
    find('.leaving_time').click
    find('.hours').click
    find('.minutes').click
    fill_in 'イベント', with: 'TestEvent'
    fill_in '場所', with: 'TestPlace'
    fill_in 'ホームページURL', with: 'TestPlaceURL'
    page.all('.save-button')[0].click
    within('.spending') do
      fill_in '内容', with: 'TestSpending'
      select '観光費', from: 'ジャンル'
      fill_in '価格', with: '500'
    end
    page.all('.save-button')[1].click
    within('.transport') do
      fill_in '内容', with: 'TestTransport'
      select '電車', from: '手段'
      fill_in '価格', with: '1000'
    end
    fill_in 'コメント', with: 'TestComment'
    page.all('.save-button')[2].click
    sleep 5
  }

  describe '記事編集' do
    context '記事詳細のメニューボタンをクリックし、「旅行記録を編集」をクリック' do
      describe '記事概要欄（国内）' do
        before {
          create_article_japan
          create_block
          find('.post-button').click
          sleep 5
          click_on country_japan.articles.first.title
          sleep 3
          find('.edit-menu').click
          sleep 3
          find('.edit-button').click
        }

        context '概要ボタンをクリック' do
          before { click_on '概要' }

          it '記事概要が表示される' do
            expect(page).to have_content('タイトル')
            expect(page).to have_content('説明')
            expect(page).to have_content('都道府県')
            expect(page).to have_content('日程')
            expect(page).to have_content('タグ')
            expect(page).to have_content('マップ')
            expect(page).to have_content(country_japan.articles.first.title)
            expect(page).to have_content(country_japan.articles.first.description)
            expect(page).to have_content(country_japan.regions.first.name)
            expect(page).to have_content(country_japan.articles.first.start_date.strftime("%-m/%-d"))
            expect(page).to have_content(country_japan.articles.first.end_date.strftime("%-m/%-d"))
            expect(page).to have_content(country_japan.articles.first.tags.first.name)
            expect(page).to have_content(country_japan.articles.first.map)
          end

          it 'データが保存されていない項目は表示されない' do
            visit '/create_trip'
            fill_in 'タイトル', with: 'SmallData'
            find('.prefecture').click
            find('.vs__dropdown-menu').click
            click_on '詳細入力ページへ進む'
            sleep 3
            find('.post-button').click
            sleep 3
            click_on 'SmallData'
            sleep 3
            find('.edit-menu').click
            sleep 3
            find('.edit-button').click
            click_on '概要'

            expect(page).to have_content('タイトル')
            expect(page).to have_content('都道府県')
            expect(page).to_not have_content('説明')
            expect(page).to_not have_content('日程')
            expect(page).to_not have_content('タグ')
            expect(page).to_not have_content('マップ')
          end

          it 'ブロック追加フォームの「ブロックを追加」ボタンが非表示になる' do
            expect(page).to_not have_button('ブロックを追加')
          end

          context '編集ボタンをクリック' do
            before { find('.edit-button').click }
            it '概要編集フォームが表示される' do
              expect(page).to have_content('* タイトル')
              expect(page).to have_content('説明')
              expect(page).to have_content('* 都道府県')
              expect(page).to have_content('日程')
              expect(page).to have_content('タグ')
              expect(page).to have_content('マップ')
              expect(page).to have_field('タイトル')
              expect(page).to have_field('説明')
              expect(page).to have_field('旅行開始日')
              expect(page).to have_field('旅行終了日')
              expect(page).to have_field('マップ')
              within('.prefecture') do
                expect(page).to have_css('.vs__search')
              end
              within('.tag') do
                expect(page).to have_css('.vs__search')
              end
            end

            context '編集して保存をクリック' do
              it '概要蘭がアップデートされる' do
                fill_in 'タイトル', with: 'UpdatedTitle'
                fill_in '説明', with: 'UpdatedDescription'
                within('.prefecture') do
                  find('.vs__deselect').click
                  find('.vs__search').set('神奈川')
                  find('.vs__dropdown-menu').click
                end
                find("input[name='旅行開始日']").click
                page.all('.cell')[10].click
                find("input[name='旅行終了日']").click
                page.all('.cell')[12].click
                fill_in 'マップ', with: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=1TFQRmCHcR8rKSoojgc0paPn0XzjyQ2wS" width="640" height="480"></iframe>'
                within('.tag') do
                  find('.vs__deselect').click
                  find('.vs__search').set('UpdatedTag')
                  find('.vs__dropdown-menu').click
                end
                find('.edit-button').click
                sleep 5
                expect(page).to have_content('UpdatedTitle')
                expect(page).to have_content('UpdatedDescription')
                expect(page).to have_content('神奈川')
                expect(page).to have_content(country_japan.articles.first.start_date.strftime("%-m/%-d"))
                expect(page).to have_content(country_japan.articles.first.end_date.strftime("%-m/%-d"))
                expect(page).to have_content('UpdatedTag')
                expect(page).to have_content('https://www.google.com/maps/d/u/0/embed?mid=1TFQRmCHcR8rKSoojgc0paPn0XzjyQ2wS')
              end
            end

            context '必須項目を入力せずに保存をクリック' do
              it 'バリデーションメッセージが表示される' do
                fill_in 'タイトル', with: ' '
                fill_in '説明', with: ' '
                within('.prefecture') do
                  find('.vs__deselect').click
                end
                page.all('.vdp-datepicker__clear-button')[0].click
                page.all('.vdp-datepicker__clear-button')[0].click
                fill_in 'マップ', with: ' '
                within('.tag') do
                  find('.vs__deselect').click
                end
                find('.edit-button').click
                expect(page).to have_content('タイトルは必須項目です')
                expect(page).to have_content('都道府県は必須項目です')
              end
            end
          end
        end
      end

      describe '記事概要蘭（海外）' do
        before {
          create_article_overseas
          create_block
          find('.post-button').click
          sleep 5
          click_on country[1].articles.first.title
          sleep 3
          find('.edit-menu').click
          sleep 3
          find('.edit-button').click
        }

        context '概要ボタンをクリック' do
          before { click_on '概要' }

          it '記事概要が表示される' do
            expect(page).to have_content('タイトル')
            expect(page).to have_content('説明')
            expect(page).to have_content('国と地域')
            expect(page).to have_content('日程')
            expect(page).to have_content('タグ')
            expect(page).to have_content('マップ')
            expect(page).to have_content(country[1].articles.first.title)
            expect(page).to have_content(country[1].articles.first.description)
            expect(page).to have_content(country[1].regions.first.name)
            expect(page).to have_content(country[1].articles.first.start_date.strftime("%-m/%-d"))
            expect(page).to have_content(country[1].articles.first.end_date.strftime("%-m/%-d"))
            expect(page).to have_content(country[1].articles.first.tags.first.name)
            expect(page).to have_content(country[1].articles.first.map)
          end

          it 'データが保存されていない項目は表示されない' do
            visit '/create_trip'
            click_on '海外'
            fill_in 'タイトル', with: 'SmallData'
            find('.country').click
            find('.vs__dropdown-menu').click
            click_on '詳細入力ページへ進む'
            sleep 3
            find('.post-button').click
            sleep 3
            click_on 'SmallData'
            sleep 3
            find('.edit-menu').click
            sleep 3
            find('.edit-button').click
            click_on '概要'
            expect(page).to have_content('タイトル')
            expect(page).to have_content('国と地域')
            expect(page).to_not have_content('説明')
            expect(page).to_not have_content('日程')
            expect(page).to_not have_content('タグ')
            expect(page).to_not have_content('マップ')
          end

          it 'ブロック追加フォームの「ブロックを追加」ボタンが非表示になる' do
            expect(page).to_not have_button('ブロックを追加')
          end

          context '編集ボタンをクリック' do
            it '概要編集フォームが表示される' do
              find('.edit-button').click
              expect(page).to have_content('* タイトル')
              expect(page).to have_content('説明')
              expect(page).to have_content('* 国')
              expect(page).to have_content('地域')
              expect(page).to have_content('日程')
              expect(page).to have_content('タグ')
              expect(page).to have_content('マップ')
              expect(page).to have_field('タイトル')
              expect(page).to have_field('説明')
              expect(page).to have_field('旅行開始日')
              expect(page).to have_field('旅行終了日')
              expect(page).to have_field('マップ')
              within('.country') do
                expect(page).to have_css('.vs__search')
              end
              within('.region') do
                expect(page).to have_css('.vs__search')
              end
              within('.tag') do
                expect(page).to have_css('.vs__search')
              end
            end

            context '編集して保存をクリック' do
              it '概要蘭がアップデートされる' do
                find('.edit-button').click
                fill_in 'タイトル', with: 'UpdatedTitle'
                fill_in '説明', with: 'UpdatedDescription'
                within('.country') do
                  find('.vs__search').set(country[2].name)
                  find('.vs__dropdown-menu').click
                end
                within('.region') do
                  find('.vs__search').set(country[2].regions.first.name)
                  find('.vs__dropdown-menu').click
                end
                find("input[name='旅行開始日']").click
                page.all('.cell')[10].click
                find("input[name='旅行終了日']").click
                page.all('.cell')[12].click
                fill_in 'マップ', with: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=1TFQRmCHcR8rKSoojgc0paPn0XzjyQ2wS" width="640" height="480"></iframe>'
                within('.tag') do
                  find('.vs__deselect').click
                  find('.vs__search').set('UpdatedTag')
                  find('.vs__dropdown-menu').click
                end
                find('.edit-button').click
                sleep 5
                expect(page).to have_content('UpdatedTitle')
                expect(page).to have_content('UpdatedDescription')
                expect(page).to have_content(country[2].name)
                expect(page).to have_content(country[2].regions.first.name)
                expect(page).to have_content(country[2].articles.first.start_date.strftime("%-m/%-d"))
                expect(page).to have_content(country[2].articles.first.end_date.strftime("%-m/%-d"))
                expect(page).to have_content('UpdatedTag')
                expect(page).to have_content('https://www.google.com/maps/d/u/0/embed?mid=1TFQRmCHcR8rKSoojgc0paPn0XzjyQ2wS')
              end
            end

            context '必須項目を入力せずに保存をクリック' do
              it 'バリデーションメッセージが表示される' do
                find('.edit-button').click
                fill_in 'タイトル', with: ' '
                fill_in '説明', with: ' '
                within('.region') do
                  find('.vs__deselect').click
                end
                page.all('.vdp-datepicker__clear-button')[0].click
                page.all('.vdp-datepicker__clear-button')[0].click
                fill_in 'マップ', with: ' '
                within('.tag') do
                  find('.vs__deselect').click
                end
                find('.edit-button').click
                expect(page).to have_content('タイトルは必須項目です')
              end
            end
          end
        end
      end

      describe 'ブロックフォーム' do
        before {
          create_article_overseas
          create_block
          find('.post-button').click
          sleep 5
          click_on country[1].articles.first.title
          sleep 3
          find('.edit-menu').click
          sleep 3
          find('.edit-button').click
        }

        it 'ブロックフォームが表示されている' do
          within('.info-block-form') do
            expect(page).to have_content('時間')
            expect(page).to have_content('* イベント')
            expect(page).to have_content('場所')
            expect(page).to have_content('コスト')
            expect(page).to have_content('次のスポットまでの移動手段')
            expect(page).to have_content('コメント')
            expect(page).to have_content('アイキャッチ')
            expect(page).to have_css('.arriving_time')
            expect(page).to have_css('.leaving_time')
            expect(page).to have_field('イベント')
            expect(page).to have_field('場所')
            expect(page).to have_field('ホームページURL')
            page.all('.save-button')[0].click
            within('.spending') do
              expect(page).to have_field('内容')
              expect(page).to have_select('ジャンル')
              expect(page).to have_field('価格')
            end
            page.all('.save-button')[1].click
            within('.transport') do
              expect(page).to have_field('内容')
              expect(page).to have_select('手段')
              expect(page).to have_field('価格')
            end
          end
        end

        context 'ブロックフォームを入力して「ブロックを追加」をクリック' do
          before {
            click_on '2日目'
            find('.arriving_time').click
            find('.hours').click
            find('.minutes').click
            find('.leaving_time').click
            find('.hours').click
            find('.minutes').click
            fill_in 'イベント', with: 'TestEvent'
            fill_in '場所', with: 'TestPlace'
            fill_in 'ホームページURL', with: 'TestPlaceURL'
            page.all('.save-button')[0].click
            within('.spending') do
              fill_in '内容', with: 'TestSpending'
              select '観光費', from: 'ジャンル'
              fill_in '価格', with: '500'
            end
            page.all('.save-button')[1].click
            within('.transport') do
              fill_in '内容', with: 'TestTransport'
              select '電車', from: '手段'
              fill_in '価格', with: '1000'
            end
            fill_in 'コメント', with: 'TestComment'
            page.all('.save-button')[2].click
            sleep 5
          }

          it 'ブロックリストにブロックが追加される' do
            within('.info-block') {
              expect(page).to have_content('時間')
              expect(page).to have_content('イベント')
              expect(page).to have_content('場所')
              expect(page).to have_content('コスト')
              expect(page).to have_content('コメント')
              expect(page).to have_content('1:05')
              expect(page).to have_content('TestEvent')
              expect(page).to have_content('TestPlace')
              expect(page).to have_content('TestPlaceURL')
              expect(page).to have_content('TestSpending')
              expect(page).to have_content('500')
            }
            expect(page).to have_content('TestTransport')
            expect(page).to have_content('1,000')
          end

          it 'ブロックフォームがリセットされる' do
            within('.info-block-form') do
              expect(page).to_not have_content('1:05')
              expect(page).to_not have_content('TestEvent')
              expect(page).to_not have_content('TestPlace')
              expect(page).to_not have_content('TestPlaceURL')
              expect(page).to_not have_content('TestSpending')
              expect(page).to_not have_content('TestTransport')
              expect(page).to_not have_content('500')
              expect(page).to_not have_content('1000')
            end
          end
        end

        context '必須項目を入力せずに「ブロックを追加」をクリック' do
          it 'バリデーションメッセージが表示される' do
            page.all('.save-button')[0].click
            page.all('.save-button')[1].click
            page.all('.save-button')[2].click
            expect(page).to have_content('イベントは必須項目です')
            expect(page).to have_content('内容は必須項目です')
            expect(page).to have_content('価格は必須項目です')
            expect(page).to have_content('手段は必須項目です')
          end
        end

        context 'コストブロックの価格に数値以外を入力して「ブロックを追加」をクリック' do
          it 'バリデーションメッセージが表示される' do
            page.all('.save-button')[0].click
            page.all('.save-button')[1].click
            within('.spending') do
              fill_in '価格', with: 'a'
              expect(page).to have_content('価格は半角数字で入力してください')
            end
            within('.transport') do
              fill_in '価格', with: 'a'
              expect(page).to have_content('価格は半角数字で入力してください')
            end
          end
        end
      end

      describe 'ブロックプレビュー' do
        before {
          create_article_overseas
          create_block
          find('.post-button').click
          sleep 5
          click_on country[1].articles.first.title
          sleep 3
          find('.edit-menu').click
          sleep 3
          find('.edit-button').click
        }

        it 'ブロックがない場合は「ブロックを追加してください」と表示される' do
          click_on '2日目'
          expect(page).to have_content('ブロックを追加してください')
        end

        context '編集ボタンをクリック' do
          before { find('.fa-edit').click }
          it 'ブロック編集フォームが表示される' do
            expect(page).to have_css('.block-form-to-edit')
          end

          context '編集して「保存」をクリック' do
            it 'ブロックがアップデートされる' do
              within('.block-form-to-edit') do
                page.all('.clear-btn')[0].click
                page.all('.clear-btn')[0].click
                fill_in 'イベント', with: 'UpdatedTestEvent'
                fill_in '場所', with: 'UpdatedTestPlace'
                fill_in 'ホームページURL', with: 'UpdatedTestPlaceURL'
                within('.spending') do
                  fill_in '内容', with: 'UpdatedTestSpending'
                  select '食費', from: 'ジャンル'
                  fill_in '価格', with: '1000'
                end
                within('.transport') do
                  fill_in '内容', with: 'UpdatedTestTransport'
                  select '船', from: '手段'
                  fill_in '価格', with: '2000'
                end
                fill_in 'コメント', with: 'UpdatedTestComment'
                page.all('.save-button')[2].click
                sleep 5
              end
              expect(page).to have_content('UpdatedTestEvent')
              expect(page).to have_content('UpdatedTestPlace')
              expect(page).to have_content('UpdatedTestPlaceURL')
              expect(page).to have_content('UpdatedTestSpending')
              expect(page).to have_content('UpdatedTestTransport')
              expect(page).to have_content('1,000')
              expect(page).to have_content('2,000')
            end
          end

          context '必須項目を入力せずに「保存」をクリック' do
            it 'バリデーションメッセージが表示される' do
              within('.block-form-to-edit') do
                page.all('.clear-btn')[0].click
                page.all('.clear-btn')[0].click
                fill_in 'イベント', with: ' '
                fill_in '場所', with: ' '
                fill_in 'ホームページURL', with: ' '
                within('.spending') do
                  fill_in '内容', with: ' '
                  select '食費', from: 'ジャンル'
                  fill_in '価格', with: ' '
                end
                within('.transport') do
                  fill_in '内容', with: ' '
                  select '船', from: '手段'
                  fill_in '価格', with: ' '
                end
                fill_in 'コメント', with: ' '
                page.all('.save-button')[2].click
                expect(page).to have_content('イベントは必須項目です')
                expect(page).to have_content('内容は必須項目です')
                expect(page).to have_content('価格は必須項目です')
              end
            end
          end

          context 'コストブロックの価格に数値以外を入力して「保存」をクリック' do
            it 'バリデーションメッセージが表示される' do
              within('.block-form-to-edit') do
                within('.spending') do
                  fill_in '価格', with: 'a'
                  expect(page).to have_content('価格は半角数字で入力してください')
                end
                within('.transport') do
                  fill_in '価格', with: 'a'
                  expect(page).to have_content('価格は半角数字で入力してください')
                end
              end
            end
          end
        end

        context '複数ブロックある内の一つを編集して保存' do
          it 'その他のブロックの順番が崩れない' do
            fill_in 'イベント', with: 'TestEvent2'
            page.all('.save-button')[2].click
            sleep 3
            fill_in 'イベント', with: 'TestEvent3'
            page.all('.save-button')[2].click
            sleep 3
            page.all('.fa-edit')[1].click
            within('.block-form-to-edit') do
              fill_in 'イベント', with: 'UpdatedTestEvent2'
              page.all('.save-button')[2].click
            end
            sleep 3
            expect(page.all('#event')[0].text).to eq('TestEvent')
            expect(page.all('#event')[1].text).to eq('UpdatedTestEvent2')
            expect(page.all('#event')[2].text).to eq('TestEvent3')
          end
        end

        context '削除ボタンをクリック' do
          it 'ブロックが削除される' do
            page.accept_confirm do
              find('.fa-trash-alt').click
            end
            expect(page).to_not have_css('.info-block')
          end
        end
      end

      describe '日付ボタン' do
        before {
          create_article_overseas
          create_block
          find('.post-button').click
          sleep 5
          click_on country[1].articles.first.title
          sleep 3
          find('.edit-menu').click
          sleep 3
          find('.edit-button').click
        }

        context '日付ボタンをクリック' do
          before { click_on '2日目' }

          it 'ブロックリストが切り替わる' do
            expect(page).to have_content('ブロックを追加してください')
          end

          context 'ブロックフォームを入力して「ブロックを追加」をクリック' do
            it '選択中の日付のブロックリストにブロックが追加される' do
              fill_in 'イベント', with: 'TestEvent'
              fill_in '場所', with: 'TestPlace'
              fill_in 'ホームページURL', with: 'TestPlaceURL'
              page.all('.save-button')[0].click
              within('.spending') do
                fill_in '内容', with: 'TestSpending'
                select '観光費', from: 'ジャンル'
                fill_in '価格', with: '500'
              end
              page.all('.save-button')[1].click
              within('.transport') do
                fill_in '内容', with: 'TestTransport'
                select '電車', from: '手段'
                fill_in '価格', with: '1000'
              end
              fill_in 'コメント', with: 'TestComment'
              page.all('.save-button')[2].click
              sleep 5
              expect(page).to have_content('TestEvent')
              expect(page).to have_content('TestPlace')
              expect(page).to have_content('TestPlaceURL')
              expect(page).to have_content('TestSpending')
              expect(page).to have_content('TestTransport')
              expect(page).to have_content('500')
              expect(page).to have_content('1,000')
            end
          end
        end

        context '日付追加ボタンをクリック' do
          it '日付が追加される' do
            find('.add-day-button').click
            expect(page).to have_content('4日目')
          end
        end

        context '日付削除ボタンをクリック' do
          it '日付ボタンとその日付に紐付くブロックが削除される' do
            page.accept_confirm do
              find('.btn-white').click
            end
            expect(page).to have_content('1日目')
            expect(page).to have_content('2日目')
            expect(page).to_not have_content('3日目')
          end

          it '削除処理後に1日目の日付ボタンとそれに紐づくブロックが選択される' do
            click_on '2日目'
            page.accept_confirm do
              find('.btn-white').click
            end
            within('.day-number-selected') do
              expect(page).to have_content('1日目')
            end
          end
        end

        context '未選択の日付ボタンの削除ボタンをクリック' do
          it '削除処理後に1日目の日付ボタンとそれに紐づくブロックが選択される' do
            page.accept_confirm do
              page.all('.btn-green')[0].click
            end
            within('.day-number-selected') do
              expect(page).to have_content('1日目')
            end
          end
        end

        it '日付が1日しかない場合は削除ボタンは表示されない' do
          page.accept_confirm do
            find('.btn-white').click
          end
          page.accept_confirm do
            find('.btn-green').click
          end
          expect(page).to_not have_css('.fa-times-circle')
        end
      end
    end
  end

  describe '記事保存' do
    context '記事概要・記事詳細を編集後「保存する」をクリック' do
      it '記事が更新され詳細ページに遷移（国内）' do
        create_article_japan
        create_block
        find('.post-button').click
        sleep 5
        click_on country_japan.articles.first.title
        sleep 3
        find('.edit-menu').click
        sleep 3
        find('.edit-button').click

        click_on '概要'
        find('.edit-button').click
        fill_in 'タイトル', with: 'UpdatedTitle'
        fill_in '説明', with: 'UpdatedDescription'
        within('.prefecture') do
          find('.vs__deselect').click
          find('.vs__search').set('神奈川')
          find('.vs__dropdown-menu').click
        end
        find("input[name='旅行開始日']").click
        page.all('.cell')[10].click
        find("input[name='旅行終了日']").click
        page.all('.cell')[12].click
        fill_in 'マップ', with: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=1TFQRmCHcR8rKSoojgc0paPn0XzjyQ2wS" width="640" height="480"></iframe>'
        within('.tag') do
          find('.vs__deselect').click
          find('.vs__search').set('UpdatedTag')
          find('.vs__dropdown-menu').click
        end
        find('.edit-button').click
        sleep 5

        click_on '1日目'
        find('.fa-edit').click
        within('.block-form-to-edit') do
          page.all('.clear-btn')[0].click
          page.all('.clear-btn')[0].click
          fill_in 'イベント', with: 'UpdatedEvent'
          fill_in '場所', with: 'UpdatedPlace'
          fill_in 'ホームページURL', with: 'UpdatedPlaceURL'
          within('.spending') do
            fill_in '内容', with: 'UpdatedSpending'
            select '食費', from: 'ジャンル'
            fill_in '価格', with: '1000'
          end
          within('.transport') do
            fill_in '内容', with: 'UpdatedTransport'
            select '船', from: '手段'
            fill_in '価格', with: '2000'
          end
          fill_in 'コメント', with: 'UpdatedComment'
          page.all('.save-button')[2].click
          sleep 5
        end
        find('.post-button').click
        sleep 5

        expect(page).to have_content('UpdatedTitle')
        expect(page).to have_content('UpdatedDescription')
        expect(page).to have_content('神奈川')
        expect(page).to have_content(country_japan.articles.first.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(country_japan.articles.first.end_date.strftime("%-m/%-d"))
        expect(page).to have_content('UpdatedTag')

        expect(page).to have_content('UpdatedEvent')
        expect(page).to have_content('UpdatedPlace')
        expect(page).to have_content('UpdatedPlaceURL')
        expect(page).to have_content('UpdatedSpending')
        expect(page).to have_content('UpdatedComment')
        expect(page).to have_content('UpdatedTransport')
        expect(page).to have_content('1,000')
        expect(page).to have_content('2,000')
      end

      it '記事が更新され詳細ページに遷移（国内）' do
        create_article_overseas
        create_block
        find('.post-button').click
        sleep 5
        click_on country[1].articles.first.title
        sleep 3
        find('.edit-menu').click
        sleep 3
        find('.edit-button').click

        click_on '概要'
        find('.edit-button').click
        fill_in 'タイトル', with: 'UpdatedTitle'
        fill_in '説明', with: 'UpdatedDescription'
        within('.country') do
          find('.vs__search').set(country[2].name)
          find('.vs__dropdown-menu').click
        end
        within('.region') do
          find('.vs__search').set(country[2].regions.first.name)
          find('.vs__dropdown-menu').click
        end
        find("input[name='旅行開始日']").click
        page.all('.cell')[10].click
        find("input[name='旅行終了日']").click
        page.all('.cell')[12].click
        fill_in 'マップ', with: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=1TFQRmCHcR8rKSoojgc0paPn0XzjyQ2wS" width="640" height="480"></iframe>'
        within('.tag') do
          find('.vs__deselect').click
          find('.vs__search').set('UpdatedTag')
          find('.vs__dropdown-menu').click
        end
        find('.edit-button').click
        sleep 5

        click_on '1日目'
        find('.fa-edit').click
        within('.block-form-to-edit') do
          page.all('.clear-btn')[0].click
          page.all('.clear-btn')[0].click
          fill_in 'イベント', with: 'UpdatedEvent'
          fill_in '場所', with: 'UpdatedPlace'
          fill_in 'ホームページURL', with: 'UpdatedPlaceURL'
          within('.spending') do
            fill_in '内容', with: 'UpdatedSpending'
            select '食費', from: 'ジャンル'
            fill_in '価格', with: '1000'
          end
          within('.transport') do
            fill_in '内容', with: 'UpdatedTransport'
            select '船', from: '手段'
            fill_in '価格', with: '2000'
          end
          fill_in 'コメント', with: 'UpdatedComment'
          page.all('.save-button')[2].click
          sleep 5
        end
        find('.post-button').click
        sleep 5

        expect(page).to have_content('UpdatedTitle')
        expect(page).to have_content('UpdatedDescription')
        expect(page).to have_content(country[2].name)
        expect(page).to have_content(country[2].regions.first.name)
        expect(page).to have_content(country[2].articles.first.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(country[2].articles.first.end_date.strftime("%-m/%-d"))
        expect(page).to have_content('UpdatedTag')

        expect(page).to have_content('UpdatedEvent')
        expect(page).to have_content('UpdatedPlace')
        expect(page).to have_content('UpdatedPlaceURL')
        expect(page).to have_content('UpdatedSpending')
        expect(page).to have_content('UpdatedComment')
        expect(page).to have_content('UpdatedTransport')
        expect(page).to have_content('1,000')
        expect(page).to have_content('2,000')
        page.save_screenshot 'screenshot.png'
      end
    end
  end
end
