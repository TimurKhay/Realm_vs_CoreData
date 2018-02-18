//
//  RealmTests.swift
//  Realm_vs_CoreDataTests
//
//  Created by Timur Khayrullin on 18.02.18.
//  Copyright © 2018 Timur Khayrullin. All rights reserved.
//

import XCTest
@testable import Realm_vs_CoreData
import RealmSwift

class RealmTests: XCTestCase {

    var realm: Realm!

    override func setUp() {
        super.setUp()

        realm = try! Realm()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                Settings.printInfo(title: "remove db file")
                try FileManager.default.removeItem(at: URL)
            } catch {
                // handle error
            }
        }

        super.tearDown()
    }

    func deleteAll() {
        Settings.printInfo(title: "deleting all")
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }

    func insertEPAMers(bulk: Bool = true) {
        autoreleasepool {
            var epamers = [EPAMer]()
            for i in 0..<Settings.entityCount {
                Settings.printProgress(title: "insertEPAMers", completed: i)
                let epamer = EPAMer()
                epamer.name = "Epamer number \(i)"
                epamer.birthday = Date(timeIntervalSince1970: 1000*TimeInterval(i))
                epamers.append(epamer)
                if !bulk {
                    try! realm.write {
                        realm.add(epamer)
                    }
                }
            }
            if bulk {
                Settings.printInfo(title: "saving all")
                try! realm.write {
                    realm.add(epamers)
                }
            }
        }
    }
}
