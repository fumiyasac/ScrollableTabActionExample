//
//  FoodMenuScreen.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/08.
//

import SwiftUI

struct FoodMenuScreen: View {

    // MARK: - `@State` Property

    // 現在選択されているTab要素としての変数
    @State private var activeTab: FoodMenuModel.FoodMenuCategeory

    // Animation実行時の変化量を格納するための変数
    @State private var animationProgress: CGFloat

    // スクロール可能なNavigationBarにくっ付くタブ要素のScroll変化量を格納するための変数
    @State private var scrollableTabOffset: CGFloat

    // スクロール変化完了時のScroll変化量を格納するための変数(※この値は更新される)
    @State private var initialOffset: CGFloat

    // MARK: - `@Namespace` Property

    // タブ要素をScrollに追従して動かす際に利用するNamespace Property Wrapper
    @Namespace private var animation

    // Toolbar要素の背景色
    private var toolbarBackgroundColor: Color {
        Color(uiColor: UIColor(code: "#bf6301"))
    }

    // 文字列を基準としてGeometryReaderから座標値を取得するにあたり、基準となる特定の文字列
    private let coordinateSpaceContentView = "CONTENTVIEW"

    // MARK: - Initializer

    init() {
        // `@State`で定義するものの初期値を設定する
        _activeTab = State(initialValue: .fish)
        _animationProgress = State(initialValue: 0.0)
        _scrollableTabOffset = State(initialValue: 0.0)
        _initialOffset = State(initialValue: 0.0)
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            // フードメニュー要素一覧表示用View要素
            FoodMenuScrollView()
        }
    }

    // MARK: - Private Function

    @ViewBuilder
    private func FoodMenuScrollView() -> some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                // カテゴリー別のフードメニュー要素一覧を並べる
                VStack(spacing: 0.0) {
                    // TODO: ForEach + LazyVStack等を利用したリスト表示をする
                }
                // coordinateSpaceに定義した名前空間を基準としたオフセット値を反映する処理
                .getRectangleViewToCoordinateSpace(coordinateSpaceContentView, completion: { rect in
                    scrollableTabOffset = rect.minY - initialOffset
                })
            }
            // 上方向のSafeArea余白に関する定義
            .safeAreaInset(edge: .top) {
                // TODO: NavigationBar直下に配置する水平タブ要素に関する位置調整
            }
        }
        // 独自定義したModifier「.getRectangleViewToCoordinateSpace」に定めるための基準を設定する（※今回は特定の文字列を定める）
        .coordinateSpace(name: coordinateSpaceContentView)
        // Navigation表示に関する設定
        .navigationTitle("Food Menu")
        .navigationBarTitleDisplayMode(.inline)
        // Navigation表示の配色に関する設定
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(toolbarBackgroundColor, for: .navigationBar)
        // 要素全体が表示されたタイミングで実行される処理
        .onAppear {
            // TODO: Section毎にカテゴリー別のフードメニュー要素をまとめ直す
        }
    }
}

// MARK: - Preview

#Preview {
    FoodMenuScreen()
}
