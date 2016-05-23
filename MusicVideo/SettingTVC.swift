//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Diego Russo on 22/05/2016.
//  Copyright © 2016 Diego Russo. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewController {

    
    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedBackDisplay: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    @IBOutlet weak var numberOfMusicVideos: UILabel!
    @IBOutlet weak var APICnt: UILabel!
    
    
    @IBOutlet weak var dragTheSliderDisplay: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // It stops the vertical bouncing/scrolling
        tableView.alwaysBounceVertical = false
        
        // That's an observer which runs preferredFontChange whenever the user changes the system font
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingTVC.preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        title = "Settings"
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        // Always check for its existence
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil){
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        } else {
            sliderCnt.value = 10.0
            APICnt.text = ("\(Int(sliderCnt.value))")
        }

    }
    
    
    @IBAction func valueChanged(sender: UISlider) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(sliderCnt.value))")
    }
    
    @IBAction func touchIdSec(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchID.on {
            defaults.setBool(touchID.on, forKey: "SecSetting")
        } else {
            defaults.setBool(false, forKey: "SecSetting")
        }
    }
    
    
    func preferredFontChange() {
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        numberOfMusicVideos.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        dragTheSliderDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
    }

    // It is called just as the object  is about to be deallocated
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }
}
