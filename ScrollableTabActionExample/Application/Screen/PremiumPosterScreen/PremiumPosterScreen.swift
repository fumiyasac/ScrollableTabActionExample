//
//  PremiumPosterScreen.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/08.
//

import SwiftUI

struct PremiumPosterScreen: View {

    // MARK: - `@State` Property

    // 配置対象のTab要素全てを格納する変数
    @State private var tabs: [PosterLineupModel]

    // 現在選択されているTab要素としての変数
    @State private var activeTab: PosterLineupModel.Tab

    // Tab要素をスクロールした時の状態を格納する変数
    @State private var tabViewScrollState: PosterLineupModel.Tab?

    // メインContents要素をスクロールした時の状態を格納する変数
    @State private var mainViewScrollState: PosterLineupModel.Tab?

    // Drag操作をしている最中の変化量を一時的に格納する変数
    @State private var progress: CGFloat

    // MARK: - Computed Property

    private var tabNameFont: Font {
        Font.custom("AvenirNext-Bold", size: 13.0)
    }

    private var tabUnderlineActiveColor: Color {
        Color(uiColor: UIColor(code: "#bf6301"))
    }

    private var tabUnderlineNormalColor: Color {
        .gray.opacity(0.5)
    }

    // MARK: - Initializer

    init() {
        // `@State`で定義するものの初期値を設定する
        _tabs = State(initialValue: PosterLineupModel.Tab.allCases.map { .init(id: $0) })
        _activeTab = State(initialValue: .premiumDinner1)
        _tabViewScrollState = State(initialValue: nil)
        _mainViewScrollState = State(initialValue: nil)
        _progress = State(initialValue: .zero)
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(spacing: 0.0) {
                // 1. Slider式のTab要素を並べたView要素
                PremiumPosterTabView()
                // 2. Slider式のContents要素を並べたView要素
                PremiumPosterContentsView()
            }
            // Navigation表示に関する設定
            .navigationTitle("Premium Poster")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Private Function

    @ViewBuilder
    private func PremiumPosterContentsView() -> some View {
        // GeometryReaderを利用してContents表示要素の移動変化量を取得する
        GeometryReader { proxy in
            let targetSize = proxy.size
            // GeometryReaderから取得した値とScrollViewを連動させる方針を取る
            // 👉 ScrollView & LazyHStackの組み合わせなので、X軸方向のOffset値に注目する
            // ポイント: .scrollTargetLayout() ＆ .scrollPosition(id: $mainViewScrollState) に関する解説
            // 👉 .scrollTargetLayout(): ScrollView内で特定の位置までスクロールするために必要なModifier
            // 👉 .scrollPosition(id: $mainViewScrollState): コンテンツ表示要素におけるX軸方向のOffset値を格納する変数「mainViewScrollState」の位置まで移動するために必要なModifier
            // 👉 .scrollTargetBehavior(.paging): 配置したScrollViewどのように機能するかを決定するためのModifier（今回はTabViewの様に動作する形にしている）
            ScrollView(.horizontal, showsIndicators: false) {
                // 横一列にタブ要素分だけ対応するコンテンツ要素を並べる
                LazyHStack(spacing: 0.0) {
                    ForEach(tabs) { tab in
                        // ForEach内部の配置要素にGeometryReaderから算出した幅と高さを設定する

                        // TODO: コンテンツ要素用のView要素を作成する
                        Text(tab.id.rawValue)
                            .frame(width: targetSize.width, height: targetSize.height)
                            .contentShape(.rect)
                    }
                }
                .scrollTargetLayout()
                // 独自に定義した「.getRectangleView」を利用してX軸方向のOffset値を取得する
                // 👉 Tab要素の文字列下部に配置した「動く下線表示」のX軸方向のOffset値になる点がポイント
                .getRectangleView { rect in
                    // 変化量の割合を格納する変数「progress」へDrag操作最中の変化量を格納する
                    progress = -rect.minX / targetSize.width
                }
            }
            .scrollPosition(id: $mainViewScrollState)
            .scrollTargetBehavior(.paging)
            // コンテンツ表示要素におけるX軸方向のOffset値を格納する変数「mainViewScrollState」の変化時に実行される処理
            // iOS16以下はこちらを利用: .onChange(of: offset) { [offset] newValue in ... }
            // 参考: https://qiita.com/ymurao/items/6cfe245701629f2e80dd
            .onChange(of: mainViewScrollState) { oldValue, newValue in
                if let newValue {
                    // .snappyで弱いバネ運動の様な感じを演出する
                    withAnimation(.snappy) {
                        // 👉 Tab要素のスクロール位置 ＆ 現在選択されているTab要素を更新する
                        activeTab = newValue
                        tabViewScrollState = newValue
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func PremiumPosterTabView() -> some View {
        // こちらはGeometryReaderで座標位置を取得する必要はない形で差し支えない
        // 👉 .scrollTargetLayout() ＆ .scrollPosition(id: $tabViewScrollState) ＆ .scrollTargetBehavior(.paging)の組み合わせ
        ScrollView(.horizontal, showsIndicators: false) {
            // 👉 ScrollView & LazyHStackの組み合わせなので、どのタブ要素に移動したかに注目する
            HStack(spacing: 24.0) {
                // 👉 $tabsにしているのは`@State`の変化と連動させるため
                ForEach($tabs) { $tab in
                    Button(action: {
                        // .snappyで弱いバネ運動の様な感じを演出する
                        withAnimation(.snappy) {
                            // 👉 Tab要素のスクロール位置 ＆ 現在選択されているTab要素 ＆ 現在選択されているContents要素を更新する
                            activeTab = tab.id
                            tabViewScrollState = tab.id
                            mainViewScrollState = tab.id
                        }
                    }) {
                        // Tab要素配置用テキストを設定する
                        // 👉 余談: 「.vertical = 12.0」をしているのは高さを調整するため
                        Text(tab.id.rawValue)
                            .font(tabNameFont)
                            .fontWeight(.medium)
                            .padding(.vertical, 12.0)
                            .foregroundStyle(activeTab == tab.id ? tabUnderlineActiveColor : .gray)
                            .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    // 独自に定義した「.getRectangleView」を利用してX軸方向のOffset値を取得する
                    // 👉 Tab要素の文字列下部に配置した「動く下線表示」のX軸方向のOffset値になる点がポイント
                    .getRectangleView { rect in
                        tab.size = rect.size
                        tab.minX = rect.minX
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $tabViewScrollState, anchor: .center)
        // Tab要素を並べたScrollViewの上に更に要素を重ねる形を取る
        .overlay(alignment: .bottom) {
            // ScrollView要素上に更にグレーの下線と動く色付き下線を重ねる
            ZStack(alignment: .leading) {
                // 左右のpadding外にグレーの下線要素を配置する
                // 👉 .padding(.horizontal, -16.0) ＆ .safeAreaPadding(.horizontal, 16.0) でセットで考える
                Rectangle()
                    .fill(tabUnderlineNormalColor)
                    .frame(height: 1.0)
                    .padding(.horizontal, -16.0)
                // Tab要素のindex値をArrayに変換する
                let inputRange = tabs.indices.compactMap { targetRange in
                    CGFloat(targetRange)
                }
                // Tab要素の文字列幅をArrayに変換する
                let ouputRange = tabs.compactMap { targetRange in
                    targetRange.size.width
                }
                // Tab要素を並べた時のX軸方向のOffset値の一覧をArrayに変換する
                let outputPositionRange = tabs.compactMap { targetRange in
                    targetRange.minX
                }
                // 動く下線要素の幅が変化して、次のタブ要素へ進む（前のタブ要素へ戻る）際の幅を算出する
                let indicatorWidth = progress.calculateInterpolate(
                    inputInterpolateRange: inputRange,
                    outputInterpolateRange: ouputRange
                )
                // 動く下線要素の幅が変化して、次のタブ要素へ進む（前のタブ要素へ戻る）際のX軸方向のOffset値を算出する
                let indicatorPosition = progress.calculateInterpolate(
                    inputInterpolateRange: inputRange,
                    outputInterpolateRange: outputPositionRange
                )
                // 動く下線要素を配置する
                // 👉 X軸方向のOffset値の変数「indicatorPosition」を適用する
                // 👉 Contents要素を動かした割合を表す変数「progress」を利用して計算した値を反映する点がポイント
                Rectangle()
                    .fill(tabUnderlineActiveColor)
                    .frame(width: indicatorWidth, height: 1.5)
                    .offset(x: indicatorPosition)
            }
        }
        .safeAreaPadding(.horizontal, 16.0)
    }
}

// MARK: - Preview

#Preview {
    PremiumPosterScreen()
}
