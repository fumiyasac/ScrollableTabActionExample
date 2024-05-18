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
    @State private var activeTab: FoodMenuModel.FoodMenuCategeory = .fish

    // Animation実行時の変化量を格納するための変数
    @State private var animationProgress: CGFloat = 0

    // スクロール可能なNavigationBarにくっ付くタブ要素のScroll変化量を格納するための変数
    @State private var scrollableTabOffset: CGFloat = 0

    // スクロール変化完了時のScroll変化量を格納するための変数(※この値は更新される)
    @State private var initialOffset: CGFloat = 0

    // MARK: - `@Namespace` Property

    // タブ要素をScrollに追従して動かす際に利用するNamespace Property Wrapper
    @Namespace private var animation

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Group {
                VStack {
                    Text("FoodMenuScreen")
                }
            }
            // Navigation表示に関する設定
            .navigationTitle("Food Menu")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview

#Preview {
    FoodMenuScreen()
}
