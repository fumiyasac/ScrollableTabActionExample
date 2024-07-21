//
//  PremiumPosterViewStateProvider.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/09.
//

import Foundation
import Observation

// MARK: - Protocol

protocol PremiumPosterViewStateProvider {

    var premiumPosterModels: [PremiumPosterModel] { get }

    func fetchPremiumPosters()
}

// MARK: - Protocol

@Observable
public final class PremiumPosterViewStateProviderImpl: PremiumPosterViewStateProvider {

    // MARK: - Property

    private (set)var premiumPosterModels: [PremiumPosterModel] = []

    // MARK: - Function

    func fetchPremiumPosters() {}
}
