//
//  Movie.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//

import SwiftyJSON
import CoreData

struct Movie {
    
    // MARK: - Private identifiers
    private let _ID = "id"
    private let _NAME = "original_title"
    private let _OVERVIEW = "overview"
    private let _IMAGEPATH = "poster_path"
    
    // MARK: - Struct properties
    let id: Int
    let name: String?
    let overview: String?
    let imagePath: String?
    let category: MovieCategory
    
    // MARK: - Initializers
    init(jsonObject: JSON, category: MovieCategory = .popular) {
        id = jsonObject[_ID].int ?? 0
        name = jsonObject[_NAME].string
        overview = jsonObject[_OVERVIEW].string
        if let imageValue = jsonObject[_IMAGEPATH].string {
            imagePath = "\(URLs.Movie.imagesBaseURL)\(imageValue)"
        } else {
            imagePath = nil
        }
        self.category = category
    }
    
    init(managedObject: NSManagedObject) {
        id = managedObject.value(forKey: "id") as? Int ?? 0
        name = managedObject.value(forKey: "name") as? String
        overview = managedObject.value(forKey: "overview") as? String
        imagePath = managedObject.value(forKey: "imagePath") as? String
        let categoryValue = managedObject.value(forKey: "category") as? String ?? ""
        category = MovieCategory(rawValue: categoryValue) ?? .popular
    }
}
