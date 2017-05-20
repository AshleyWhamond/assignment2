//
//  artworksTVC.swift
//  assignment2
//
//  Created by Ashley Whamond on 20/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit

class artworksTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Utils.loadArtworks(exbTitle: exbTitle) // uses exhibition title parameter passed from Exhbition page to display artworks from that exhibition only
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var exbTitle : String!

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let exhibitionArtworks = Utils.getExhibitionArtworks(exbTitle : exbTitle)
        var numOfSections: Int = 1
        
        if exhibitionArtworks.count > 0 {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else {
            let noExbMsg: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noExbMsg.text          = "No Artworks Saved"
            noExbMsg.textColor     = UIColor.black
            noExbMsg.textAlignment = .center
            tableView.backgroundView  = noExbMsg
            tableView.separatorStyle  = .none
        }
        
        return numOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let exhibitionArtworks = Utils.getExhibitionArtworks(exbTitle : exbTitle)
        // #warning Incomplete implementation, return the number of rows
        return exhibitionArtworks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exhibitionArtworks = Utils.getExhibitionArtworks(exbTitle : exbTitle)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "awCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = exhibitionArtworks[indexPath.row].artist
        let title = exhibitionArtworks[indexPath.row].title
        let year = exhibitionArtworks[indexPath.row].year
        cell.detailTextLabel?.text = "\(title!), \(year!)"
        //cell.imageView
        return cell
    }

    
//    var sentTitle: String?
//    var sentDates: String?
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        
//        let indexPath = tableView.indexPathForSelectedRow
//        let currentCell = tableView.cellForRow(at: indexPath!) as UITableViewCell!
//        
//        sentTitle = (currentCell?.textLabel?.text)!
//        sentDates = (currentCell?.detailTextLabel?.text)!
//        
//        performSegue(withIdentifier: "exbInfo", sender: self)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "exbInfo") {
//            let viewExb = segue.destination as! ViewExhibitionVC
//            print("fired")
//            viewExb.getTitle = sentTitle
//            viewExb.getDates = sentDates
//        }
//    }
    
    
/************************************************************
* func for swipe delete of table cell dervied from: https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells
***********************************************************/
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){

        let awContext = AppDelegate.getViewContext()
        if editingStyle == .delete {
            
            awContext.delete(Utils.exhibitions[indexPath.row])
            Utils.artworks.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            //Utils.getExhibitionArtworks(exbTitle : exbTitle)
            try! awContext.save()
            self.tableView.reloadData()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
