//
//  RecordViewController.swift
//  GameofSingle15
//
//  Created by Koichi Okada on 6/7/16.
//  Copyright © 2016 GregSimons. All rights reserved.
//

import UIKit
import CoreData


class RecordViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let moc = DataController().managedObjectContext // instance of our managedObjectContext
    var frcMove : NSFetchedResultsController!
    var frcTime : NSFetchedResultsController!
    var moveArr = [MoveRecords]() // Declare an array to store move records
    var timeArr = [TimeRecords]() // Declare an array to store time records
    var rankingCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        // Display applicable data in CoreData
        fetchRecords()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Configure Table View
    
    // Set number of section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //return tableDatas.count
        return 1
    }

    // Return total number of cells, when called this datasource method
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // limit the number of cell to 10. More than 10 data is not displayed.
        return moveArr.isEmpty || moveArr.count <= 10 ? moveArr.count : 10
    }

    @IBAction func doneButton(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    }

    // Func to fetch the records in CoreData
    func fetch()->Bool{
        rankingCount = 0;

        let frMove = NSFetchRequest(entityName: "MoveRecords")
        let sdMove = NSSortDescriptor(key: "iMove", ascending: true)
        frMove.sortDescriptors = [sdMove]
        frcMove = NSFetchedResultsController(fetchRequest: frMove, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frcMove.delegate = self
        
        let frTime = NSFetchRequest(entityName: "TimeRecords")
        let sdTime = NSSortDescriptor(key: "iTime", ascending: true)
        frTime.sortDescriptors = [sdTime]
        frcTime = NSFetchedResultsController(fetchRequest: frTime, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frcTime.delegate = self
        
        var error: NSError? = nil
        let count = moc.countForFetchRequest(frMove, error: &error)
        
        do {
            try frcMove.performFetch()
            try frcTime.performFetch()
        } catch {
            fatalError("Warning warning fatal error happened: \(error)")
        }
        
        moveArr = frcMove.fetchedObjects as! [MoveRecords]
        timeArr = frcTime.fetchedObjects as! [TimeRecords]
        
        if (count == 0){
            return false
        }
        else{
            return true
        }
    }

    func fetchRecords() {
        if(!fetch()) {
            let alert = UIAlertView(title: "No Record Yet", message: "", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }



    // Set values in a Cell, when called this datasource method.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        // Get reusable Cell
        let cell = tableView.dequeueReusableCellWithIdentifier("recordCell", forIndexPath: indexPath) as! RecordTableViewCell
        
        if rankingCount <= 9 {
            // Set values to a Cell
            let convertedInt = timeArr[indexPath.row].iTime.integerValue
            let strSeconds = String(format: "%02d", convertedInt % 60)
            let strMinutes = String(format: "%02d", convertedInt / 60)
        
            cell.iRanking!.text = String(rankingCount + 1) + ". "
            cell.iTime!.text = strMinutes + ":" + strSeconds
            cell.iMove!.text = String(moveArr[indexPath.row].iMove)
            
            rankingCount += 1
        }
        
        return cell
    }

    /*
     func updateRecordsOnLabel(){
     
     if(!fetch()){
     // showBestMoveLabel.text = "No Record Yet"
     // showBestTimeLabel.text = "No Record Yet"
     print("No Record Yet")
     }
     else{
     let convertedInt = timeArr[0].iTime.integerValue
     
     let strSeconds = String(format: "%02d", convertedInt % 60)
     let strMinutes = String(format: "%02d", convertedInt / 60)
     
     // showBestMoveLabel.text = "Move Rec: " + String(moveArr[0].iMove)
     // showBestTimeLabel.text = "Time Rec: " + strMinutes + ":" + strSeconds
     print("Move Rec: " + String(moveArr[0].iMove))
     print("Time Rec: " + strMinutes + ":" + strSeconds)
     }
     }
     */
}
