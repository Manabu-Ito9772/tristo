require 'rails_helper'

RSpec.describe "記事作成", type: :system do
  let(:user) { create(:user) }
  let(:country) { create_list(:country, 3, :normal) }
  let(:country_japan) { create(:country, :japan_tokyo_kanagawa) }
  let(:create_article_japan) {
    country_japan
    visit '/create_trip_note'
    fill_in 'タイトル', with: 'TestTitle'
    fill_in 'コメント', with: 'TestDescription'
    within('.prefecture') do
      find('.vs__search').set('東京')
      find('.vs__dropdown-menu').click
    end
    find("input[name='旅行開始日']").click
    page.all('.cell')[20].click
    find("input[name='旅行終了日']").click
    page.all('.cell')[22].click
    attach_file('アイキャッチ', 'public/images/sample.png')
    fill_in 'マップ', with: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=17HzQVLk9-3JyLYxvCBQmvWjtlaomn4xd" width="640" height="480"></iframe>'
    within('.tag') do
      find('.vs__search').set('Tag')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
  }
  let(:create_article_overseas) {
    country
    visit '/create_trip_note'
    find('.domestic-btn-unselected').click
    fill_in 'タイトル', with: 'TestTitle'
    fill_in 'コメント', with: 'TestDescription'
    within('.country') do
      find('.vs__search').set(country[1].name)
      find('.vs__dropdown-menu').click
    end
    within('.region') do
      find('.vs__search').set(country[1].regions.first.name)
      find('.vs__dropdown-menu').click
    end
    find("input[name='旅行開始日']").click
    page.all('.cell')[20].click
    find("input[name='旅行終了日']").click
    page.all('.cell')[22].click
    attach_file('アイキャッチ', 'public/images/sample.png')
    fill_in 'マップ', with: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=17HzQVLk9-3JyLYxvCBQmvWjtlaomn4xd" width="640" height="480"></iframe>'
    within('.tag') do
      find('.vs__search').set('Tag')
      find('.vs__dropdown-menu').click
    end
    find('.button').click
    sleep 2
  }
  let(:create_block) {
    find('.arriving_time').click
    find('.hours').click
    find('.minutes').click
    find('.leaving_time').click
    find('.hours').click
    find('.minutes').click
    fill_in 'イベント', with: 'TestEvent'
    fill_in 'スポット', with: 'TestPlace'
    fill_in 'ホームページURL', with: 'TestPlaceURL'
    page.all('.add-cost-button')[0].click
    within('.spending') do
      fill_in '内容', with: 'TestSpending'
      select '観光費', from: 'ジャンル'
      fill_in '価格', with: '500'
    end
    page.all('.add-cost-button')[1].click
    within('.transport') do
      fill_in '内容', with: 'TestTransport'
      select '電車', from: '手段'
      fill_in '価格', with: '1000'
    end
    fill_in 'メモ', with: 'TestMemmo'
    within('.info-block-form') do
      find('.add-button').click
    end
    sleep 2
  }
  before {
    login_as(user)
    sleep 2
  }

  describe '記事概要作成画面' do
    context '記事概要作成画面にアクセス' do
      it '国内記事概要作成フォームが表示される' do
        visit '/create_trip_note'
        expect(page).to have_content('旅行記録作成')
        expect(page).to have_css('.domestic-btn-unselected')
        expect(page).to have_css('.domestic-btn')
        expect(page).to have_content('タイトル')
        expect(page).to have_content('コメント')
        expect(page).to have_content('都道府県')
        expect(page).to have_content('期間')
        expect(page).to have_content('日数のみ入力')
        expect(page).to have_content('アイキャッチ')
        expect(page).to have_content('タグ')
        expect(page).to have_content('マップ')
        expect(page).to have_field('タイトル')
        expect(page).to have_field('コメント')
        expect(page).to have_field('旅行開始日')
        expect(page).to have_field('旅行終了日')
        expect(page).to have_field('アイキャッチ')
        expect(page).to have_select('日数')
        expect(page).to have_field('マップ')
        within('.prefecture') do
          expect(page).to have_css('.vs__search')
        end
        within('.tag') do
          expect(page).to have_css('.vs__search')
        end
        expect(page).to have_css('.button')
      end

      it '「海外」をクリックすることで海外記事概要作成フォームに切り替わる' do
        visit '/create_trip_note'
        find('.domestic-btn-unselected').click
        expect(page).to have_content('旅行記録作成')
        expect(page).to have_content('タイトル')
        expect(page).to have_content('コメント')
        expect(page).to have_content('国')
        expect(page).to have_content('地域')
        expect(page).to have_content('期間')
        expect(page).to have_content('日数のみ入力')
        expect(page).to have_content('アイキャッチ')
        expect(page).to have_content('タグ')
        expect(page).to have_content('マップ')
        expect(page).to have_field('タイトル')
        expect(page).to have_field('コメント')
        expect(page).to have_field('旅行開始日')
        expect(page).to have_field('旅行終了日')
        expect(page).to have_field('アイキャッチ')
        expect(page).to have_select('日数')
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
        expect(page).to have_css('.button')
      end
    end

    context '概要作成フォームを入力して「詳細入力ページへ進む」をクリック' do
      it '記事概要が作成され詳細作成ページが表示される（国内フォーム）' do
        create_article_japan
        find('.overview').click
        expect(page).to have_content(country_japan.articles.first.title)
        expect(page).to have_content(country_japan.articles.first.description)
        expect(page).to have_content(country_japan.regions.first.name)
        expect(page).to have_content(country_japan.articles.first.start_date.strftime("%Y"))
        expect(page).to have_content(country_japan.articles.first.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(country_japan.articles.first.end_date.strftime("%-m/%-d"))
        expect(page).to have_content(country_japan.articles.first.tags.first.name)
        expect(page).to have_content(country_japan.articles.first.map)
        expect(page).to have_selector("img[src$='sample.png']")
      end

      it '記事概要が作成され詳細作成ページが表示される（海外フォーム）' do
        create_article_overseas
        find('.overview').click
        expect(page).to have_content(country[1].articles.first.title)
        expect(page).to have_content(country[1].articles.first.description)
        expect(page).to have_content(country[1].regions.first.name)
        expect(page).to have_content(country[1].articles.first.start_date.strftime("%Y"))
        expect(page).to have_content(country[1].articles.first.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(country[1].articles.first.end_date.strftime("%-m/%-d"))
        expect(page).to have_content(country[1].articles.first.tags.first.name)
        expect(page).to have_content(country[1].articles.first.map)
        expect(page).to have_selector("img[src$='sample.png']")
      end
    end

    context '日程ではなく日数を入力して「詳細入力ページへ進む」をクリック' do
      it '入力された分の日数が作成され詳細作成ページに遷移する' do
        country_japan
        visit '/create_trip_note'
        fill_in 'タイトル', with: 'TestTitle'
        within('.prefecture') do
          find('.vs__search').set('東京')
          find('.vs__dropdown-menu').click
        end
        select '3日間', from: '日数'
        find('.button').click
        sleep 2
        expect(page).to have_content('1日目')
        expect(page).to have_content('2日目')
        expect(page).to have_content('3日目')
      end
    end

    context '日程の旅行開始日のみを入力し、旅行終了日は入力せずに「詳細入力ページへ進む」をクリック' do
      it '日付が1日だけ作成され詳細作成ページに遷移する' do
        country_japan
        visit '/create_trip_note'
        fill_in 'タイトル', with: 'TestTitle'
        within('.prefecture') do
          find('.vs__search').set('東京')
          find('.vs__dropdown-menu').click
        end
        find("input[name='旅行開始日']").click
        page.all('.cell')[20].click
        find('.button').click
        sleep 2
        expect(page).to have_content('1日目')
        expect(page).to_not have_content('2日目')
      end
    end

    context '日程の旅行終了日のみを入力し、旅行開始日は入力せずに「詳細入力ページへ進む」をクリック' do
      it '日付が1日だけ作成され詳細作成ページに遷移する' do
        country_japan
        visit '/create_trip_note'
        fill_in 'タイトル', with: 'TestTitle'
        within('.prefecture') do
          find('.vs__search').set('東京')
          find('.vs__dropdown-menu').click
        end
        find("input[name='旅行終了日']").click
        page.all('.cell')[22].click
        find('.button').click
        sleep 2
        expect(page).to have_content('1日目')
        expect(page).to_not have_content('2日目')
      end
    end

    context '日程の旅行開始日と旅行終了日で同じ日付を選択して「詳細入力ページへ進む」をクリック' do
      it '日付が1日だけ作成され詳細作成ページに遷移する' do
        country_japan
        visit '/create_trip_note'
        fill_in 'タイトル', with: 'TestTitle'
        within('.prefecture') do
          find('.vs__search').set('東京')
          find('.vs__dropdown-menu').click
        end
        find("input[name='旅行開始日']").click
        page.all('.cell')[20].click
        find("input[name='旅行終了日']").click
        page.all('.cell')[20].click
        find('.button').click
        sleep 2
        expect(page).to have_content('1日目')
        expect(page).to_not have_content('2日目')
      end
    end

    context 'アイキャッチを選択したのちXボタンをクリック' do
      it 'アイキャッチの選択が解除される' do
        visit '/create_trip_note'
        attach_file('アイキャッチ', 'public/images/sample.png')
        expect(page).to have_css('#preview-eyecatch')
        find('.icon').click
        expect(page).to_not have_css('#preview-eyecatch')
      end
    end

    context 'マップの詳しくはこちらをクリック' do
      it 'マップ埋め込み説明のモーダルが表示さえる' do
        visit '/create_trip_note'
        click_on '地図の埋め込み方'
        expect(page).to have_content('旅行記録に「Google My Maps」を埋め込む方法')
      end
    end

    context '必須項目を入力せずに「詳細入力ページへ進む」をクリック' do
      it 'バリデーションメッセージが表示されてページ遷移しない（国内フォーム）' do
        country_japan
        visit '/create_trip_note'
        find('.button').click
        expect(page).to have_content('タイトルは必須項目です')
        expect(page).to have_content('都道府県は必須項目です')
      end

      it 'バリデーションメッセージが表示されてページ遷移しない（海外フォーム）' do
        country
        visit '/create_trip_note'
        find('.domestic-btn-unselected').click
        find('.button').click
        expect(page).to have_content('タイトルは必須項目です')
        expect(page).to have_content('国は必須項目です')
      end
    end
  end

  describe '記事詳細作成画面' do
    describe '記事概要蘭（国内）' do
      before {
        create_article_japan
        find('.overview').click
      }

      context '概要ボタンをクリック' do
        it '記事概要が表示される' do
          expect(page).to have_content('タイトル')
          expect(page).to have_content('コメント')
          expect(page).to have_content('都道府県')
          expect(page).to have_content('期間')
          expect(page).to have_content('アイキャッチ')
          expect(page).to have_content('タグ')
          expect(page).to have_content('マップ')
          expect(page).to have_content(country_japan.articles.first.title)
          expect(page).to have_content(country_japan.articles.first.description)
          expect(page).to have_content(country_japan.regions.first.name)
          expect(page).to have_content(country_japan.articles.first.start_date.strftime("%Y"))
          expect(page).to have_content(country_japan.articles.first.start_date.strftime("%-m/%-d"))
          expect(page).to have_content(country_japan.articles.first.end_date.strftime("%-m/%-d"))
          expect(page).to have_selector("img[src$='sample.png']")
          expect(page).to have_content(country_japan.articles.first.tags.first.name)
          expect(page).to have_content(country_japan.articles.first.map)
        end

        it 'データが保存されていない項目は表示されない' do
          visit '/create_trip_note'
          fill_in 'タイトル', with: 'Test'
          find('.prefecture').click
          find('.vs__dropdown-menu').click
          find('.button').click
          sleep 2
          find('.overview').click
          expect(page).to_not have_content('コメント')
          expect(page).to_not have_content('期間')
          expect(page).to_not have_content('アイキャッチ')
          expect(page).to_not have_content('タグ')
          expect(page).to_not have_content('マップ')
        end

        it 'ブロック追加フォームの「ブロックを追加」ボタンが非表示になる' do
          expect(page).to_not have_button('ブロックを追加')
        end
      end

      context '概要欄の編集ボタンをクリック' do
        before { find('.edit-button').click }

        it '概要編集フォームが表示される' do
          sleep 2
          expect(page).to have_content('タイトル')
          expect(page).to have_content('コメント')
          expect(page).to have_content('都道府県')
          expect(page).to have_content('期間')
          expect(page).to have_content('アイキャッチ')
          expect(page).to have_content('タグ')
          expect(page).to have_content('マップ')
          expect(page).to have_field('タイトル')
          expect(page).to have_field('コメント')
          expect(page).to have_field('旅行開始日')
          expect(page).to have_field('旅行終了日')
          expect(page).to have_field('アイキャッチ')
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
            fill_in 'コメント', with: 'UpdatedDescription'
            within('.prefecture') do
              find('.vs__deselect').click
              find('.vs__search').set('神奈川')
              find('.vs__dropdown-menu').click
            end
            find("input[name='旅行開始日']").click
            page.all('.cell')[23].click
            find("input[name='旅行終了日']").click
            page.all('.cell')[25].click
            attach_file('アイキャッチ', 'public/images/sample2.png')
            fill_in 'マップ', with: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=1TFQRmCHcR8rKSoojgc0paPn0XzjyQ2wS" width="640" height="480"></iframe>'
            within('.tag') do
              find('.vs__deselect').click
              find('.vs__search').set('UpdatedTag')
              find('.vs__dropdown-menu').click
            end
            find('.edit-button').click
            sleep 2
            expect(page).to have_content('UpdatedTitle')
            expect(page).to have_content('UpdatedDescription')
            expect(page).to have_content('神奈川')
            expect(page).to have_content(country_japan.articles.first.start_date.strftime("%Y"))
            expect(page).to have_content(country_japan.articles.first.start_date.strftime("%-m/%-d"))
            expect(page).to have_content(country_japan.articles.first.end_date.strftime("%-m/%-d"))
            expect(page).to have_selector("img[src$='sample2.png']")
            expect(page).to have_content('UpdatedTag')
            expect(page).to have_content('https://www.google.com/maps/d/u/0/embed?mid=1TFQRmCHcR8rKSoojgc0paPn0XzjyQ2wS')
          end
        end

        context 'アイキャッチのXボタンをクリック' do
          it 'アイキャッチが削除される' do
            find('#delete-btn').click
            expect(page).to_not have_selector("img[src$='sample.png']")
            attach_file('アイキャッチ', 'public/images/sample.png')
            expect(page).to have_css('#preview-eyecatch')
            find('#delete-btn').click
            expect(page).to_not have_css('#preview-eyecatch')
          end
        end

        context 'マップの詳しくはこちらをクリック' do
          it 'マップ埋め込み説明のモーダルが表示さえる' do
            click_on '地図の埋め込み方'
            expect(page).to have_content('旅行記録に「Google My Maps」を埋め込む方法')
          end
        end

        context '必須項目を入力せずに保存をクリック' do
          it 'バリデーションメッセージが表示される' do
            fill_in 'タイトル', with: ' '
            fill_in 'コメント', with: ' '
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

    describe '記事概要蘭（海外）' do
      before {
        create_article_overseas
        find('.overview').click
      }
      context '概要ボタンをクリック' do
        it '記事概要が表示される' do
          expect(page).to have_content('タイトル')
          expect(page).to have_content('コメント')
          expect(page).to have_content('国と地域')
          expect(page).to have_content('期間')
          expect(page).to have_content('アイキャッチ')
          expect(page).to have_content('タグ')
          expect(page).to have_content('マップ')
          expect(page).to have_content(country[1].articles.first.title)
          expect(page).to have_content(country[1].articles.first.description)
          expect(page).to have_content(country[1].regions.first.name)
          expect(page).to have_content(country[1].articles.first.start_date.strftime("%Y"))
          expect(page).to have_content(country[1].articles.first.start_date.strftime("%-m/%-d"))
          expect(page).to have_content(country[1].articles.first.end_date.strftime("%-m/%-d"))
          expect(page).to have_selector("img[src$='sample.png']")
          expect(page).to have_content(country[1].articles.first.tags.first.name)
          expect(page).to have_content(country[1].articles.first.map)
        end

        it 'データが保存されていない項目は表示されない' do
          visit '/create_trip_note'
          find('.domestic-btn-unselected').click
          fill_in 'タイトル', with: 'Test'
          find('.country').click
          find('.vs__dropdown-menu').click
          find('.button').click
          sleep 2
          find('.overview').click
          expect(page).to_not have_content('コメント')
          expect(page).to_not have_content('期間')
          expect(page).to_not have_content('アイキャッチ')
          expect(page).to_not have_content('タグ')
          expect(page).to_not have_content('マップ')
        end

        it 'ブロック追加フォームの「ブロックを追加」ボタンが非表示になる' do
          expect(page).to_not have_button('ブロックを追加')
        end
      end

      context '概要欄の編集ボタンをクリック' do
        before { find('.edit-button').click }

        it '概要編集フォームが表示される' do
          sleep 2
          expect(page).to have_content('タイトル')
          expect(page).to have_content('コメント')
          expect(page).to have_content('国')
          expect(page).to have_content('地域')
          expect(page).to have_content('期間')
          expect(page).to have_content('アイキャッチ')
          expect(page).to have_content('タグ')
          expect(page).to have_content('マップ')
          expect(page).to have_field('タイトル')
          expect(page).to have_field('コメント')
          expect(page).to have_field('旅行開始日')
          expect(page).to have_field('旅行終了日')
          expect(page).to have_field('アイキャッチ')
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
            fill_in 'タイトル', with: 'UpdatedTitle'
            fill_in 'コメント', with: 'UpdatedDescription'
            within('.country') do
              find('.vs__search').set(country[2].name)
              find('.vs__dropdown-menu').click
            end
            within('.region') do
              find('.vs__search').set(country[2].regions.first.name)
              find('.vs__dropdown-menu').click
            end
            find("input[name='旅行開始日']").click
            page.all('.cell')[23].click
            find("input[name='旅行終了日']").click
            page.all('.cell')[25].click
            attach_file('アイキャッチ', 'public/images/sample2.png')
            fill_in 'マップ', with: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=1TFQRmCHcR8rKSoojgc0paPn0XzjyQ2wS" width="640" height="480"></iframe>'
            within('.tag') do
              find('.vs__deselect').click
              find('.vs__search').set('UpdatedTag')
              find('.vs__dropdown-menu').click
            end
            find('.edit-button').click
            sleep 2
            expect(page).to have_content('UpdatedTitle')
            expect(page).to have_content('UpdatedDescription')
            expect(page).to have_content(country[2].name)
            expect(page).to have_content(country[2].regions.first.name)
            expect(page).to have_content(country[2].articles.first.start_date.strftime("%Y"))
            expect(page).to have_content(country[2].articles.first.start_date.strftime("%-m/%-d"))
            expect(page).to have_content(country[2].articles.first.end_date.strftime("%-m/%-d"))
            expect(page).to have_selector("img[src$='sample2.png']")
            expect(page).to have_content('UpdatedTag')
            expect(page).to have_content('https://www.google.com/maps/d/u/0/embed?mid=1TFQRmCHcR8rKSoojgc0paPn0XzjyQ2wS')
          end
        end

        context 'アイキャッチのXボタンをクリック' do
          it 'アイキャッチが削除される' do
            find('#delete-btn').click
            expect(page).to_not have_selector("img[src$='sample.png']")
            attach_file('アイキャッチ', 'public/images/sample.png')
            expect(page).to have_css('#preview-eyecatch')
            find('#delete-btn').click
            expect(page).to_not have_css('#preview-eyecatch')
          end
        end

        context '必須項目を入力せずに保存をクリック' do
          it 'バリデーションメッセージが表示される' do
            fill_in 'タイトル', with: ' '
            fill_in 'コメント', with: ' '
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

    describe '記事詳細ブロック' do
      before {
        create_article_overseas
        create_block
      }

      describe 'ブロックフォーム' do
        it 'ブロックフォームが表示されている' do
          within('.info-block-form') do
            expect(page).to have_content('時間')
            expect(page).to have_content('イベント')
            expect(page).to have_content('スポット')
            expect(page).to have_content('コスト')
            expect(page).to have_content('次のスポットまでの移動手段')
            expect(page).to have_content('メモ')
            expect(page).to have_content('写真')
            expect(page).to have_css('.arriving_time')
            expect(page).to have_css('.leaving_time')
            expect(page).to have_field('イベント')
            expect(page).to have_field('スポット')
            expect(page).to have_field('ホームページURL')
            page.all('.add-cost-button')[0].click
            within('.spending') do
              expect(page).to have_field('内容')
              expect(page).to have_select('ジャンル')
              expect(page).to have_field('価格')
            end
            page.all('.add-cost-button')[1].click
            within('.transport') do
              expect(page).to have_field('内容')
              expect(page).to have_select('手段')
              expect(page).to have_field('価格')
            end
          end
        end

        context 'ブロックフォームを入力して「ブロックを追加」をクリック' do
          it 'ブロックリストにブロックが追加される' do
            expect(page).to have_content('時間')
            expect(page).to have_content('イベント')
            expect(page).to have_content('スポット')
            expect(page).to have_content('コスト')
            expect(page).to have_content('メモ')
            expect(page).to have_content('1:05')
            expect(page).to have_content('TestEvent')
            expect(page).to have_content('TestPlace')
            expect(page).to have_content('TestPlaceURL')
            expect(page).to have_content('TestMemmo')
            expect(page).to have_content('TestSpending')
            expect(page).to have_content('TestTransport')
            expect(page).to have_content('500')
            expect(page).to have_content('1,000')
          end

          it 'ブロックフォームがリセットされる' do
            within('.info-block-form') do
              expect(page).to_not have_content('1:05')
              expect(page).to_not have_content('TestEvent')
              expect(page).to_not have_content('TestPlace')
              expect(page).to_not have_content('TestPlaceURL')
              expect(page).to_not have_content('TestMemmo')
              expect(page).to_not have_content('TestSpending')
              expect(page).to_not have_content('TestTransport')
              expect(page).to_not have_content('500')
              expect(page).to_not have_content('1000')
            end
          end
        end

        context 'ブロックを複数作成' do
          before {
            fill_in 'スポット', with: 'TestPlace2'
            within('.info-block-form') do
              find('.add-button').click
            end
            sleep 1
            fill_in 'スポット', with: 'TestPlace3'
            within('.info-block-form') do
              find('.add-button').click
            end
            sleep 1
          }

          it 'ブロックに順番にナンバーが割り当てられる' do
            expect(page.all('#number')[0].text).to eq('No.1')
            expect(page.all('#number')[1].text).to eq('No.2')
            expect(page.all('#number')[2].text).to eq('No.3')
          end

          context '編集フォームでブロックのナンバーを変更' do
            it 'ブロックの順番が入れ替わる' do
              page.all('.fa-edit')[0].click
              within('.block-form-to-edit') do
                select 3, from: 'ナンバー'
                find('.add-button').click
                sleep 2
              end
              page.all('.fa-edit')[2].click
              within('.block-form-to-edit') do
                select 1, from: 'ナンバー'
                find('.add-button').click
                sleep 2
              end
              expect(page.all('#place')[0].text).to eq('TestPlace3')
              expect(page.all('#place')[1].text).to eq('TestPlace2')
              expect(page.all('#place')[2].text).to eq('TestPlace')
            end
          end

          context 'ブロックを削除' do
            it 'ブロックのナンバーが振り直される' do
              page.accept_confirm do
                page.all('.fa-trash-alt')[1].click
              end
              sleep 2
              expect(page.all('#number')[0].text).to eq('No.1')
              expect(page.all('#number')[1].text).to eq('No.2')
              expect(page).to_not have_content('No.3')
              expect(page.all('#place')[0].text).to eq('TestPlace')
              expect(page.all('#place')[1].text).to eq('TestPlace3')
              expect(page).to_not have_content('TestPlace2')
            end
          end
        end

        context 'ブロックを20個作成' do
          it 'ブロック追加ボタンが非表示になりそれ以上ブロックを追加できない' do
            19.times do |i|
              fill_in 'スポット', with: 'TestPlace'
              within('.info-block-form') do
                find('.add-button').click
              end
            end
            sleep 2
            expect(page).to_not have_css('.button')
          end
        end

        context '必須項目を入力せずに「ブロックを追加」をクリック' do
          it 'バリデーションメッセージが表示される' do
            page.all('.add-cost-button')[0].click
            page.all('.add-cost-button')[1].click
            within('.info-block-form') do
              find('.add-button').click
            end
            expect(page).to have_content('スポットは必須項目です')
            expect(page).to have_content('内容を入力してください')
            expect(page).to have_content('価格を入力してください')
            expect(page).to have_content('手段を選択してください')
          end
        end

        context 'コストブロックの価格に数値以外を入力して「ブロックを追加」をクリック' do
          it 'バリデーションメッセージが表示される' do
            page.all('.add-cost-button')[0].click
            page.all('.add-cost-button')[1].click
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
        it 'ブロックがない場合は「ブロックを追加してください」と表示される' do
          page.all('.day-number')[0].click
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
                fill_in 'スポット', with: 'UpdatedTestPlace'
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
                fill_in 'メモ', with: 'UpdatedTestMemmo'
                attach_file('写真', 'public/images/sample.png')
                find('.add-button').click
                sleep 2
              end
              expect(page).to have_content('UpdatedTestEvent')
              expect(page).to have_content('UpdatedTestPlace')
              expect(page).to have_content('UpdatedTestPlaceURL')
              expect(page).to have_content('UpdatedTestMemmo')
              expect(page).to have_content('UpdatedTestSpending')
              expect(page).to have_content('UpdatedTestTransport')
              expect(page).to have_content('1,000')
              expect(page).to have_content('2,000')
              expect(page).to have_selector("img[src$='sample.png']")
            end
          end

          context '写真を選択したのちXボタンをクリック' do
            it '写真の選択が解除される' do
              attach_file('写真', 'public/images/sample.png')
              expect(page).to have_css('#preview-image')
              find('#delete-btn').click
              expect(page).to_not have_css('#preview-image')
            end
          end

          context '必須項目を入力せずに「保存」をクリック' do
            it 'バリデーションメッセージが表示される' do
              within('.block-form-to-edit') do
                page.all('.clear-btn')[0].click
                page.all('.clear-btn')[0].click
                fill_in 'イベント', with: ' '
                fill_in 'スポット', with: ' '
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
                fill_in 'メモ', with: ' '
                find('.add-button').click
                expect(page).to have_content('スポットは必須項目です')
                expect(page).to have_content('内容を入力してください')
                expect(page).to have_content('価格を入力してください')
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
            fill_in 'スポット', with: 'TestPlace2'
            within('.info-block-form') do
              find('.add-button').click
            end
            sleep 1
            fill_in 'スポット', with: 'TestPlace3'
            within('.info-block-form') do
              find('.add-button').click
            end
            sleep 1
            page.all('.fa-edit')[1].click
            within('.block-form-to-edit') do
              fill_in 'スポット', with: 'UpdatedTestPlace2'
              find('.add-button').click
            end
            sleep 1
            expect(page.all('#place')[0].text).to eq('TestPlace')
            expect(page.all('#place')[1].text).to eq('UpdatedTestPlace2')
            expect(page.all('#place')[2].text).to eq('TestPlace3')
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
        before { page.all('.day-number')[0].click }

        context '日付ボタンをクリック' do
          it 'ブロックリストが切り替わる' do
            expect(page).to have_content('ブロックを追加してください')
          end

          context 'ブロックフォームを入力して「ブロックを追加」をクリック' do
            it '選択中の日付のブロックリストにブロックが追加される' do
              fill_in 'イベント', with: 'TestEvent'
              fill_in 'スポット', with: 'TestPlace'
              fill_in 'ホームページURL', with: 'TestPlaceURL'
              page.all('.add-cost-button')[0].click
              within('.spending') do
                fill_in '内容', with: 'TestSpending'
                select '観光費', from: 'ジャンル'
                fill_in '価格', with: '500'
              end
              page.all('.add-cost-button')[1].click
              within('.transport') do
                fill_in '内容', with: 'TestTransport'
                select '電車', from: '手段'
                fill_in '価格', with: '1000'
              end
              fill_in 'メモ', with: 'TestMemmo'
              within('.info-block-form') do
                find('.add-button').click
              end
              sleep 2
              expect(page).to have_content('TestEvent')
              expect(page).to have_content('TestPlace')
              expect(page).to have_content('TestPlaceURL')
              expect(page).to have_content('TestMemmo')
              expect(page).to have_content('TestSpending')
              expect(page).to have_content('TestTransport')
              expect(page).to have_content('500')
              expect(page).to have_content('1,000')
            end
          end
        end

        context '日付追加ボタンをクリック' do
          it '日付が追加される' do
            find('#add-day-button').click
            expect(page).to have_content('4日目')
          end
        end

        context '日付削除ボタンをクリック' do
          it '日付ボタンとその日付に紐付くブロックが削除される' do
            fill_in 'スポット', with: 'TestPlace'
            within('.info-block-form') do
              find('.add-button').click
            end
            sleep 2
            page.accept_confirm do
              find('.icon-white').click
            end
            expect(page).to have_content('2日目')
            expect(page).to_not have_content('3日目')
          end

          it '削除処理後に1日目の日付ボタンとそれに紐づくブロックが選択される' do
            page.accept_confirm do
              find('.icon-white').click
            end
            within('.day-number-selected') do
              expect(page).to have_content('1日目')
            end
          end
        end

        context '未選択の日付ボタンの削除ボタンをクリック' do
          it '削除処理後に1日目の日付ボタンとそれに紐づくブロックが選択される' do
            page.all('.day-number')[0].click
            page.accept_confirm do
              page.all('.icon')[0].click
            end
            within('.day-number-selected') do
              expect(page).to have_content('1日目')
            end
          end
        end

        it '日付が1日しかない場合は削除ボタンは表示されない' do
          page.accept_confirm do
            find('.icon-white').click
          end
          sleep 2
          page.accept_confirm do
            find('.icon-white').click
          end
          sleep 2
          expect(page).to_not have_css('.fa-times-circle')
        end
      end
    end
  end

  describe '記事投稿' do
    context '記事概要・記事詳細を作成後「投稿する」をクリック' do
      it '記事がタイムラインに投稿される（国内）' do
        create_article_japan
        create_block
        find('.post-button').click
        sleep 2

        expect(page).to have_content(country_japan.articles.first.title)
        expect(page).to have_content(country_japan.articles.first.description)
        expect(page).to have_content(country_japan.regions.first.name)
        expect(page).to have_content(country_japan.articles.first.start_date.strftime("%Y"))
        expect(page).to have_content(country_japan.articles.first.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(country_japan.articles.first.end_date.strftime("%-m/%-d"))
        expect(page).to have_content(country_japan.articles.first.tags.first.name)
        expect(page).to have_selector("img[src$='sample.png']")
        expect(page).to have_content(user.name)

        find("#article-item-#{country_japan.articles.first.id}").click
        expect(page).to have_content(country_japan.articles.first.title)
        expect(page).to have_content(country_japan.articles.first.description)
        expect(page).to have_content(country_japan.regions.first.name)
        expect(page).to have_content(country_japan.articles.first.start_date.strftime("%Y"))
        expect(page).to have_content(country_japan.articles.first.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(country_japan.articles.first.end_date.strftime("%-m/%-d"))
        expect(page).to have_content(country_japan.articles.first.tags.first.name)
        expect(page).to have_content('1:05')
        expect(page).to have_content('TestEvent')
        expect(page).to have_content('TestPlace')
        expect(page).to have_content('TestPlaceURL')
        expect(page).to have_content('TestMemmo')
        expect(page).to have_content('TestSpending')
        expect(page).to have_content('TestTransport')
        expect(page).to have_content('500')
        expect(page).to have_content('1,000')
        expect(page).to have_content('1日目')
        expect(page).to have_content('2日目')
        expect(page).to have_content('3日目')
        expect(page).to have_content('コスト')
        expect(page).to have_content('マップ')
      end

      it '記事がタイムラインに投稿される（海外）' do
        create_article_overseas
        create_block
        find('.post-button').click
        sleep 2

        expect(page).to have_content(country[1].articles.first.title)
        expect(page).to have_content(country[1].articles.first.description)
        expect(page).to have_content(country[1].name)
        expect(page).to have_content(country[1].regions.first.name)
        expect(page).to have_content(country[1].articles.first.start_date.strftime("%Y"))
        expect(page).to have_content(country[1].articles.first.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(country[1].articles.first.end_date.strftime("%-m/%-d"))
        expect(page).to have_content(country[1].articles.first.tags.first.name)
        expect(page).to have_selector("img[src$='sample.png']")
        expect(page).to have_content(user.name)

        find("#article-item-#{country[1].articles.first.id}").click
        expect(page).to have_content(country[1].articles.first.title)
        expect(page).to have_content(country[1].articles.first.description)
        expect(page).to have_content(country[1].name)
        expect(page).to have_content(country[1].regions.first.name)
        expect(page).to have_content(country[1].articles.first.start_date.strftime("%Y"))
        expect(page).to have_content(country[1].articles.first.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(country[1].articles.first.end_date.strftime("%-m/%-d"))
        expect(page).to have_content(country[1].articles.first.tags.first.name)
        expect(page).to have_content('1:05')
        expect(page).to have_content('TestEvent')
        expect(page).to have_content('TestPlace')
        expect(page).to have_content('TestPlaceURL')
        expect(page).to have_content('TestMemmo')
        expect(page).to have_content('TestSpending')
        expect(page).to have_content('TestTransport')
        expect(page).to have_content('500')
        expect(page).to have_content('1,000')
        expect(page).to have_content('1日目')
        expect(page).to have_content('2日目')
        expect(page).to have_content('3日目')
        expect(page).to have_content('コスト')
        expect(page).to have_content('マップ')
      end
    end
  end

  describe '記事下書き保存' do
    it 'マイページの下書き記事一覧に記事が保存される（国内）' do
      create_article_japan
      create_block
      find('.draft-button').click
      sleep 2
      within('.post-changer') do
        expect(page).to have_content('下書き')
      end
      expect(page).to have_content(country_japan.articles.first.title)
      expect(page).to have_content(country_japan.articles.first.description)
      expect(page).to have_content(country_japan.regions.first.name)
      expect(page).to have_content(country_japan.articles.first.start_date.strftime("%Y"))
      expect(page).to have_content(country_japan.articles.first.start_date.strftime("%-m/%-d"))
      expect(page).to have_content(country_japan.articles.first.end_date.strftime("%-m/%-d"))
      expect(page).to have_content(country_japan.articles.first.tags.first.name)
      expect(page).to have_selector("img[src$='sample.png']")
      expect(page).to have_content(user.name)
    end

    it 'マイページの下書き記事一覧に記事が保存される（海外）' do
      create_article_overseas
      create_block
      find('.draft-button').click
      sleep 2
      within('.post-changer') do
        expect(page).to have_content('下書き')
      end
      expect(page).to have_content(country[1].articles.first.title)
      expect(page).to have_content(country[1].articles.first.description)
      expect(page).to have_content(country[1].name)
      expect(page).to have_content(country[1].regions.first.name)
      expect(page).to have_content(country[1].articles.first.start_date.strftime("%Y"))
      expect(page).to have_content(country[1].articles.first.start_date.strftime("%-m/%-d"))
      expect(page).to have_content(country[1].articles.first.end_date.strftime("%-m/%-d"))
      expect(page).to have_content(country[1].articles.first.tags.first.name)
      expect(page).to have_selector("img[src$='sample.png']")
      expect(page).to have_content(user.name)
    end
  end
end
