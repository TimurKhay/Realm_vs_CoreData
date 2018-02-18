//
//  CDEPAMer+CoreDataProperties.swift
//  Realm_vs_CoreData
//
//  Created by Timur Khayrullin on 18.02.18.
//  Copyright © 2018 Timur Khayrullin. All rights reserved.
//
//

import Foundation
import CoreData


extension CDEPAMer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEPAMer> {
        return NSFetchRequest<CDEPAMer>(entityName: "CDEPAMer")
    }

    @NSManaged public var avatarURL: String?
    @NSManaged public var birthday: NSDate?
    @NSManaged public var name: String?

}
