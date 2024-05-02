//
//  Meal+CoreDataProperties.swift
//  MyMealPlanner
//
//  Created by Marissa Homer on 4/3/24.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var mealName: String?
    @NSManaged public var mealDescription: String?
    @NSManaged public var mealType: String?

}

extension Meal {
    var formattedMealType: String {
        guard let type = mealType else {
            return "Unknown"
        }
        switch type {
            case "breakfast": return "Breakfast"
            case "lunch": return "Lunch"
            case "dinner": return "Dinner"
            default: return "Unknown"
        }
    }
}
