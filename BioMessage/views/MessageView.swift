//
//  MessageView.swift
//  BioMessage
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

class MessageView: UIView {
    
    init(message: Message) {
        let deviceSize = UIScreen.mainScreen().bounds
        
        let label = UILabel(frame: CGRectMake(0, 0, deviceSize.width * 0.75, deviceSize.height))
        label.text = message.text
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Avenir-Roman", size: 14)
        label.numberOfLines = 0
        label.sizeToFit()
        label.frame = CGRectMake(8, 8, label.frame.size.width, label.frame.size.height)
        
        super.init(frame: CGRectMake(0, 100, label.frame.size.width + 16, label.frame.size.height + 16))
        
        self.backgroundColor = UIColor.flatGreenColor()
        
        self.addSubview(label)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
