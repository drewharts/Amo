//
//  ShoeItem+CoreDataProperties.swift
//  Amo
//
//  Created by Andrew Hartsfield II on 8/17/21.
//
//

import Foundation
import CoreData


extension ShoeItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoeItem> {
        return NSFetchRequest<ShoeItem>(entityName: "ShoeItem")
    }

    @NSManaged public var favo: Bool
    @NSManaged public var photo: Data?
    @NSManaged public var price: String?
    @NSManaged public var username: String?
    @NSManaged public var title: String?

}

extension ShoeItem : Identifiable {

}
