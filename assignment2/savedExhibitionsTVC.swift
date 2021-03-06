//
//  savedExhibitionsTVC.swift
//  assignment2
//
//  Created by Ashley Whamond on 19/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import CoreData

class savedExhibitionsTVC: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utils.loadExhibitions()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source

/************************************************************
* code added to this function to display "no data" message dervied from: http://stackoverflow.com/questions/28532926/if-no-table-view-results-display-no-results-on-screen
************************************************************/
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        var numOfSections: Int = 1
        
        if Utils.exhibitions.count > 0 {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else {
            let noExbMsg: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noExbMsg.text          = "No exhibitions saved"
            noExbMsg.textColor     = UIColor.black
            noExbMsg.textAlignment = .center
            tableView.backgroundView  = noExbMsg
            tableView.separatorStyle  = .none
        }

        return numOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Utils.exhibitions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exbCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = Utils.exhibitions[indexPath.row].name
        let startDate = Utils.exhibitions[indexPath.row].startDate
        let endDate = Utils.exhibitions[indexPath.row].endDate
        cell.detailTextLabel?.text = "\(startDate!) - \(endDate!)"
        return cell
    }
    
    var sentTitle: String?
    var sentDates: String?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as UITableViewCell!
        
        sentTitle = (currentCell?.textLabel?.text)!
        sentDates = (currentCell?.detailTextLabel?.text)!
        
        performSegue(withIdentifier: "exbInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "exbInfo") {
            let viewExb = segue.destination as! ViewExhibitionVC
            print("fired")
            viewExb.getTitle = sentTitle
            viewExb.getDates = sentDates
        }
    }
    
    
    
    
/************************************************************
 * func for swipe delete of table cell dervied from: https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells
 ***********************************************************/
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        let exbContext = AppDelegate.getViewContext()
        if editingStyle == .delete {

            exbContext.delete(Utils.exhibitions[indexPath.row])
            Utils.exhibitions.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            Utils.loadExhibitions()
            try! exbContext.save()
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
