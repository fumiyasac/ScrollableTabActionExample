//
//  TabRectangleExtension.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/13.
//

import SwiftUI

// MEMO: 配置したTab要素に対して座標位置を取得するためのExtension定義
// GeometryReaderを利用して、親Viewの座標情報等が利用できる点を活用する
// 参考: https://blog.personal-factory.com/2019/12/08/how-to-know-coorginate-space-by-geometryreader/

extension View {

    // MARK: - Function

    @ViewBuilder
    func getRectangleView(completion: @escaping (CGRect) -> ()) -> some View {

        // .overlay表示用Modifier内の処理でOffset値を取得できる形にする
        self.overlay {
            // GeometryReader内部にはColorを定義してScrollView内に配置する要素には極力影響を及ぼさない様にする
            GeometryReader { proxy in
                let rectangle = proxy.frame(in: .scrollView(axis: .horizontal))
                // 👉 OffsetPreferenceKey定義とGeometryProxyから取得できる値を紐づける事でこの値変化を監視対象に設定する
                Color.clear
                    .preference(key: OffsetPreferenceKey.self, value: rectangle)
                    .onPreferenceChange(OffsetPreferenceKey.self, perform: completion)
            }
        }
    }
}
