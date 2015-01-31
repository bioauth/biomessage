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
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        
        self.navigationController?.navigationBar.barTintColor = UIColor.flatLimeColorDark()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        
        self.navigationItem.title = person.fullName
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "MessageCell")
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(person.messages.count)
    }
}
