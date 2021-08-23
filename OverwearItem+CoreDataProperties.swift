//
//  OverwearItem+CoreDataProperties.swift
//  Amo
//
//  Created by Andrew Hartsfield II on 7/23/21.
//
//

import Foundation
import CoreData


extension OverwearItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OverwearItem> {
        return NSFetchRequest<OverwearItem>(entityName: "OverwearItem")
    }

    @NSManaged public var photo: Data?
    @NSManaged public var price: String?
    @NSManaged public var title: String?
    @NSManaged public var username: String?
    @NSManaged public var favo: Bool

}

extension OverwearItem : Identifiable {

}
