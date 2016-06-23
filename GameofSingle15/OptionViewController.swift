//
//  OptionViewController.swift
//  GameofSingle15
//
//  Created by Koichi Okada on 6/7/16.
//  Copyright © 2016 GregSimons. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var pickerX: UIPickerView!
    @IBOutlet var cutOffTime: UILabel!
    @IBOutlet var sliderX: UISlider!
    
    @IBOutlet var soundsSwitch: UISwitch!
    @IBOutlet var moveSwitch: UISwitch!
    @IBOutlet var tickingSwitch: UISwitch!
    @IBOutlet var bgmSwitch: UISwitch!
    @IBOutlet var cheeringSwitch: UISwitch!
    @IBOutlet var loudAppSwitch: UISwitch!
    @IBOutlet var politeAppSwitch: UISwitch!
    @IBOutlet var beginningSwitch: UISwitch!
    
    let pickerDataSource = ["Easy(3x3)", "Medium(Default 4x4)", "Hard(5x5)"]
    let pickerDefaultValue = 1
    
    let sliderDefaultValue = 10
    var sliderIntValue = 0

    var rows: Int = 4
    var cols: Int = 4
    
    var sounds: [String: Bool] = [String: Bool]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pickerX.dataSource = self
        self.pickerX.delegate = self
        // Set default values for picker
        self.pickerX.selectRow(self.pickerDefaultValue, inComponent: 0, animated: true)

        self.sliderX.setValue(Float(self.sliderDefaultValue), animated: true)
        self.cutOffTime.text = sliderDefaultValue.description

        initializeSounds()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    /*
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerDataSource[row]
    }
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.rows = row + 3
        self.cols = self.rows
    }

    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.init(red: 123/255.0, green: 10/255.0, blue: 65/255.0, alpha: 1)
        pickerLabel.text = self.pickerDataSource[row]
        //pickerLabel.font = UIFont(name: (pickerLabel.font?.fontName)!, size: 17)
        pickerLabel.font = UIFont(name: "Chalkboard SE", size: 17) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.Left
        return pickerLabel
    }

    // get changed slider data for totalTime
    @IBAction func sliderChanged(sender: UISlider) {
        self.sliderIntValue = Int(sender.value)
        self.cutOffTime.text = self.sliderIntValue.description
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     
        if segue.identifier == "settingSegue" {
            let sampleview = segue.destinationViewController as! ViewController

            getSoundConfiguration()

            // set all setting data in GameObject
            // pass the data to Main ViewController
            sampleview.gameObject = GameObject(rows: self.rows, cols: self.cols, totalTime: self.sliderIntValue, sounds: sounds)
        }
    }

    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // Sound configurations
    
    // initialize sound configurations
    func initializeSounds() {
        soundsSwitch.setOn(true, animated: true)
        moveSwitch.setOn(true, animated: true)
        tickingSwitch.setOn(true, animated: true)
        bgmSwitch.setOn(true, animated: true)
        cheeringSwitch.setOn(true, animated: true)
        loudAppSwitch.setOn(true, animated: true)
        politeAppSwitch.setOn(true, animated: true)
        beginningSwitch.setOn(true, animated: true)
        
        soundsSwitch.addTarget(self, action: #selector(OptionViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // set switch configuration when sounds status is switched
    func stateChanged(switchState: UISwitch) {
        if (switchState.on) {
            moveSwitch.setOn(true, animated: true)
            tickingSwitch.setOn(true, animated: true)
            bgmSwitch.setOn(true, animated: true)
            cheeringSwitch.setOn(true, animated: true)
            loudAppSwitch.setOn(true, animated: true)
            politeAppSwitch.setOn(true, animated: true)
            beginningSwitch.setOn(true, animated: true)
            
            moveSwitch.enabled = true
            tickingSwitch.enabled = true
            bgmSwitch.enabled = true
            cheeringSwitch.enabled = true
            loudAppSwitch.enabled = true
            politeAppSwitch.enabled = true
            beginningSwitch.enabled = true
        } else {
            moveSwitch.setOn(false, animated: true)
            tickingSwitch.setOn(false, animated: true)
            bgmSwitch.setOn(false, animated: true)
            cheeringSwitch.setOn(false, animated: true)
            loudAppSwitch.setOn(false, animated: true)
            politeAppSwitch.setOn(false, animated: true)
            beginningSwitch.setOn(false, animated: true)
            
            moveSwitch.enabled = false
            tickingSwitch.enabled = false
            bgmSwitch.enabled = false
            cheeringSwitch.enabled = false
            loudAppSwitch.enabled = false
            politeAppSwitch.enabled = false
            beginningSwitch.enabled = false
        }
    }
    
    // get current sound configurations
    func getSoundConfiguration() {
        sounds["sounds"] = soundsSwitch.on
        sounds["move"] = moveSwitch.on
        sounds["secondtick"] = tickingSwitch.on
        sounds["background"] = bgmSwitch.on
        sounds["cheering"] = cheeringSwitch.on
        sounds["loudapplause"] = loudAppSwitch.on
        sounds["politeapplause"] = politeAppSwitch.on
        sounds["begingame"] = beginningSwitch.on
    }
}
