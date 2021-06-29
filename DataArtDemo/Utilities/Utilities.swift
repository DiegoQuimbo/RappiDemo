//
//  Utilities.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 29/6/21.
//

import Foundation
import CoreData
import UIKit

final class Utilities {
    
    static let movieEntitie = "MovieObj"
    
    // MARK: - Core Data Functions
    class func getMoviesSaved() -> [Movie] {
        var movies: [Movie] = []
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
              return movies
          }

          let managedContext = appDelegate.persistentContainer.viewContext
          let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: movieEntitie)

          do {
            let moviesSaved = try managedContext.fetch(fetchRequest)
            for movieObj in moviesSaved {
                let movie = Movie(managedObject: movieObj)
                movies.append(movie)
            }
            return movies
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return movies
          }
    }
    
    class func saveMoviesInCoreData(movies: [Movie]) {
        clearDatabase()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: movieEntitie, in: managedContext)!

        for movie in movies {
            let movieObj = NSManagedObject(entity: entity, insertInto: managedContext)
            movieObj.setValue(movie.id, forKeyPath: "id")
            movieObj.setValue(movie.imagePath, forKeyPath: "imagePath")
            movieObj.setValue(movie.name, forKeyPath: "name")
            movieObj.setValue(movie.overview, forKeyPath: "overview")
            movieObj.setValue(movie.category.rawValue, forKeyPath: "category")
        }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    class func clearDatabase() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: movieEntitie)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(batchDeleteRequest)
        } catch {
            print("Detele all data in error :", error)
        }
    }

}
