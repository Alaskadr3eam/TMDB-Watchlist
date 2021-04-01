//
//  CoreDataManager.swift
//  TMDB Watchlist
//
//  Created by Clément Martin on 31/03/2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {

    let persistentContainer: NSPersistentContainer!

    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }

    convenience init() {
        //Use the default container for production environment
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { fatalError("no coreData") }

        self.init(container: appDelegate.persistentContainer)
    }

    func fetchAllWatchList() -> [WatchList] {
        let request: NSFetchRequest<WatchList> = WatchList.fetchRequest()
        guard let watchList = try? self.persistentContainer.viewContext.fetch(request) else { return [] }
        return watchList
    }

    func searchRecord(title: String) -> Bool {
        let request: NSFetchRequest<WatchList> = WatchList.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        guard let resultRequest = try? self.persistentContainer.viewContext.fetch(request) else { return false }
        if resultRequest.first != nil {
            return true
        } else {
            return false
        }
    }

    func fetchWatchList(title: String) -> WatchList? {
        let request: NSFetchRequest<WatchList> = WatchList.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        guard let resultRequest = try? self.persistentContainer.viewContext.fetch(request) else { return nil }
        guard let watchList = resultRequest.first else { return nil }
        return watchList
    }
    // MARK: - Save Movie In WatchList
    func addMovieInWatchList(movie: Movie, image: UIImage) {
        let watchList = WatchList(context: self.persistentContainer.viewContext)
        saveMovieInWatchList(movie: movie, watchListCoreData: watchList, image: image)
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            //TODO: - gérer l'erreur
        }
    }

    private func saveMovieInWatchList(movie: Movie, watchListCoreData: WatchList, image: UIImage) {
        let watchListSave = watchListCoreData
        watchListSave.overview = movie.overview
        watchListSave.posterPath = movie.posterPath
        watchListSave.realeaseDate = movie.releaseDate
        watchListSave.title = movie.title
        watchListSave.voteAverage = movie.voteAverage
        watchListSave.image = image.jpegData(compressionQuality: 0.1)
    }
    // MARK: - Delete
    func deleteMovieInWatchList(movieCoreData: WatchList) {
        self.persistentContainer.viewContext.delete(movieCoreData)
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            //TODO: - gérer l'erreur
        }
    }

    func deleteAll(watchLists: [WatchList]) {
        watchLists.forEach {
            deleteMovieInWatchList(movieCoreData: $0)
        }
    }
}
