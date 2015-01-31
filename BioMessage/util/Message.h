//
//  Message.h
//  BioMessage
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "RLMObject.h"

@interface Message : RLMObject

@property NSString *text;
@property NSDate *sent;

@property NSString *sender;
@property NSString *recipient;

@end

RLM_ARRAY_TYPE(Message)
