//
//  AflamiTests.swift
//  AflamiTests
//
//  Created by Ahmed M. Hassan on 8/6/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Aflami


class AflamiTests: XCTestCase {
    
    private var dataManager: DataManager!
    
    override func setUp() {
        super.setUp()
        
        let realm = try! Realm()
        self.dataManager = DataManager(realm: realm)
    }
    /*
    func testSaveAndGetMovie() {
        
        let movie = Movie(id: 1, posterPath: "path", backdrop: "", title: "Amazing Spider-Man", releaseDate: "2019", rating: 7.9, overview: "")
        
        dataManager.add([movie.managedObject()], update: true)
        let predicate = NSPredicate(format: "id == 1")
        let foundMovie = dataManager.objects(MovieObject.self, predicate: predicate)
        
        XCTAssertEqual(foundMovie!.count, 1)
        
        let movie1 = foundMovie!.first
        XCTAssertEqual(movie1?.title, "Amazing Spider-Man")
    }
    */
    func testSaveAndUpdateMovie() {
        
        do {
            
            let movie = Movie(id: 1, posterPath: "path", backdrop: "", title: "Amazing Spider-Man", releaseDate: "2019", rating: 7.9, overview: "")
            
            try dataManager.write { (transaction) in
                transaction.add(movie.managedObject(), update: true)
            }
            
            let predicate = NSPredicate(format: "id == 1")
            let foundMovie = dataManager.objects(MovieObject.self, predicate: predicate)
            
            XCTAssertEqual(foundMovie!.count, 1)
            
            let movie1 = foundMovie!.first
            XCTAssertEqual(movie1?.title, "Amazing Spider-Man")
            
            try dataManager.write({ (transaction) in
                movie1?.title = "The Incredible Hulk"
                transaction.add(movie1!, update: true)
            })
            
            let predicate1 = NSPredicate(format: "title == 'The Incredible Hulk'")
            let changedMovies = dataManager.objects(MovieObject.self, predicate: predicate1)
            XCTAssertEqual(changedMovies?.count, 1)
            
            let changedMovie = changedMovies?.first
            XCTAssertEqual(changedMovie?.id, 1)
            
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }
    
    func testDelete() {

        do {
            let movie = Movie(id: 1, posterPath: "path", backdrop: "", title: "Amazing Spider-Man", releaseDate: "2019", rating: 7.9, overview: "")
            try dataManager.write { (transaction) in
                transaction.add(movie.managedObject(), update: true)
            }
            
            let movie1 = dataManager.object(MovieObject.self, key: 1)
            try dataManager.write { (transaction) in
                transaction.delete(movie1!)
            }
            
            let predicate1 = NSPredicate(format: "id == 1")
            let changedMovies = dataManager.objects(MovieObject.self, predicate: predicate1)
            XCTAssertEqual(changedMovies?.count, 0)
            
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }
    
}
