//
//  ViewController.swift
//  MyMealPlanner
//
//  Created by Marissa Homer on 2/1/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var breakfastTitle: UILabel!
    @IBOutlet weak var breakfastDescription: UILabel!
    @IBOutlet weak var lunchTitle: UILabel!
    @IBOutlet weak var lunchDescription: UILabel!
    @IBOutlet weak var dinnerTitle: UILabel!
    @IBOutlet weak var dinnerDescription: UILabel!
    
    var allMeals: [String: [Meal]] = [:]  // Dictionary to store meals by type
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveNewMeals()
        preloadMeals()
    }
    
    @IBAction func changeBreakfastButton(_ sender: Any) {
        displayRandomMeal(ofType: "breakfast")
    }
    
    @IBAction func changeLunchButton(_ sender: Any) {
        displayRandomMeal(ofType: "lunch")
    }
    
    @IBAction func changeDinnerButton(_ sender: Any) {
        displayRandomMeal(ofType: "dinner")
    }
    
    // Function to create and save new Meals
    func saveNewMeals() {
        // Obtain the managed object context from your Core Data stack
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        // Breakfast meals
        let meal1 = Meal(context: context)
        meal1.mealName = "Scrambled Eggs"
        meal1.mealDescription = "Two whole large scrambled eggs; 203 calories"
        meal1.mealType = "breakfast"
        
        let meal11 = Meal(context: context)
        meal11.mealName = "Oatmeal"
        meal11.mealDescription = "One cup of cooked oatmeal; 158 calories"
        meal11.mealType = "breakfast"
        
        let meal111 = Meal(context: context)
        meal11.mealName = "French Toast"
        meal11.mealDescription = "Two slices of french toast with syrup; 314 calories"
        meal11.mealType = "breakfast"

        // Lunch meals
        let meal2 = Meal(context: context)
        meal2.mealName = "Grilled Cheese"
        meal2.mealDescription = "Two slices of white bread, One tablespoon of butter, and two slices of american cheese; 366 calories"
        meal2.mealType = "lunch"
        
        let meal22 = Meal(context: context)
        meal22.mealName = "Mac and Cheese"
        meal22.mealDescription = "One cup of prepared mac and cheese; 310 calories"
        meal22.mealType = "lunch"
        
        let meal222 = Meal(context: context)
        meal222.mealName = "Chicken Nuggets"
        meal222.mealDescription = "Five chicken nuggets; 269 calories"

        
        // Dinner meals
        let meal3 = Meal(context: context)
        meal3.mealName = "Pierogies"
        meal3.mealDescription = "Four pierogies; 296 calories"
        meal3.mealType = "dinner"
        
        let meal33 = Meal(context: context)
        meal33.mealName = "Pizza"
        meal33.mealDescription = "Fourteen inch regular crust pizza, one slice; 285 calories"
        meal33.mealType = "dinner"
        
        let meal333 = Meal(context: context)
        meal333.mealName = "Meatloaf"
        meal333.mealDescription = "Three and a half slices of meatloaf; 149 calories"
        meal333.mealType = "dinner"


        // Save the changes to Core Data
        do {
            try context.save()
            print("Meals saved successfully")
        } catch {
            print("Failed to save meals: \(error)")
        }
    }
    
    // Function to preload all meals from Core Data
    func preloadMeals() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        
        allMeals["breakfast"] = fetchMeals(ofType: "breakfast", from: context)
        allMeals["lunch"] = fetchMeals(ofType: "lunch", from: context)
        allMeals["dinner"] = fetchMeals(ofType: "dinner", from: context)
    }
    
    // Function to fetch meals of a specific type
    func fetchMeals(ofType mealType: String, from context: NSManagedObjectContext) -> [Meal] {
        let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mealType == %@", mealType)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch \(mealType) meals: \(error)")
            return []
        }
    }
    
    // Function to display a random meal of the given type
    func displayRandomMeal(ofType mealType: String) {
        guard let meals = allMeals[mealType], let meal = meals.randomElement() else {
            print("No \(mealType) meals found.")
            return
        }
        
        switch mealType {
        case "breakfast":
            breakfastTitle.text = meal.mealName
            breakfastDescription.text = meal.mealDescription
        case "lunch":
            lunchTitle.text = meal.mealName
            lunchDescription.text = meal.mealDescription
        case "dinner":
            dinnerTitle.text = meal.mealName
            dinnerDescription.text = meal.mealDescription
        default:
            break
        }
    }
}


