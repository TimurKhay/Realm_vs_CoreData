//
//  TestSettings.swift
//  Realm_vs_CoreDataTests
//
//  Created by Timur Khayrullin on 18.02.18.
//  Copyright © 2018 Timur Khayrullin. All rights reserved.
//

import Foundation

struct Settings {
    static let entityCount = 10000
    private static let printProgress = true
    private static let printInterval = 1000
}

extension Settings {
    static func printProgress(title: String, completed: Int, total: Int = Settings.entityCount) {
        guard printProgress else {
            return
        }
        if (completed % printInterval) == 0 && completed > 0 {
            print("🔸 \(title)... \(completed) completed out of \(total)")
        }
    }
    static func printInfo(title: String) {
        guard printProgress else {
            return
        }
        print("🔸 \(title)...")
    }
}
