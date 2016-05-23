//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Diego Russo on 22/05/2016.
//  Copyright © 2016 Diego Russo. All rights reserved.
//

import UIKit
import MessageUI

class SettingTVC: UITableViewController, MFMailComposeViewControllerDelegate {

    
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail(){
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                // no email account
                mailAlert()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func configureMail() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["me@diegor.it"])
        mailComposeVC.setSubject("Music Video App Feedback")
        mailComposeVC.setMessageBody("Hello,\n\nI would like to share the following feedback...\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailAlert() {
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No email Account setup for iPhone", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            // do something if you want
        }
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // That's the method of the protocol
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail Cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail Saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail Sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail Failed")
        default:
            print("Unknown Issue")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    

    // It is called just as the object  is about to be deallocated
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }
}
