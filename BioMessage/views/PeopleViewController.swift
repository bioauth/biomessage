//
//  PeopleViewController.swift
//  BioMessage
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        
        self.navigationController?.navigationBar.barTintColor = UIColor.flatLimeColorDark()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        
        self.navigationItem.title = "Messages"
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "PersonCell")
        let contact = contacts[indexPath.row]
        
        var initials = ""
        var name = ""
        
        if let f = contact.firstName {
            initials += f[0]
            name += f
            if let l = contact.lastName {
                initials += l[0]
                name += " \(l)"
            }
        } else {
            if let l = contact.lastName {
                initials += l[0]
                name += l
            } else {
                if let c = contact.company {
                    initials += c[0]
                    name += c
                }
            }
        }
        
        if let p = contact.photo {
            let imageView = UIImageView(frame: CGRectMake(4, 4, 56, 56))
            imageView.layer.cornerRadius = 28
            imageView.clipsToBounds = true
            imageView.image = contact.photo
            cell.addSubview(imageView)
        } else {
            let initialsView = BMInitialsPlaceholderView(frame: CGRectMake(4, 4, 56, 56))
            initialsView.batchUpdateViewWithInitials(initials, circleColor: UIColor.randomFlatColor(), textColor: UIColor.whiteColor(), font: UIFont(name: "Avenir-Light", size: 16))
            initialsView.backgroundColor = UIColor.clearColor()
            cell.addSubview(initialsView)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.font = UIFont(name: "Avenir-Roman", size: 16)
        nameLabel.sizeToFit()
        nameLabel.frame = CGRectMake(60 + 12, 10, nameLabel.frame.size.width, nameLabel.frame.size.height)
        
        let messageLabel = UILabel()
        messageLabel.text = "Let's get coffee or something..."
        messageLabel.textColor = UIColor.flatGrayColorDark()
        messageLabel.font = UIFont(name: "Avenir-Roman", size: 14)
        messageLabel.sizeToFit()
        messageLabel.frame = CGRectMake(60 + 12, 64 - messageLabel.frame.size.height - 10, messageLabel.frame.size.width, messageLabel.frame.size.height)
        
        cell.addSubview(nameLabel)
        cell.addSubview(messageLabel)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
}
