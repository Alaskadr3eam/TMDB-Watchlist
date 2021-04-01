//
//  WatchList+CoreDataProperties.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 01/04/2021.
//
//

import Foundation
import CoreData


extension WatchList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchList> {
        return NSFetchRequest<WatchList>(entityName: "WatchList")
    }

    @NSManaged public var idMovie: Int16
    @NSManaged public var image: Data?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var realeaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double

}

extension WatchList : Identifiable {

}
