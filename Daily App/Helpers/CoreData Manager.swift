//
//  CoreData Manager.swift
//  Daily App
//
//  Created by Hakan Adanur on 17.01.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() { }
    
    func saveDaily(title: String, overview: String, day: String, image: Data) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newBody = NSEntityDescription.insertNewObject(forEntityName: "Daily", into: context)
        
        newBody.setValue(title, forKey: "title")
        newBody.setValue(overview, forKey: "overview")
        newBody.setValue(UUID(), forKey: "id")
        newBody.setValue(day, forKey: "day")
        newBody.setValue(image, forKey: "image")

        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func getData() -> [DailyModel]? {
        var dailys = [DailyModel]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Daily")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let title = result.value(forKey: "title") as? String,
                   let id = result.value(forKey: "id") as? UUID,
                   let overview = result.value(forKey: "overview") as? String,
                   let image = result.value(forKey: "image") as? Data,
                   let day = result.value(forKey: "day") as? String {
                    let daily = DailyModel(id: id, title: title, overview: overview, day: day, image: image)
                    dailys.append(daily)
                }
            }
            return dailys
        } catch {
            print("error")
            return nil
        }
    }
    
    func deleteDaily(from data: [DailyModel], at index: Int) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Daily")
        
        let idString = data[index].id.uuidString
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        fetchRequest.returnsObjectsAsFaults = false
        
        if let results = try? context.fetch(fetchRequest) {
            for result in results as! [NSManagedObject] {
                context.delete(result)
            }
            
            do {
                try context.save()
            } catch {
                return false
            }
            
            return true
        }
        
        return false
    }
}
