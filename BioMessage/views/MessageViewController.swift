//
//  MessageViewController.swift
//  BioMessage
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var toolBar: UIToolbar!
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        
        self.navigationController?.navigationBar.barTintColor = UIColor.flatLimeColorDark()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        
        self.navigationItem.title = person.fullName
        
        tableView.dataSource = self
        tableView.delegate = self
        
        textField.frame = CGRectMake(16, textField.frame.origin.y, 298, textField.frame.size.height)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let deviceSize = UIScreen.mainScreen().bounds
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.toolBar.frame = CGRectMake(0, deviceSize.height - self.toolBar.frame.size.height, self.toolBar.frame.size.width, self.toolBar.frame.size.height)
        })
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let deviceSize = UIScreen.mainScreen().bounds
        
        toolBar.setTranslatesAutoresizingMaskIntoConstraints(true)
        toolBar.frame = CGRectMake(0, 365, self.toolBar.frame.size.width, self.toolBar.frame.size.height)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "MessageCell")
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(person.messages.count)
    }
}
