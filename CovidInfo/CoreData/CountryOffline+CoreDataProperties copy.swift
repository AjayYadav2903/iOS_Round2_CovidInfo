//
//  CountryOffline+CoreDataProperties.swift
//  
//
//  Created by Ajay Yadav on 06/09/21.
//
//

import Foundation
import CoreData


extension CountryOffline {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryOffline> {
        return NSFetchRequest<CountryOffline>(entityName: "CountryOffline")
    }

    @NSManaged public var countryO: String?
    @NSManaged public var iso2O: String?
    @NSManaged public var slugO: String?

}
