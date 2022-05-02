//
//  Sequence.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 30-04-22.
//

import Foundation


extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
