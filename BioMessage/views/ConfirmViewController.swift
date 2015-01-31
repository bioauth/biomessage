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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.TopToBottom, withFrame: self.view.frame, andColors: [UIColor.flatLimeColorDark(), UIColor.flatLimeColor()])
        
        readyButton.setBackgroundImage(UIImage(named: "white.png"), forState: .Normal)
        readyButton.setBackgroundImage(UIImage(named: "gray.png"), forState: .Highlighted)
        
        readyButton.layer.cornerRadius = 8
        readyButton.clipsToBounds = true
        
        readyButton.setTitleColor(UIColor(red: 0.56, green: 0.7, blue: 0.11, alpha: 1), forState: .Normal)
        readyButton.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 28)
    }
    
    @IBAction func readyButtonPressed(sender: AnyObject) {
        let addressBook = APAddressBook()
        addressBook.fieldsMask = .FirstName
        addressBook.loadContacts { (contacts, error) -> Void in
            
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
