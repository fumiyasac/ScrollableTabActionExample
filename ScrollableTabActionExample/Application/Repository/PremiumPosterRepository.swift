//
//  PremiumPosterRepository.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/06/20.
//

import Foundation

protocol PremiumPosterRepository {
    func getAll() async throws -> [PremiumPosterModel]
}
