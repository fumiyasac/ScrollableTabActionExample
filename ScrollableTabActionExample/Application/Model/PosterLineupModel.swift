//
//  PremiumPosterLineup.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/09.
//

import Foundation

struct PosterLineupModel: Identifiable {

    // MEMO: - Property

    // Struct内に設置したEnum値
    private(set) var id: Tab

    //
    var size: CGSize = .zero
    //
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
