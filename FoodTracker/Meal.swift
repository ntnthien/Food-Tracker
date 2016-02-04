//
//  Meal.swift
//  FoodTracker
//
//  Created by Do Nguyen on 2/1/16.
//  Copyright © 2016 Zincer. All rights reserved.
//

import Foundation
import UIKit

class Meal: NSObject, NSCoding {
    // MARK: Properties.
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }

    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialization
    init? (name: String, photo: UIImage?, rating: Int) {
        // MARK: Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: MSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        // Must call designated initilizer.
        self.init(name: name, photo: photo, rating: rating)
    }
}