//
//  Location.swift
//
//
//  Created by Wesley Sadler on 5/22/15.
//
//

import Foundation
import CoreData

@objc(Location)
class Location: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var code: String
    @NSManaged var hasCountry: Location
    @NSManaged var hasStateProvince: NSOrderedSet
    
}
