//
//  PremiumPosterLineup.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/09.
//

import Foundation

// 上側に配置したタブ型要素に関するModel要素

struct PosterLineupModel: Identifiable {

    // MEMO: - Property

    // Struct内に設置したEnum値
    private(set) var id: Tab

    // 上側に配置したタブ型要素におけるサイズを格納する変数
    var size: CGSize = .zero
    // 上側に配置したタブ型要素におけるX軸方向のオフセット値を格納する変数
    var minX: CGFloat = .zero

    // MEMO: - Enum

    enum Tab: String, CaseIterable {
        case premiumDinner1 = "プレミアムディナーNo.1"
        case premiumDinner2 = "プレミアムディナーNo.2"
        case homePartySelection1 = "おうちパーティーNo.1"
        case homePartySelection2 = "おうちパーティーNo.2"
        case christmasChicken = "クリスマス用ローストチキン"
        case hotelRestaurantStyle = "おうち高級レストラン"
        case italianParty = "おうちdeイタリアン"
        case italianPremiumSelection = "Italian Premium"
        case alcoholSnacks = "本格おつまみ"
        case roastBeef = "本格ローストビーフ"
    }
}
