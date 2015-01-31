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
    var messages: RLMResults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        
        self.navigationController?.navigationBar.barTintColor = UIColor.flatLimeColorDark()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        
        self.navigationItem.title = person.fullName
        
        messages = Message.allObjects()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.flatWhiteColor()
        tableView.contentOffset = CGPointMake(0, CGFloat.max)
        
        textField.frame = CGRectMake(16, textField.frame.origin.y, 298, textField.frame.size.height)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillHide(notification: NSNotification) {
//        let deviceSize = UIScreen.mainScreen().bounds
//        
//        UIView.animateWithDuration(0.5, animations: { () -> Void in
//            self.toolBar.frame = CGRectMake(0, deviceSize.height - self.toolBar.frame.size.height, self.toolBar.frame.size.width, self.toolBar.frame.size.height)
//            //self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, self.tableView.frame.size.width, deviceSize.height - self.tableView.frame.origin.y - (deviceSize.height - self.toolBar.frame.size.height))
//        })
    }
    
    @IBAction func sendButtonPressed(sender: AnyObject) {
        if textField.text != "" {
            let deviceSize = UIScreen.mainScreen().bounds
            
            let message = Message()
            message.text = textField.text
            message.sender = "Jack Cook"
            message.recipient = person.fullName
            message.sent = NSDate()
            
            textField.text = ""
            self.view.endEditing(true)
            
            let realm = RLMRealm.defaultRealm()
            
            realm.beginWriteTransaction()
            realm.addObject(message)
            realm.commitWriteTransaction()
            
            messages = Message.allObjects()
            
            tableView.reloadData()
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
//        let deviceSize = UIScreen.mainScreen().bounds
        
//        toolBar.setTranslatesAutoresizingMaskIntoConstraints(true)
//        toolBar.frame = CGRectMake(0, 365, self.toolBar.frame.size.width, self.toolBar.frame.size.height)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let deviceSize = UIScreen.mainScreen().bounds
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "MessageCell")
        cell.backgroundColor = UIColor.flatWhiteColor()
        
        let message = messages.objectAtIndex(UInt(indexPath.row)) as Message
        let messageView: MessageView = MessageView(message: message)
        messageView.frame = CGRectMake(deviceSize.width - messageView.frame.size.width - 10, 0, messageView.frame.size.width, messageView.frame.size.height)
        println(messageView.frame.size.height)
        
        cell.addSubview(messageView)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let message = messages.objectAtIndex(UInt(indexPath.row)) as Message
        let messageView: MessageView = MessageView(message: message)
        
        return messageView.frame.size.height + 8
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(messages.count)
    }
}
