countries = [
  ['日本', '円'], ['韓国', 'ウォン'], ['台湾', 'TWD'], ['中国', '元'], ['香港', 'HKD'],
  ['マカオ', 'MOP'], ['モンゴル', 'MNT'], ['フィリピン', 'PHP'], ['ベトナム', 'VND'], ['カンボジア', 'KHR'],
  ['タイ', 'THB'], ['マレーシア', 'MYR'], ['シンガポール', 'SGD'], ['インドネシア', 'IDR'], ['インド', 'INR'],
  ['オーストラリア', 'AUD'], ['ニュージーランド', 'NZD'], ['スペイン', 'ユーロ'], ['ポルトガル', 'ユーロ'], ['フランス', 'ユーロ'],
  ['イギリス', 'ポンド'], ['ドイツ', 'ユーロ'], ['イタリア', 'ユーロ'], ['オランダ', 'ユーロ'], ['スイス', 'CHF'],
  ['ロシア', 'RUB'], ['ギリシャ', 'ユーロ'], ['トルコ', 'TRY'], ['エジプト', 'EGP'], ['カナダ', 'CAD'],
  ['アメリカ', 'ドル'], ['ラオス', 'LAK'], ['ミャンマー', 'MMK'], ['スリランカ', 'LKR'], ['モルディブ', 'MVR'],
  ['グアム', 'ドル'], ['サイパン', 'ドル'], ['ニューカレドニア', 'CFP'], ['フィジー', 'FJD'], ['タヒチ', 'CFP'],
  ['モナコ', 'ユーロ'], ['マルタ', 'ユーロ'], ['ベルギー', 'ユーロ'], ['デンマーク', 'DKK'], ['アイルランド', 'ユーロ'],
  ['ルクセンブルク', 'FJD'], ['ポーランド', 'PLN'], ['チェコ', 'CZK'], ['ハンガリー', 'HUF'], ['オーストリア', 'CFP'],
  ['クロアチア', 'HRK'], ['フィンランド', 'ユーロ'], ['スウェーデン', 'SEK'], ['ノルウェー', 'NOK'], ['ジョージア', 'GEL'],
  ['イスラエル', 'ILS'], ['アラブ首長国連邦', 'AED'], ['ウズベキスタン', 'UZD'], ['南アフリカ', 'ZAR'], ['モロッコ', 'MAD'],
  ['メキシコ', 'MXN'], ['キューバ', 'CUP'], ['ブラジル', 'BRL'], ['ペルー', 'PEN'], ['アルゼンチン', 'ARS'], ['チリ', 'CLP']
]

countries.each.with_index(1) do |country, i|
  Country.create!(name: country[0], currency: country[1], order: i)
end

japan_regions = [
  '北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県', '茨城県', '栃木県', '群馬県', '埼玉県', '千葉県',
  '東京都', '神奈川県', '新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県', '岐阜県', '静岡県', '愛知県', '三重県',
  '滋賀県', '京都府', '大阪府', '兵庫県', '奈良県', '和歌山県', '鳥取県', '島根県', '岡山県', '広島県', '山口県', '徳島県',
  '香川県', '愛媛県', '高知県', '福岡県', '佐賀県', '長崎県', '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県'
]

japan_regions.each.with_index(1) do |region, i|
  Country.find_by(name: '日本').regions.create!(name: region, order: i)
end

korea_regions = [
  'ソウル', '仁川', '水原', '春川', '江陵', '安東', '清州', '大田', '公州', '全州',
  '大邱', '浦項', '慶州', '蔚山', '釜山', '馬山', '順天', '光州', '木浦', '済州'
]

korea_regions.each.with_index(1) do |region, i|
  Country.find_by(name: '韓国').regions.create!(name: region, order: i)
end

taiwan_regions = [
  '台北', '新北', '桃園', '台中', '台南', '高雄', '新竹', '基隆', '嘉義', '彰化', '屏東', '竹北',
  '員林', '斗六', '台東', '花蓮', '頭份', '南投', '宜蘭', '苗栗', '馬公', '朴子', '太保'
]

taiwan_regions.each.with_index(1) do |region, i|
  Country.find_by(name: '台湾').regions.create!(name: region, order: i)
end

china_regions = [
  '北京', '上海', '重慶', '天津', '南京', '蘇州', '杭州', '武漢', '長沙', '広州',
  '深セン', '海南', '成都', '西安', '鄭州', '石家荘', '大連', '瀋陽', 'ハルビン'
]

china_regions.each.with_index(1) do |region, i|
  Country.find_by(name: '中国').regions.create!(name: region, order: i)
end

hongkong_regions = [
  '香港島', 'ランタオ島', '長洲島', '馬鞍山'
]

hongkong_regions.each.with_index(1) do |region, i|
  Country.find_by(name: '香港').regions.create!(name: region, order: i)
end

mongol_regions = [
  'ウランバートル', 'ウンドゥルハーン', 'チョイバルサン', 'サインシャンド', 'ダルンザドガド',
  'バヤンホンゴル', 'ツェツェルレグ', 'カラコルム', 'ボルガン', 'エルデネト', 'ダルハン',
  'スフバートル', 'ムルン', 'ウリヤスタイ', 'アルタイ', 'ホブド', 'ウルギー', 'オラーンゴム'
]

mongol_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'モンゴル').regions.create!(name: region, order: i)
end

philippines_regions = [
  'マニラ', 'マカティ', 'パサイ', 'タギッグ', 'パシグ', 'ケソン・シティ', 'カローカン', 'アンヘレス', 'バギオ',
  'ビガン', 'ボラカイ', 'イロイロ', 'バコロド', 'セブ', 'ボホル', 'カガヤン・デ・オロ', 'ダバオ', 'サンボアンガ'
]

philippines_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'フィリピン').regions.create!(name: region, order: i)
end

vietnam_regions = [
  'ホーチミン', 'ビエンホア', 'ミト', 'カントー', 'ブンタウ', 'ファンティエト', 'ダラット', 'ニャチャン', 'バンメトート',
  'クイニョン', 'ホイアン', 'ダナン', 'フエ', 'ビン', 'ハノイ', 'ハイフォン', 'ハロン', 'ディエンビエンフー'
]

vietnam_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'ベトナム').regions.create!(name: region, order: i)
end

cambodia_regions = [
  'プノンペン', 'タクマウ', 'ウドン', 'コンポンチャム', 'クラチェ', 'タケオ', 'ケップ',
  'カンポット', 'シアヌークビル', 'クロン・カマーラプハウミン', 'パイリン', 'バッタンバン',
  'シェムリアップ', 'シソポン', 'ロリュオス', 'ポイペト', 'ストゥントレン', 'バンラング'
]

cambodia_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'カンボジア').regions.create!(name: region, order: i)
end

thai_regions = [
  'バンコク', 'ノンタブリー', 'ランシット', 'アユタヤ', 'シーラーチャー', 'パタヤ', 'フワヒン', 'ナコーンラーチャシーマー', 'コーンケン',
  'ウドーンターニー', 'ピッサヌローク', 'メーソート', 'ランパン', 'チェンマイ', 'チェンライ', 'プーケット', 'ハートヤイ', 'サムイ島'
]

thai_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'タイ').regions.create!(name: region, order: i)
end

malaysia_regions = [
  'クアラルンプール', 'プタリン・ジャヤ', 'スバン・ジャヤ', 'シャーアラム', 'クラン', 'プトラジャヤ',
  'スレンバン', 'マラッカ', 'ジョホールバル', 'クアンタン', 'クアラ・トレンガル', 'コタ・バル', 'イポー',
  'ジョージ・タウン', 'アロー・スター', 'クチン', 'ミリ', 'コタキナバル', 'サンダカン'
]

malaysia_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'マレーシア').regions.create!(name: region, order: i)
end

indonesia_regions = [
  'バリ', 'ジャカルタ', 'ブカシ', 'タンゲラン', 'デポック', 'ボゴール', 'バンドン', 'ジョグジャカルタ',
  'スマラン', 'スラバヤ', 'バンジェルマシン', 'バリクパパン', 'マカッサル', 'マナド', 'バンダル・ランプン',
  'パレンバン', 'パダン', 'ペカンバル', 'メダン', 'バンダ・アチェ', 'ビンタン'
]

indonesia_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'インドネシア').regions.create!(name: region, order: i)
end

india_regions = [
  'ニューデリー', 'グルガーオン', 'ノイダ', 'ジョードプル', 'ジャイプル', 'アーグラ', 'ラクナウ', 'ワーラーナシー', 'パトナー', 'コルカタ',
  'ナーグプル', 'アフマダーバード', 'スラト', 'ムンバイ', 'プネー', 'ハイデラバード', 'チェンナイ', 'バンガロール', 'マイソール', 'マドゥライ'
]

india_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'インド').regions.create!(name: region, order: i)
end

ag_regions = [
  'シドニー', 'ニューカッスル', 'ウロンゴン', 'キャンベラ', 'メルボルン', 'バララット', 'アデレード',
  'ローンセストン', 'ホバート', 'ゴールドコースト', 'ブリスベン', 'バイロン・ベイ', 'ノーサ・シャイア', 'ケアンズ',
  'キュランダ', 'タウンズビル', 'ダーウィン', 'アリススプリングス', 'パース', 'フリマントル'
]

ag_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'オーストラリア').regions.create!(name: region, order: i)
end

nz_regions = [
  'オークランド', 'ファンガレイ', 'ハミルトン', 'タウランガ', 'ロトルア', 'タウポ', 'ギズボーン', 'ネーピア',
  'ニュープリマス', 'ファンガヌイ', 'パーマストンノース', 'ウェリントン', 'ネルソン', 'カイコウラ',
  'クライストチャーチ', 'オマルー', 'ダニーデン', 'ワナカ', 'クイーンズタウン', 'インバーカーギル'
]

nz_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'ニュージーランド').regions.create!(name: region, order: i)
end

spain_regions = [
  'マドリード', 'バルセロナ', 'タラゴーナ', 'サラゴサ', 'クエンカ', 'バレンシア', 'パルマ',
  'アリカンテ', 'ムルシア', 'グラナダ', 'ミハス', 'コルドバ', 'セビージャ', 'トレド', 'アランフェス',
  'セゴビア', 'サラマンカ', 'サンティアゴ・デ・コンポステーラ', 'ビルバオ', 'サン・セバスティアン'
]

spain_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'スペイン').regions.create!(name: region, order: i)
end

portugal_regions = [
  'リスボン', 'アルブフェイラ', 'サグレシュ', 'エボラ', 'リスボン', 'カシュカイシュ', 'シントラ',
  'オービドス', 'ナザレ', 'バタリャ', 'レイリア', 'ファティマ', 'トマル', 'コインブラ', 'アベイロ',
  'ビラ・ノバ・デ・ガイア', 'ポルト', 'ギマランイシュ', 'ブラガ', 'コインブラ', 'アベイロ'
]

portugal_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'ポルトガル').regions.create!(name: region, order: i)
end

france_regions = [
  'パリ', 'ベルサイユ', 'オルレアン', 'トゥール', 'レンヌ', 'ナント', 'ボルドー', 'トゥールーズ', 'カルカッソンヌ', 'モンペリエ', 'アヴィニョン',
  'マルセイユ', 'エクサン・プロバンス', 'カンヌ', 'ニース', 'リヨン', 'ディジョン', 'コルマール', 'ストラスブール', 'リール'
]

france_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'フランス').regions.create!(name: region, order: i)
end

uk_regions = [
  'ロンドン', 'オックスフォード', 'ケンブリッジ', 'カンタベリー', 'ブライトン', 'サウサンプトン', 'ボーンマス',
  'エクセター', 'プリマス', 'バース', 'ブリストル', 'バーミンガム', 'ノッティンガム', 'リバプール', 'チェスター',
  'マンチェスター', 'シェフィールド', 'リーズ', 'ヨーク', 'ニューカッスル', 'エジンバラ', 'グラスゴー', 'スターリング',
  'アバディーン', 'インヴァネス', 'カーディフ', 'スウォンジー', 'ニューポート', 'ベルファスト'
]

uk_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'イギリス').regions.create!(name: region, order: i)
end

germany_regions = [
  'ベルリン', 'ポツダム', 'ライプツィヒ', 'ドレステン', 'ニュルンベルク', 'ミュンヘン', 'アウクスブルク', 'シュトゥットガルト',
  'ハイデルベルク', 'マインツ', 'ヴィースバーデン', 'ボン', 'ケルン', 'アーヘン', 'デュッセルドルフ', 'デュイスブルク',
  'エッセ', 'ドルトムント', 'ミュンスター', 'ハノーファー', 'ブレーメン', 'ハンブルク', 'ロストク'
]

germany_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'ドイツ').regions.create!(name: region, order: i)
end

italy_regions = [
  'ローマ', 'ミラノ', 'トリノ', 'ジェノバ', 'ベローナ', 'ヴェネツィア', 'ボローニャ', 'ラベンナ', 'フィレンツェ',  'ピサ',
  'シエナ', 'アッシジ', 'オルビエト', 'バチカン', 'ナポリ', 'アマルフィ', 'マテラ', 'カターニア', 'パレルモ'
]

italy_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'イタリア').regions.create!(name: region, order: i)
end

nl_regions = [
  'アムステルダム', 'ザーンセ・スカンス', 'アルクマール', 'ホールン', 'ハールレム', 'ライデン', 'ハーグ',
  'デルフト', 'ロッテルダム', 'ユトレヒト', 'ブレダー', 'セルトーヘンボス', 'エイントホーフェン',
  'ネイメーヘン', 'アルンヘム', 'アーペルドールン', 'ズウォレ', 'レーワルデン', 'フローニンゲン'
]

nl_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'オランダ').regions.create!(name: region, order: i)
end

sl_regions = [
  'チューリッヒ', 'ヴィンタートゥール', 'バーゼル', 'ザンクト・ガレン', 'アッペンツェル', 'ルツェルン',
  'ダボス', 'サン・モリッツ', 'ブリエンツ', 'グリンデルヴァルト', 'インターラーケン', 'ベルン', 'フリブール',
  'ヌーシャテル', 'ジュネーヴ', 'ローザンヌ', 'モントルー', 'ツェルマット', 'ロカルノ', 'ルガノ'
]

sl_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'スイス').regions.create!(name: region, order: i)
end

russia_regions = [
  'モスクワ', 'セルギエフ・ポサド', 'ニジニ・ノヴゴロド', 'カザン', 'ヴォロネジ', 'ヴォルゴグラード', 'ロストフ・ナ・ドヌー',
  'ソチ', 'ノヴゴロド', 'サンクト・ぺテルブルグ', 'ムルマンスク', 'エカテリンブルク', 'オムスク', 'ノヴォシビルスク',
  'イルクーツク', 'ハバロフスク', 'ウラジオストク', 'ナホトカ', 'ユジノ・サハリンスク', 'ペトロパブロフスク・カムチャツキー'
]

russia_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'ロシア').regions.create!(name: region, order: i)
end

greece_regions = [
  'アテネ', 'ピレウス', 'メガラ', 'コリントス', 'アルゴス', 'スパルティ', 'ミストラス', 'パトラ', 'カイロネイア', 'ハニア',
  'レシムノン', 'イラクリオン', 'ボロス', 'ラリサ', 'カランバカ', 'イオアニア', 'ヴェルギナ', 'テッサロニキ'
]

greece_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'ギリシャ').regions.create!(name: region, order: i)
end

turkey_regions = [
  'イスタンブール', 'エディルネ', 'ブルサ', 'ベルガマ', 'イズミル', 'クシャダス', 'アンタルヤ', 'コンヤ', 'アンカラ', 'サフランボル',
  'カイセリ', 'メルスィン', 'アダナ', 'ガズィアンテプ', 'シャンルウルファ', 'ディヤルバクル', 'エルズルム', 'トラムゾン'
]

turkey_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'トルコ').regions.create!(name: region, order: i)
end

egypt_regions = [
  'カイロ', 'ギザ', 'ダハシュール', 'アルファイユム', 'エル・アラメイン', 'アレクサンドリア',
  'ポート・サイド', 'スエズ', 'ダハブ', 'シャルム・エル・シェイク', 'フルガダ', 'アビドス',
  'デンデラ', 'ルクソール', 'エスナ', 'エドフ', 'コム・オンボ', 'アスワン', 'アブシンベル'
]

egypt_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'エジプト').regions.create!(name: region, order: i)
end

canada_regions = [
  'トロント', 'ロンドン', 'オタワ', 'モントリオール', 'ケベック・シティ', 'シャーロットタウン', 'ハリファクス',
  'サンダー・ベイ', 'ウィニペグ', 'レジャイナ', 'サスカトゥーン', 'エドモントン', 'カルガリー', 'バンフ',
  'ケロウナ', 'ウィスラー', 'バンクーバー', 'ビクトリア', 'ホワイトホース', 'イエローナイフ'
]

canada_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'カナダ').regions.create!(name: region, order: i)
end

usa_regions = [
  'ニューヨーク', 'ボストン', 'フィラデルフィア', 'ボルチモア', 'ワシントンD.C.', 'ピッツバーグ', 'デトロイト',
  'シカゴ', 'ミネアポリス', 'アトランタ', 'オークランド', 'マイアミ', 'ニューオーリンズ', 'ヒューストン',
  'ダラス', 'オースティン', 'サン・アントニオ', 'デンバー', 'ソルトレーク・シティ', 'ラスベガス', 'ロサンゼルス',
  'サンディエゴ', 'サンノゼ', 'サンフランシスコ', 'ポートランド', 'シアトル', 'ハワイ'
]

usa_regions.each.with_index(1) do |region, i|
  Country.find_by(name: 'アメリカ').regions.create!(name: region, order: i)
end
