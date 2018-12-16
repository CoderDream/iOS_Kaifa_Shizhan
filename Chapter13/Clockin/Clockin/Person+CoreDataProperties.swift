//
//  Person+CoreDataProperties.swift
//  Clockin
//
//  Created by coderdream on 2018/12/16.
//  Copyright © 2018 coderdream. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?

}
