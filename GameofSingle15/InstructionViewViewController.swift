//
//  InstructionViewViewController.swift
//  GameofSingle15
//
//  Created by Koichi Okada on 6/7/16.
//  Copyright © 2016 GregSimons. All rights reserved.
//

import UIKit

class InstructionViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
/*
    @IBAction func doneButton(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
    }
 */
    

    @IBAction func doneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
//    @IBAction func doneButton(sender: UIBarButtonItem) {
//        dismissViewControllerAnimated(true, completion: nil)
//    }
}
