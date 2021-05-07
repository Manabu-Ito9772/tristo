# Tristo
アプリURL：https://www.tristo.work/<br>
Qiita記事：https://qiita.com/Manabu-Ito9772/items/5e2cad71cac90dd7b654
<br><br>
## サービス概要
旅行が好きな人に<br>
旅行の記録を詳細に残せる場を提供する<br>
旅行記録・共有サービスです。
### サービスをつくった背景
私は旅行に行った際、次の旅行の参考にしたり、思い出にふけったりするために、<br>
旅行の記録をスマホにメモしていたのですが、それをより詳細かつ体系的にまとめたいという思いから<br>
本サービスの開発に至りました。<br>
私のようにとにかく事細かに旅行の記録を残したいという方や、<br>
他人の旅行記録を参考にしたいという方に、本サービスを活用して頂ければ幸いです。
### 登場人物
- 旅行の記録を詳細に残しておきたい方
- 他人の旅行記録を参照したい方
### ユーザーが抱える課題
- 自分が行った旅行を詳細かつ分かりやすくまとめたい。
- 実際に旅行に行ってきた人の情報を、自分の旅行計画の参考にしたい。
### 解決方法
いつどこで何をしていくら使ったかを記録できるサービスを提供する。
### 望む未来
旅行の詳細情報を記録したり、他者の旅行記録を参考にしたりすることで、<br>
旅行好きの人がより良い旅行を実現し、さらに旅行を好きになってくれることを願っています。
### マーケット
20代〜40代の旅行好きな人
<br><br>
## 使用技術
### バックエンド
- Ruby 2.6.5
- Rails 6.1.3.1
- RSpec 3.10.1
#### 主要なGem
- sorcery 0.16.0
- jwt 2.2.2
- active_model_serializers 0.10.12
- kaminari 1.2.1
- rails_admin 2.0.2
- rspec-rails 5.0.1
#### ER図
[![Image from Gyazo](https://i.gyazo.com/f61a9ade003524f216f988f95969d4c2.png)](https://gyazo.com/f61a9ade003524f216f988f95969d4c2)
### フロントエンド
- Vue 2.6.12
- axios 0.21.1
- vue-router 3.5.1
- vuex 3.6.2
- vuex-persistedstate 4.0.0-beta.3
- vue-mq 1.0.1
- mobile-device-detect 0.4.3
- vee-validate 3.4.5
- vue-select 3.11.2
- vue-dropdown-menu 0.1.4
- vuejs-datepicker 1.6.2
- vue2-timepicker 1.1.6
- moment 2.29.1
- vue-infinite-loading 2.4.5
- vue-loader 15.9.6
- vue-js-modal 2.0.0-rc.6
- v-scroll-lock 1.3.1
- vue-fontawesome 2.0.2
- bootstrap 4.5.3
<br><br>
### インフラストラクチャー
- Nginx 1.12.1
- Unicorn 6.0.0
- AWS
  - VPC
  - EC2
    - Amazon Linux 2 
  - RDS
    - MySQL 5.7.26
  - S3
  - ALB
  - Route53
  - ACM
#### インフラ構成図
![image](https://user-images.githubusercontent.com/72731672/117455959-a6900e00-af82-11eb-854d-a61b6e8f7621.png)
