//
//  PremiumPosterScreen.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/08.
//

import SwiftUI

struct PremiumPosterScreen: View {

    // MARK: - Property

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

    // MARK: - Initializer

    init() {
        _tabs = State(initialValue: PosterLineupModel.Tab.allCases.map { .init(id: $0) })
        _activeTab = State(initialValue: .premiumDinner1)
        _tabViewScrollState = State(initialValue: nil)
        _mainViewScrollState = State(initialValue: nil)
        _progress = State(initialValue: .zero)
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Text("PremiumPosterScreen")
            }
            // Navigation表示に関する設定
            .navigationTitle("Premium Poster")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Private Function

    @ViewBuilder
    private func PremiumPosterTabView() -> some View {
        
    }
}

// MARK: - Preview

#Preview {
    PremiumPosterScreen()
}
