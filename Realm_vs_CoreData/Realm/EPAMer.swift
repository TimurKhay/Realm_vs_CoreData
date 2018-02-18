//
//  EPAMer.swift
//  Realm_vs_CoreData
//
//  Created by Timur Khayrullin on 18.02.18.
//  Copyright © 2018 Timur Khayrullin. All rights reserved.
//

import Foundation
import RealmSwift

class EPAMer: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var birthday: Date?
    @objc dynamic var avatarURL: String?
    override class func primaryKey() -> String? {
        return #keyPath(EPAMer.name)
    }
}
