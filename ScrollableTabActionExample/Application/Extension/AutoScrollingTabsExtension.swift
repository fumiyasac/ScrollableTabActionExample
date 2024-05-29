//
//  AutoScrollingTabsExtension.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/29.
//

import SwiftUI

//

extension View {

    // MARK: - Function

    @ViewBuilder
    func getRectangleViewToCoordinateSpace(_ coordinateSpace: AnyHashable, completion: @escaping (CGRect) -> ()) -> some View {

        // 引数で受け取るCoordinateSpaceの値と紐づけてOffset値を取得できる形にする
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
    func checkAnimationEnd<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> ()) -> some View {

        //
        self.modifier(AnimationEndCallback(for: value, onEnd: completion))
    }
}

// MARK: - Fileprivate Struct

fileprivate struct AnimationEndCallback<Value: VectorArithmetic>: Animatable, ViewModifier {

    // MARK: - Property

    var animatableData: Value {
        didSet {
            checkIfFinished()
        }
    }
    
    var endValue: Value
    var onEnd: () -> ()

    // MARK: - Initializer

    init(for value: Value, onEnd: @escaping () -> Void) {
        self.animatableData = value
        self.endValue = value
        self.onEnd = onEnd
    }

    // MARK: - Function

    func body(content: Content) -> some View {
        content
    }

    // MARK: - Private Function

    private func checkIfFinished() {
        if endValue == animatableData {
            Task { @MainActor in
                onEnd()
            }
        }
    }
}
