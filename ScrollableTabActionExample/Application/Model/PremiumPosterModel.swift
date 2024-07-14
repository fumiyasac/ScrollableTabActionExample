//
//  PremiumPosterModel.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/18.
//

import Foundation

struct PremiumPosterModel: Identifiable {

    // MARK: - Property

    let id: UUID = UUID()
    let posterID: Int
    let tab: PosterLineupModel.Tab
    let title: String
    let subTitle: String
    let price: Int
    let posterIdentifier: String
}
