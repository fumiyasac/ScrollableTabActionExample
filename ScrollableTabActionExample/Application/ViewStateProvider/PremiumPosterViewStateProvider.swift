//
//  PremiumPosterViewStateProvider.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/09.
//

import Foundation
import Observation

protocol PremiumPosterViewStateProvider {
    func fetchPremiumPosters()
}

@Observable
public final class PremiumPosterViewStateProviderImpl: PremiumPosterViewStateProvider {

    // MARK: - Functions

    func fetchPremiumPosters() {}
}
