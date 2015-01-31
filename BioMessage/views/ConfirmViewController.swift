//
//  ConfirmViewController.swift
//  BioMessage
//
//  Created by Jack Cook on 1/30/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {

    @IBOutlet var readyButton: UIButton!
    
    var nk: NymiKit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        self.navigationController?.navigationBar.barStyle = .Black
        
        self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: [UIColor.flatLimeColorDark(), UIColor.flatLimeColor()])
        
        readyButton.setBackgroundImage(UIImage(named: "white.png"), forState: .Normal)
        readyButton.setBackgroundImage(UIImage(named: "gray.png"), forState: .Highlighted)
        
        readyButton.layer.cornerRadius = 8
        readyButton.clipsToBounds = true
        
        readyButton.setTitleColor(UIColor(red: 0.56, green: 0.7, blue: 0.11, alpha: 1), forState: .Normal)
        readyButton.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 28)
    }
    
    @IBAction func readyButtonPressed(sender: AnyObject) {
//        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//        
//        switch APAddressBook.access() {
//        case APAddressBookAccess.Granted:
//            loadContacts()
//        case APAddressBookAccess.Denied:
//            MBProgressHUD.hideHUDForView(self.view, animated: false)
//            
//            let url = NSURL(string: UIApplicationOpenSettingsURLString)!
//            UIApplication.sharedApplication().openURL(url)
//        case .Unknown:
//            loadContacts()
//        }
        
        if let nymikit = nk {
            nk.setEventTypeToWaitFor(NCL_EVENT_FIND)
            nk.findNymiBand()
            nk.waitNclForEvent()
        } else {
            nk = NymiKit()
        }
    }
    
    func loadContacts() {
        let addressBook = APAddressBook()
        addressBook.fieldsMask = .FirstName | .LastName | .Company | .Phones | .Photo | .RecordID
        addressBook.loadContacts({ (loadedContacts, error) -> Void in
            if error == nil {
                contacts = loadedContacts as [APContact]
            } else {
                let url = NSURL(string: UIApplicationOpenSettingsURLString)!
                UIApplication.sharedApplication().openURL(url)
            }
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.performSegueWithIdentifier("peopleSegue", sender: self)
        })
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
