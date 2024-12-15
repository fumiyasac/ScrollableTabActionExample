//
//  PremiumPosterModel.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/18.
//

import Foundation

struct PremiumPosterModel: Hashable, Decodable {

    // MARK: - Property

    let id: Int
    let tab: PosterLineupModel.Tab
    let title: String
    let subTitle: String
    let price: Int
    let posterIdentifier: String

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case tab
        case title
        case subTitle = "sub_title"
        case price
        case posterIdentifier = "poster_identifier"
    }

    // MARK: - Initializer

    init(
        id: Int,
        tab: String,
        title: String,
        subTitle: String,
        price: Int,
        posterIdentifier: String
    ) {
        self.id = id
        self.tab = PosterLineupModel.Tab(rawValue: tab) ?? .homePartySelection1
        self.title = title
        self.subTitle = subTitle
        self.price = price
        self.posterIdentifier = posterIdentifier
    }

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.tab = PosterLineupModel.Tab(rawValue: try container.decode(String.self, forKey: .tab)) ?? .homePartySelection1
        self.title = try container.decode(String.self, forKey: .title)
        self.subTitle = try container.decode(String.self, forKey: .subTitle)
        self.price = try container.decode(Int.self, forKey: .price)
        self.posterIdentifier = try container.decode(String.self, forKey: .posterIdentifier)
    }

    // MARK: - Hashable

    // MEMO: Hashableプロトコルに適合させるための処理
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: PremiumPosterModel, rhs: PremiumPosterModel) -> Bool {
        return lhs.id == rhs.id
    }
}
