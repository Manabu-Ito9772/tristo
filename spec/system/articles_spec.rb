require 'rails_helper'

RSpec.describe "Articles", type: :system do
  let(:article) { create(:article) }
  let(:article_normal) { create(:article, :normal) }
  let(:article_only_with_event) { create(:article, :only_with_event) }
  let(:article_without_transportation_cost) { create(:article, :without_transportation_cost) }
  let(:article_without_transportation_description) { create(:article, :without_transportation_description) }

  describe '記事一覧画面' do
    context '記事一覧画面にアクセス' do
      it '記事一覧が表示される' do
        article
        visit root_path
        expect(page).to have_content(article.title)
        expect(page).to have_content(article.description)
        expect(page).to have_content(article.region.name)
      end
    end
  end

  describe '記事詳細画面' do
    describe '記事情報ブロック' do
      it '記事詳細ブロックが表示される' do
        article_normal
        visit root_path
        find('.article-main').click
        expect(page).to have_content('時間')
        expect(page).to have_content('イベント')
        expect(page).to have_content('場所')
        expect(page).to have_content('コスト')
        expect(page).to have_content('コメント')
        expect(page).to have_content(article_normal.days.first.info_blocks.first.event)
        expect(page).to have_content(article_normal.days.first.info_blocks.first.place)
        expect(page).to have_content(article_normal.days.first.info_blocks.first.place_info)
        expect(page).to have_content(article_normal.days.first.info_blocks.first.spendings.first.description)
        expect(page).to have_content(article_normal.days.first.info_blocks.first.spendings.first.cost)
        expect(page).to have_content(article_normal.days.first.info_blocks.first.comment)
        expect(page).to have_content(article_normal.days.first.info_blocks.first.transportations.first.description)
        expect(page).to have_content(article_normal.days.first.info_blocks.first.transportations.first.cost)
      end

      it 'データがない場合はラベルが表示されない' do
        article_only_with_event
        visit root_path
        find('.article-main').click
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
        find('.article-main').click
        expect(page).to have_content(article_normal.title)
        expect(page).to have_content(article_normal.region.country.name)
        expect(page).to have_content(article_normal.region.name)
        expect(page).to have_content(article_normal.description)
      end
    end

    describe '総コスト' do
      it '総コストボタンが表示される' do
        article_normal
        visit root_path
        find('.article-main').click
        expect(page).to have_content('総コスト')
      end

      it 'コストが保存されていない場合は総コストボタンが表示されない' do
        article_only_with_event
        visit root_path
        find('.article-main').click
        expect(page).to_not have_content('総コスト')
      end

      context '総コストボタンを押す' do
        it '総コストが表示される' do
          article_normal
          visit root_path
          find('.article-main').click
          click_on '総コスト'
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

      it 'データのない項目のラベルは総コストに表示されない' do
        article_without_transportation_cost
        visit root_path
        find('.article-main').click
        click_on '総コスト'
        expect(page).to_not have_content('観光費')
        expect(page).to_not have_content('アクティビティ費')
        expect(page).to_not have_content('食費')
        expect(page).to_not have_content('お土産代')
        expect(page).to_not have_content('宿泊費')
        expect(page).to_not have_content('その他')
        page.save_screenshot 'screenshot.png'
      end

      it '交通手段のコストが保存されていない場合は総コストに表示されない' do
        article_without_transportation_cost
        visit root_path
        find('.article-main').click
        click_on '総コスト'
        expect(page).to_not have_content(
          article_without_transportation_cost.days.first.info_blocks.first.transportations.first.description
        )
      end

      it '交通手段の説明が保存されていない場合は交通手段の名前が説明として総コストに表示される' do
        article_without_transportation_description
        visit root_path
        find('.article-main').click
        click_on '総コスト'
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

    describe '日付ボタン' do
      it '日付ボタンが表示される' do
        article_normal
        visit root_path
        find('.article-main').click
        expect(page).to have_content('1日目')
        expect(page).to have_content('2日目')
        expect(page).to have_content('3日目')
      end

      context '日付ボタンを押す' do
        it '記事情報ブロックカラムが切り替わる' do
          article_normal
          visit root_path
          find('.article-main').click
          click_on '2日目'
          expect(page).to have_content(article_normal.days.second.info_blocks.first.event)
          click_on '3日目'
          expect(page).to have_content(article_normal.days.third.info_blocks.first.event)
        end
      end
    end
  end
end
