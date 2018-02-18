//
//  RealmCRUD.swift
//  Realm_vs_CoreDataTests
//
//  Created by Timur Khayrullin on 18.02.18.
//  Copyright © 2018 Timur Khayrullin. All rights reserved.
//

import XCTest
@testable import Realm_vs_CoreData
import RealmSwift

class RealmCRUD: RealmTests {

    // Insert

    func testInsert() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()

            startMeasuring()
            insertEPAMers(bulk: false)
            stopMeasuring()
        }
    }

    func testInsertBulk() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()

            startMeasuring()
            insertEPAMers(bulk: true)
            stopMeasuring()
        }
    }

    // Update

    func testUpdate() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()
            let epamer = realm.objects(EPAMer.self).first!

            startMeasuring()
            for i in 0..<Settings.entityCount {
                Settings.printProgress(title: "testUpdate", completed: i)
                try! realm.write {
                    epamer.avatarURL = "\(i)"
                }
            }
            stopMeasuring()
        }
    }

    func testUpdateBulk() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()
            let result = realm.objects(EPAMer.self)
            let epamers = Array(result)

            startMeasuring()
            try! realm.write {
                for (i, epamer) in epamers.enumerated() {
                    epamer.avatarURL = "\(i)"
                }
            }
            stopMeasuring()
        }
    }

    // Delete

    func testDelete() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()
            let epamers = realm.objects(EPAMer.self)

            startMeasuring()
            for (i, epamer) in epamers.enumerated() {
                if (i % 1000) == 0 && i > 0 {
                    print(i)
                }
                try! realm.write {
                    realm.delete(epamer)
                }
            }
            stopMeasuring()
        }
    }

    func testDeleteBulk() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()
            let epamers = realm.objects(EPAMer.self)

            startMeasuring()
            try! realm.write {
                realm.delete(epamers)
            }
            stopMeasuring()
        }
    }

    // Read

    func testFetchAll() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()

            startMeasuring()
            let _ = realm.objects(EPAMer.self)
            stopMeasuring()
        }
    }

    // Read and evaluate

    func testFetchAndEvaluateAll() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()

            startMeasuring()
            let epamers = realm.objects(EPAMer.self)
            let _ = epamers.map { $0.name }
            stopMeasuring()
        }
    }

    // Read with filter

    func testFetchFilterOneAndEvaluate() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()

            startMeasuring()
            let epamers = realm.objects(EPAMer.self).filter("\(#keyPath(EPAMer.birthday)) == %@", Date() as NSDate)
            let _ = epamers.map { $0.name }
            stopMeasuring()
        }
    }

    func testFetchFilterOneAndEvaluateByPK() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()

            startMeasuring()
            let epamers = realm.objects(EPAMer.self).filter("\(#keyPath(EPAMer.name)) == 'Epamer number 500'")
            let _ = epamers.map { $0.name }
            stopMeasuring()
        }
    }

    // Read and count

    func testFetchAllAndCount() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()

            startMeasuring()
            let _ = realm.objects(EPAMer.self).count
            stopMeasuring()
        }
    }
}
