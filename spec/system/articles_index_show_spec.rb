require 'rails_helper'

RSpec.describe "記事一覧/詳細", type: :system do
  # let(:user) { create(:user) }
  let(:country_japan) { create(:country, :japan) }
  let(:article_normal) { create(:article, :normal) }
  let(:article_wihout_info) { create(:article, :without_info) }
  let(:article_only_with_event) { create(:article, :only_with_event) }
  let(:article_without_transportation_cost) { create(:article, :without_transportation_cost) }
  let(:article_without_transportation_cost_all) { create(:article, :without_transportation_cost_all) }
  let(:article_without_transportation_description) { create(:article, :without_transportation_description) }

  let(:article_normal_set) {
    article_normal
    visit '/trip_notes'
    sleep 2
    find('.area-changer-unselected').click
  }

  # context 'ログインしていない状態でルートにアクセス' do
  #   it '記事一覧ページに遷移する' do
  #     article_normal
  #     visit '/'
  #     sleep 3
  #     expect(current_path).to eq('/trip_notes')
  #     find('.area-changer-unselected').click
  #     sleep 2
  #     expect(page).to have_content(article_normal.title)
  #   end
  # end
  #
  # context 'ログイン状態でルートにアクセス' do
  #   it '記事一覧ページに遷移する' do
  #     article_normal
  #     login_as(user)
  #     visit '/'
  #     sleep 3
  #     expect(current_path).to eq('/trip_notes')
  #     find('.area-changer-unselected').click
  #     sleep 2
  #     expect(page).to have_content(article_normal.title)
  #   end
  # end
  #
  # context 'ログインしていない状態でヘッダーのタイトルをクリック' do
  #   it 'トップページに遷移する' do
  #     visit root_path
  #     find('.header-title').click
  #     expect(current_path).to eq('/')
  #     within('#buttons') do
  #       expect(page).to have_css('.register-btn')
  #     end
  #     expect(page).to have_css('.login-btn')
  #     expect(page).to have_css('.articles-btn')
  #     expect(page).to have_content('旅行記録作成の流れ')
  #     within('#click-now') do
  #       expect(page).to have_css('.register-btn')
  #     end
  #   end
  # end
  #
  # context 'ログインしている状態でヘッダーのタイトルをクリック' do
  #   it '記事一覧ページに遷移する' do
  #     article_normal
  #     login_as(user)
  #     sleep 2
  #     find('.header-title').click
  #     sleep 2
  #     expect(current_path).to eq('/trip_notes')
  #     find('.area-changer-unselected').click
  #     sleep 2
  #     expect(page).to have_content(article_normal.title)
  #   end
  # end

  describe '記事一覧画面' do
    context '記事一覧画面にアクセス' do
      fit '記事が表示される' do
        article_normal_set
        expect(page).to have_content(article_normal.title)
        expect(page).to have_content(article_normal.description)
        expect(page).to have_content(article_normal.country.name)
        expect(page).to have_content(article_normal.regions.first.name)
        expect(page).to have_content(article_normal.start_date.strftime("%Y"))
        expect(page).to have_content(article_normal.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(article_normal.end_date.strftime("%-m/%-d"))
        expect(page).to have_css('#default-avatar')
        expect(page).to have_content(article_normal.tags.first.name)
        expect(page).to have_content(article_normal.user.name)
        page.save_screenshot 'screenshot.png'
      end

      it '記事の説明、地域、日付、タグ、写真はデータがなければ表示されない' do
        article_wihout_info
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        expect(page).to_not have_css('.article-description')
        expect(page).to_not have_css('.article-region')
        expect(page).to_not have_css('.article-date')
        expect(page).to_not have_css('.article-tag')
        expect(page).to_not have_css('.main-image')
      end

      it '国が日本の場合は都道府県のみ表示される' do
        country_japan
        visit '/trip_notes'
        sleep 2
        expect(page).to_not have_content('日本')
        expect(page).to have_content('東京')
      end
    end
  end

  describe '記事詳細画面' do
    describe '記事詳細ブロック' do
      it '記事詳細ブロックが表示される' do
        article_normal_set
        find("#article-item-#{article_normal.id}").click
        expect(page).to have_content('時間')
        expect(page).to have_content('イベント')
        expect(page).to have_content('スポット')
        expect(page).to have_content('コスト')
        expect(page).to have_content('コメント')
        expect(page).to have_content(article_normal.days.first.blocks.first.title)
        expect(page).to have_content(article_normal.days.first.blocks.first.place)
        expect(page).to have_content(article_normal.days.first.blocks.first.place_info)
        expect(page).to have_content(article_normal.days.first.blocks.first.spendings.first.description)
        expect(page).to have_content(article_normal.days.first.blocks.first.spendings.first.cost)
        expect(page).to have_content(article_normal.days.first.blocks.first.comment)
        expect(page).to have_content(article_normal.days.first.blocks.first.transportations.first.description)
        expect(page).to have_content(article_normal.days.first.blocks.first.transportations.first.cost)
      end

      it 'データがない場合はラベルが表示されない' do
        article_only_with_event
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        find("#article-item-#{article_only_with_event.id}").click
        within('.info-block') do
          expect(page).to_not have_content('時間')
          expect(page).to_not have_content('イベント')
          expect(page).to_not have_content('コスト')
          expect(page).to_not have_content('コメント')
          expect(page).to_not have_css('.info-block-photo')
        end
      end
    end

    describe '記事概要' do
      it '記事概要が表示される' do
        article_normal_set
        find("#article-item-#{article_normal.id}").click
        expect(page).to have_content(article_normal.title)
        expect(page).to have_content(article_normal.country.name)
        expect(page).to have_content(article_normal.regions.first.name)
        expect(page).to have_content(article_normal.start_date.strftime("%Y"))
        expect(page).to have_content(article_normal.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(article_normal.end_date.strftime("%-m/%-d"))
        expect(page).to have_css('#default-avatar')
        expect(page).to have_content(article_normal.tags.first.name)
        expect(page).to have_content(article_normal.description)
        expect(page).to have_content(article_normal.user.name)
      end

      it '説明、地域、日付、タグ、写真はデータがなければ表示されない' do
        article_wihout_info
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        find("#article-item-#{article_wihout_info.id}").click
        expect(page).to_not have_css('.article-description')
        expect(page).to_not have_css('.article-region')
        expect(page).to_not have_css('.article-date')
        expect(page).to_not have_css('.article-tag')
        expect(page).to_not have_css('.main-image')
      end

      it '国が日本の場合は都道府県のみ表示される' do
        country_japan
        visit '/trip_notes'
        sleep 2
        find("#article-item-#{country_japan.articles.first.id}").click
        within('.article-overview') {
          expect(page).to_not have_content('日本')
          expect(page).to have_content('東京')
        }
      end
    end

    describe '日付ボタン' do
      it '日付ボタンが表示される' do
        article_normal_set
        find("#article-item-#{article_normal.id}").click
        expect(page).to have_content('1日目')
        expect(page).to have_content('2日目')
        expect(page).to have_content('3日目')
      end

      it '日付が１日しか登録されていない場合は「日帰り」と表示される' do
        article_only_with_event
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        find("#article-item-#{article_only_with_event.id}").click
        expect(page).to have_content('日帰り')
      end

      context '日付ボタンを押す' do
        it '記事情報ブロックカラムが切り替わる' do
          article_normal_set
          find("#article-item-#{article_normal.id}").click
          page.all('.day-number')[0].click
          expect(page).to have_content(article_normal.days.second.blocks.first.title)
          page.all('.day-number')[1].click
          expect(page).to have_content(article_normal.days.third.blocks.first.title)
        end
      end
    end

    describe 'コスト' do
      it 'コストボタンが表示されている' do
        article_normal_set
        find("#article-item-#{article_normal.id}").click
        expect(page).to have_content('コスト')
      end

      it 'コストが保存されていない場合はコストボタンが表示されない' do
        article_only_with_event
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        find("#article-item-#{article_only_with_event.id}").click
        expect(page).to_not have_content('コスト')
      end

      context 'コストボタンを押す' do
        it 'コスト一覧が表示される' do
          article_normal_set
          find("#article-item-#{article_normal.id}").click
          find('.total-cost').click
          expect(page).to have_content('観光費')
          expect(page).to have_content('アクティビティ費')
          expect(page).to have_content('食費')
          expect(page).to have_content('お土産代')
          expect(page).to have_content('宿泊費')
          expect(page).to have_content('交通費')
          expect(page).to have_content('その他')
          expect(page).to have_content('2,100')
        end
      end

      it 'データのない項目のラベルはコスト一覧に表示されない' do
        article_without_transportation_cost
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        find("#article-item-#{article_without_transportation_cost.id}").click
        find('.total-cost').click
        expect(page).to_not have_content('観光費')
        expect(page).to_not have_content('アクティビティ費')
        expect(page).to_not have_content('食費')
        expect(page).to_not have_content('お土産代')
        expect(page).to_not have_content('宿泊費')
        expect(page).to_not have_content('その他')
      end

      it '全ての交通手段のコストの価格が0の場合は交通費のラベルと項目は表示されない' do
        article_without_transportation_cost_all
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        find("#article-item-#{article_without_transportation_cost_all.id}").click
        find('.total-cost').click
        expect(page).to have_content('観光費')
        expect(page).to_not have_content('交通費')
      end

      it '交通手段のコストが保存されていない場合はコスト一覧に表示されない' do
        article_without_transportation_cost
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        find("#article-item-#{article_without_transportation_cost.id}").click
        find('.total-cost').click
        expect(page).to_not have_content(
          article_without_transportation_cost.days.first.blocks.first.transportations.first.description
        )
      end

      it '交通手段の説明が保存されていない場合は交通手段の名前が説明として総コストに表示される' do
        article_without_transportation_description
        visit '/trip_notes'
        sleep 2
        find('.area-changer-unselected').click
        find("#article-item-#{article_without_transportation_description.id}").click
        find('.total-cost').click
        expect(page).to have_content('車')
        expect(page).to have_content('タクシー')
        expect(page).to have_content('バス')
        expect(page).to have_content('電車')
        expect(page).to have_content('船')
        expect(page).to have_content('飛行機')
        expect(page).to have_content('自転車')
        expect(page).to have_content('バイク')
        expect(page).to have_content('その他')
      end
    end

    describe 'マップ' do
      it 'マップボタンが表示されている' do
        article_normal_set
        find("#article-item-#{article_normal.id}").click
        expect(page).to have_content('マップ')
      end

      context 'マップボタンを押す' do
        it 'マップが表示される' do
          article_normal_set
          find("#article-item-#{article_normal.id}").click
          find('.map').click
          expect(page).to have_css('.map')
          page.save_screenshot 'screenshot.png'
        end
      end
    end
  end
end
