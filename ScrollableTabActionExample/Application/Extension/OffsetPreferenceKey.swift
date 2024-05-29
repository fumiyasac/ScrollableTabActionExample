//
//  OffsetPreferenceKey.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/29.
//

import SwiftUI

struct OffsetPreferenceKey: PreferenceKey {

    // MARK: - Property

    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
