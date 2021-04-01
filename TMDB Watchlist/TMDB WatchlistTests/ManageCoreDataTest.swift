//
//  ManageCoreDataTest.swift
//  TMDB WatchlistTests
//
//  Created by Clément Martin on 01/04/2021.
//

import XCTest
import CoreData
@testable import TMDB_Watchlist

class ManageCoreDataTest: XCTestCase {

    var manageCoreData: CoreDataManager!


    override func setUp() {
        super.setUp()
        manageCoreData = CoreDataManager(container: mockPersistantContainer)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func createWatchList() -> Movie {
        return MockObject.createMovie()
    }

    func testSaveMovieInWatchList() {
        let movie = createWatchList()
        XCTAssertEqual(manageCoreData.fetchAllWatchList().count, 0)

        guard let image = UIImage(named: "noImage") else { return }
        manageCoreData.addMovieInWatchList(movie: movie, image: image)

        XCTAssertEqual(manageCoreData.fetchAllWatchList().count, 1)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {

        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TMDB_Watchlist")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
}
