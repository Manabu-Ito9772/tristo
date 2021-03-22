require 'rails_helper'

RSpec.describe "記事一覧/詳細", type: :system do
  let(:country_japan) { create(:country, :japan) }
  let(:article_normal) { create(:article, :normal) }
  let(:article_wihout_info) { create(:article, :without_info) }
  let(:article_only_with_event) { create(:article, :only_with_event) }
  let(:article_without_transportation_cost) { create(:article, :without_transportation_cost) }
  let(:article_without_transportation_description) { create(:article, :without_transportation_description) }

  describe '記事一覧画面' do
    context '記事一覧画面にアクセス' do
      it '記事が表示される' do
        article_normal
        visit root_path
        expect(page).to have_content(article_normal.title)
        expect(page).to have_content(article_normal.description)
        expect(page).to have_content(article_normal.country.name)
        expect(page).to have_content(article_normal.regions.first.name)
        expect(page).to have_content(article_normal.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(article_normal.end_date.strftime("%-m/%-d"))
        expect(page).to have_content(article_normal.tags.first.name)
      end

      it '記事の説明、地域、日付、タグはデータがなければ表示されない' do
        article_wihout_info
        visit root_path
        expect(page).to_not have_css('.article-description')
        expect(page).to_not have_css('.article-region')
        expect(page).to_not have_css('.article-date')
        expect(page).to_not have_css('.article-tag')
      end

      it '国が日本の場合は都道府県のみ表示される' do
        country_japan
        visit root_path
        expect(page).to_not have_content('日本')
        expect(page).to have_content('東京')
      end
    end
  end

  describe '記事詳細画面' do
    describe '記事情報ブロック' do
      it '記事詳細ブロックが表示される' do
        article_normal
        visit root_path
        click_on article_normal.title
        expect(page).to have_content('時間')
        expect(page).to have_content('イベント')
        expect(page).to have_content('場所')
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
        visit root_path
        click_on article_only_with_event.title
        expect(page).to_not have_content('時間')
        expect(page).to_not have_content('場所')
        expect(page).to_not have_content('コスト')
        expect(page).to_not have_content('コメント')
      end
    end

    describe '記事概要' do
      it '記事概要が表示される' do
        article_normal
        visit root_path
        click_on article_normal.title
        expect(page).to have_content(article_normal.title)
        expect(page).to have_content(article_normal.country.name)
        expect(page).to have_content(article_normal.regions.first.name)
        expect(page).to have_content(article_normal.start_date.strftime("%-m/%-d"))
        expect(page).to have_content(article_normal.end_date.strftime("%-m/%-d"))
        expect(page).to have_content(article_normal.tags.first.name)
        expect(page).to have_content(article_normal.description)
      end

      it '説明、地域、日付、タグはデータがなければ表示されない' do
        article_wihout_info
        visit root_path
        click_on article_wihout_info.title
        expect(page).to_not have_css('.article-description')
        expect(page).to_not have_css('.article-region')
        expect(page).to_not have_css('.article-date')
        expect(page).to_not have_css('.article-tag')
      end

      it '国が日本の場合は都道府県のみ表示される' do
        country_japan
        visit root_path
        click_on country_japan.articles.first.title
        expect(page).to_not have_content('日本')
        expect(page).to have_content('東京')
      end
    end

    describe '日付ボタン' do
      it '日付ボタンが表示される' do
        article_normal
        visit root_path
        click_on article_normal.title
        expect(page).to have_content('1日目')
        expect(page).to have_content('2日目')
        expect(page).to have_content('3日目')
      end

      it '日付が１日しか登録されていない場合は「日帰り」と表示される' do
        article_only_with_event
        visit root_path
        click_on article_only_with_event.title
        expect(page).to have_content('日帰り')
      end

      context '日付ボタンを押す' do
        it '記事情報ブロックカラムが切り替わる' do
          article_normal
          visit root_path
          click_on article_normal.title
          click_on '2日目'
          expect(page).to have_content(article_normal.days.second.blocks.first.title)
          click_on '3日目'
          expect(page).to have_content(article_normal.days.third.blocks.first.title)
        end
      end
    end

    describe 'コスト' do
      it 'コストボタンが表示されている' do
        article_normal
        visit root_path
        click_on article_normal.title
        expect(page).to have_content('コスト')
      end

      it 'コストが保存されていない場合はコストボタンが表示されない' do
        article_only_with_event
        visit root_path
        click_on article_only_with_event.title
        expect(page).to_not have_content('コスト')
      end

      context 'コストボタンを押す' do
        it 'コスト一覧が表示される' do
          article_normal
          visit root_path
          click_on article_normal.title
          click_on 'コスト'
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
        visit root_path
        click_on article_without_transportation_cost.title
        click_on 'コスト'
        expect(page).to_not have_content('観光費')
        expect(page).to_not have_content('アクティビティ費')
        expect(page).to_not have_content('食費')
        expect(page).to_not have_content('お土産代')
        expect(page).to_not have_content('宿泊費')
        expect(page).to_not have_content('その他')

      end

      it '交通手段のコストが保存されていない場合はコスト一覧に表示されない' do
        article_without_transportation_cost
        visit root_path
        click_on article_without_transportation_cost.title
        click_on 'コスト'
        expect(page).to_not have_content(
          article_without_transportation_cost.days.first.blocks.first.transportations.first.description
        )
      end

      it '交通手段の説明が保存されていない場合は交通手段の名前が説明として総コストに表示される' do
        article_without_transportation_description
        visit root_path
        click_on article_without_transportation_description.title
        click_on 'コスト'
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
        article_normal
        visit root_path
        click_on article_normal.title
        expect(page).to have_content('マップ')
      end

      context 'マップボタンを押す' do
        it 'マップが表示される' do
          article_normal
          visit root_path
          click_on article_normal.title
          click_on 'マップ'
          expect(page).to have_css('.map')
          page.save_screenshot 'screenshot.png'
        end
      end
    end
  end
end
