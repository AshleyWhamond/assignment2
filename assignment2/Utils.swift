//
//  Utils.swift
//  assignment2
//
//  Created by Ashley Whamond on 18/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import Foundation
import CoreData

class Utils {
    
    static var exhibitions : [Exhibition] = []
    static var artworks : [Artwork] = []
    
    class func loadExhibitions() {
        let exbContext = AppDelegate.getViewContext()
        
        //define fetch request
        let exbFetchRequest : NSFetchRequest<Exhibition> = Exhibition.fetchRequest()
        
        do{
            exhibitions = try! exbContext.fetch(exbFetchRequest)
        }
        
    }
    
    class func getExhibitionArtworks(exbTitle : String) -> [Artwork]{
        var exbArtworks : [Artwork] = []
        
        let awContext = AppDelegate.getViewContext()
        
        
        let awFetchRequest : NSFetchRequest<Artwork> = Artwork.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", "exhibition", exbTitle)
        awFetchRequest.predicate = predicate
        
        do {
            let result = try awContext.fetch(awFetchRequest)
            for r in result {
                if let artworkArtist = r.value(forKey: "artist"), let artworkTitle = r.value(forKey: "title"), let artworkYear = r.value(forKey: "year"){
                    print("\(artworkArtist), \(artworkTitle), \(artworkYear)")
                    exbArtworks.append(contentsOf: result)
                }
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return exbArtworks
    }

}


//func loadExbInfo() {
//    let exbContext = AppDelegate.getViewContext()
//    let fetchRequest = NSFetchRequest<Exhibition>(entityName: "Exhibition")
//    let predicate = NSPredicate(format: "%K == %@", "name", getTitle)
//    fetchRequest.predicate = predicate
//    
//    do {
//        let result = try exbContext.fetch(fetchRequest)
//        for r in result {
//            if let exbLoc = r.value(forKey: "location"), let exNotes = r.value(forKey: "notes"){
//                print("\(exbLoc)")
//                location.text = exbLoc as? String
//                notes.text = exNotes as? String
//            }
//        }
//    } catch {
//        let fetchError = error as NSError
//        print(fetchError)
//    }
//    
//    
//    
//}
