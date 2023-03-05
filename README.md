# GitHub Repository Searcher

  

## 概要

  

本プロジェクトは株式会社ゆめみの課題のベースプロジェクトを元にアプリを作り上げるプロジェクトです。

  

## アプリ仕様

  

本アプリは GitHub のリポジトリーを検索できるアプリです。


![動作イメージ](README_Images/app.gif)


### 環境

- IDE：Xcode 14.1
- Swift：Swift 5.7
- 開発ターゲット：iOS 16.0
- サードパーティーライブラリーの利用：[OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs)


### 基本機能

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名と言語）で表示
3.特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

 
## 参考記事

  
- [Unit testing Combine-based Swift code](https://www.swiftbysundell.com/articles/unit-testing-combine-based-swift-code/)
- [Error alert presenting in SwiftUI simplified](https://www.avanderlee.com/swiftui/error-alert-presenting/)
- [Alert and LocalizedError in SwiftUI](https://augmentedcode.io/2020/03/01/alert-and-localizederror-in-swiftui/)
- [Error handling in Combine explained with code examples](https://www.avanderlee.com/swift/combine-error-handling/)

