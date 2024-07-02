//
//  PremiumPosterRequest.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/06/21.
//

import Foundation

protocol PremiumPosterRequest {
    func getAll() async throws -> [PremiumPosterModel]
}

final class PremiumPosterRequestImpl: PremiumPosterRequest {

    // MARK: - Function

    func getAll() async throws -> [PremiumPosterModel] {
        []
    }
}
