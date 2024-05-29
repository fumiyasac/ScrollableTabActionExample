//
//  AutoScrollingTabsExtension.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/29.
//

import SwiftUI

// MEMO: 配置したTab要素に対して座標位置を取得するためのExtension定義
// GeometryReaderを利用して、親Viewの座標情報等が利用できる点を活用する
// 👉 Scrollに追従してタブ要素を動かすため「引数: coordinateSpace」を元に要素を取得する ＆ Animation完了時の

extension View {

    // MARK: - Function

    @ViewBuilder
    func getRectangleViewToCoordinateSpace(_ coordinateSpace: AnyHashable, completion: @escaping (CGRect) -> ()) -> some View {

        // 引数で受け取るCoordinateSpaceの値と紐づけてOffset値を取得できる形にする
        // 👉 TabRectangleExtension.swiftで定義したものの違いは「proxy.frame(in: .named(coordinateSpace))」の部分
        self.overlay {
            GeometryReader { proxy in
                let rectangle = proxy.frame(in: .named(coordinateSpace))
                // 👉 OffsetPreferenceKey定義とGeometryProxyから取得できる値を紐づける事でこの値変化を監視対象に設定する
                Color.clear
                    .preference(key: OffsetPreferenceKey.self, value: rectangle)
                    .onPreferenceChange(OffsetPreferenceKey.self, perform: completion)
            }
        }
    }

    @ViewBuilder
    func checkAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> ()) -> some View {

        // Animationが完了した時のCallback処理を実施するためのModifier
        self.modifier(AnimationCompletedCallback(for: value, onCompleted: completion))
    }
}

// MARK: - Fileprivate Struct

// Animation完了時を検知するためのModifier定義（Animatable準拠）
// 👉 VectorArithmeticは、Animationの始点から終点の間の数値を補完する目的で利用する
// 参考1: https://qiita.com/takehito-koshimizu/items/523dc7cdedffd0bf1aff
// 参考2: https://qiita.com/masaru-honma/items/fc9b3ca098103a1530f7
fileprivate struct AnimationCompletedCallback<Value: VectorArithmetic>: Animatable, ViewModifier {

    // MARK: - Property

    // VectorArithmeticに準拠した「変数: animatableData」を実装する必要がある
    // 👉 今回は渡された引数の型を適用する
    var animatableData: Value {
        didSet {
            checkIfFinished()
        }
    }

    var completedValue: Value
    var onCompleted: () -> ()

    // MARK: - Initializer

    init(for value: Value, onCompleted: @escaping () -> Void) {
        self.animatableData = value
        self.completedValue = value
        self.onCompleted = onCompleted
    }

    // MARK: - Function

    func body(content: Content) -> some View {
        content
    }

    // MARK: - Private Function

    private func checkIfFinished() {
        // 👉 第1引数で値を監視して、完了時とanimatableData内の値が等しくなった際にClosureの処理を実行する
        if completedValue == animatableData {
            Task { @MainActor in
                onCompleted()
            }
        }
    }
}
