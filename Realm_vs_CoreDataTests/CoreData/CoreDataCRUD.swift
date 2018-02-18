//
//  CoreDataCRUD.swift
//  Realm_vs_CoreDataTests
//
//  Created by Timur Khayrullin on 18.02.18.
//  Copyright © 2018 Timur Khayrullin. All rights reserved.
//

import XCTest
@testable import Realm_vs_CoreData
import CoreData

class CoreDataCRUD: CoreDataTests {

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
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEPAMer")
            let epamer = try! managedObjectContext.fetch(fetchRequest).first as! CDEPAMer

            startMeasuring()
            for i in 0..<Settings.entityCount {
                Settings.printProgress(title: "testUpdate", completed: i)
                epamer.avatarURL = "\(i)"
                try! managedObjectContext.save()
            }
            stopMeasuring()
        }
    }

    func testUpdateBulk() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEPAMer")
            let epamers = try! managedObjectContext.fetch(fetchRequest) as! [CDEPAMer]

            startMeasuring()
            for (i, epamer) in epamers.enumerated() {
                epamer.avatarURL = "\(i)"
            }
            try! managedObjectContext.save()
            stopMeasuring()
        }
    }

    // Delete

    func testDelete() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEPAMer")
            let epamers = try! managedObjectContext.fetch(fetchRequest) as! [CDEPAMer]

            startMeasuring()
            for epamer in epamers {
                managedObjectContext.delete(epamer)
                try! managedObjectContext.save()
            }
            stopMeasuring()
        }
    }

    func testDeleteBulk() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()

            startMeasuring()
            let allEpamersFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEPAMer")
            try! managedObjectContext.execute(NSBatchDeleteRequest(fetchRequest: allEpamersFetchRequest))
            try! managedObjectContext.save()
            stopMeasuring()
        }
    }

    // Read

    func testFetchAll() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()

            startMeasuring()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEPAMer")
            let _ = try! managedObjectContext.fetch(fetchRequest)
            stopMeasuring()
        }
    }

    // Read and evaluate

    func testFetchAndEvaluateAll() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()

            startMeasuring()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEPAMer")
            let items = try! managedObjectContext.fetch(fetchRequest) as! [CDEPAMer]
            let _ = items.map { $0.name }
            stopMeasuring()
        }
    }

    // Read with filter

    func testFetchFilterOneAndEvaluate() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()

            startMeasuring()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEPAMer")
            fetchRequest.predicate = NSPredicate(format: "\(#keyPath(EPAMer.birthday)) == %@", Date() as NSDate)

            let items = try! managedObjectContext.fetch(fetchRequest) as! [CDEPAMer]
            let _ = items.map { $0.name }
            stopMeasuring()
        }
    }

    func testFetchFilterOneAndEvaluateByPK() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()

            startMeasuring()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEPAMer")
            fetchRequest.predicate = NSPredicate(format: "\(#keyPath(EPAMer.name)) == 'Epamer number 500'")

            let items = try! managedObjectContext.fetch(fetchRequest) as! [CDEPAMer]
            let _ = items.map { $0.name }
            stopMeasuring()
        }
    }

    // Read and count

    func testFetchAllAndCount() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
            deleteAll()
            insertEPAMers()

            startMeasuring()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEPAMer")
            let _ = try! managedObjectContext.fetch(fetchRequest).count
            stopMeasuring()
        }
    }
}
