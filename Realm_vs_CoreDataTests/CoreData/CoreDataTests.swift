//
//  CoreDataTests.swift
//  Realm_vs_CoreDataTests
//
//  Created by Timur Khayrullin on 18.02.18.
//  Copyright © 2018 Timur Khayrullin. All rights reserved.
//

import XCTest
@testable import Realm_vs_CoreData
import CoreData

class CoreDataTests: XCTestCase {

    var managedObjectContext = CoreDataManager.shared.managedObjectContext

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        deleteAll()
        super.tearDown()
    }

    func deleteAll() {
        Settings.printInfo(title: "deleting all")
        let allEpamersFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEPAMer")
        try! managedObjectContext.execute(NSBatchDeleteRequest(fetchRequest: allEpamersFetchRequest))
    }

    func insertEPAMers(bulk: Bool = true) {
        var epamers = [CDEPAMer]()
        for i in 0..<Settings.entityCount {
            Settings.printProgress(title: "insertEPAMers", completed: i)
            let epamer = NSEntityDescription.insertNewObject(forEntityName: "CDEPAMer", into: managedObjectContext) as! CDEPAMer
            epamer.name = "Epamer number \(i)"
            epamer.birthday = Date(timeIntervalSince1970: 1000*TimeInterval(i)) as NSDate
            epamers.append(epamer)
            if !bulk {
                try! managedObjectContext.save()
            }
        }
        if bulk {
            Settings.printInfo(title: "saving all")
            try! managedObjectContext.save()
        }
    }
}
