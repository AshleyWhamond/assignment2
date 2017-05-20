//
//  ViewExhibitionVC.swift
//  assignment2
//
//  Created by Ashley Whamond on 20/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import CoreData

class ViewExhibitionVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        exhibitionTitle.text = getTitle
        dates.text = getDates
        loadExbInfo()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var exhibitionTitle: UILabel!
    @IBOutlet weak var dates: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var notes: UITextView!
    
    var getTitle : String!
    var getDates : String!
    var getLocation : String!
    
    
    var sentTitle: String?
    @IBAction func viewArtworks(_ sender: UIButton) {
        sentTitle = (exhibitionTitle.text)

        performSegue(withIdentifier: "exbID", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "exbInfo") {
            let viewArtworks = segue.destination as! artworksTVC
            print("fired")
            viewArtworks.exbTitle = sentTitle
        }
    }
    
    
    
    
    

    
/***********************************************************
 * Gets data from Exhibition entity based on Exhibition name 
 * from exhibitionTitle label sent from selected table cell.
 **********************************************************/
    
    func loadExbInfo() {
        let exbContext = AppDelegate.getViewContext()
        let fetchRequest = NSFetchRequest<Exhibition>(entityName: "Exhibition")
        let predicate = NSPredicate(format: "%K == %@", "name", getTitle)
        fetchRequest.predicate = predicate
        
        do {
            let result = try exbContext.fetch(fetchRequest)
            for r in result {
                if let exbLoc = r.value(forKey: "location"), let exNotes = r.value(forKey: "notes"){
                    print("\(exbLoc)")
                    location.text = exbLoc as? String
                    notes.text = exNotes as? String
                }
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }

        

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
