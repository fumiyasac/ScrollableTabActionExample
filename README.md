# ScrollableTabActionExample
[ING] - ScrollViewの性質やScrollViewReaderを利用したTab型表現を応用したUI実装サンプル

UIKitを利用時の様な、Tab型のスクロールを活用した動きを伴う形をSwiftUIで実装したものになります。

1. **Contents要素をスワイプで切り替える、または、上部に設置したTab要素を押下すると該当位置まで移動する**
2. **該当Sectionまで移動するとTab要素が伴って移動する、または、上部に設置したTab要素を押下すると該当Section位置までスクロールする**

__【参考資料】__

- [SwiftUI Animated Sticky Header With Auto Scrollable Tabs - Complex Animations - SwiftUI Tutorials](https://www.youtube.com/watch?v=XUeophZ1iTo&t=58s)
- [SwiftUI Scrollable Tab Bar - iOS 17](https://www.youtube.com/watch?v=sCK0W39nVEk)

## 1. サンプル概要

__【認証画面】__

<img src="./images/scroll_tab_page_control1.png" width="320"> <img src="./images/scroll_tab_page_control2.png" width="320">

__【Feed画面】__

<img src="./images/tab_and_scroll_section1.png" width="320"> <img src="./images/tab_and_scroll_section2.png" width="320">

## 2. Mockサーバー環境構築

サンプルアプリ内では、APIモックサーバーから受け取ったJSON形式のレスポンスを画面に表示する処理を実現するために、node.js製の __「json-server」__ を利用して実現しています。（※こちらはTypeScript製のものを利用しています。）

このリポジトリをClone後に下記コマンドを実行することで、自分のローカル環境で動作させる事ができます。

サンプルアプリ内にAPIモックサーバーから受け取ったJSON形式のレスポンスを画面に表示する処理を実現するために、Node.js製の「JSONServer」というものを利用して実現しています。JSONServerに関する概要や基本的な活用方法につきましては下記のリンク等を参考にすると良いかと思います。

※ 自分のLocal環境に`node.js`と`yarn`がインストールされていない場合は、まずはその準備をする必要があります。

__【Local環境で再現する手順】__

```shell
# まずはMockサーバーの場所まで移動する
$ cd SimpleObservationViperExample/Backend
# 必要なpackageのインストール
$ yarn install
# Mockサーバーの実行
$ yarn start
```

※ 自分の手元でまっさらな状態から準備する場合は下記コマンドを順次実行するイメージになります。

__【Local環境で新規作成する場合の手順】__

```shell
# ⭐️ 必要な実行コマンド
# ① package.jsonの新規作成
$ yarn init -y
# ② 必要なライブラリのインストール
$ yarn add typescript
$ yarn add json-server
$ yarn add @types/json-server -D
```

※ こちらはMockサーバーを実行するために最低限必要な設定を記載した`package.json`になります。

__【package.json設定例】__

```json
{
  "name": "mock_server",
  "version": "1.0.0",
  "main": "server.ts",
  "license": "MIT",
  "dependencies": {
    "json-server": "^0.17.0",
    "typescript": "^4.7.4"
  },
  "scripts": {
    "start": "npx ts-node server.ts"
  },
  "devDependencies": {
    "@types/json-server": "^0.14.7"
  }
}
```

### 参考資料

- [json-serverの実装に関する参考資料](https://blog.eleven-labs.com/en/json-server)
- [TypeScriptで始めるNode.js入門](https://ics.media/entry/4682/)
- [JSON ServerをCLIコマンドを使わずTypescript＆node.jsからサーバーを立てるやり方](https://deep.tacoskingdom.com/blog/151)
