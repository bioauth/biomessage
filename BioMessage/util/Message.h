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

@end

RLM_ARRAY_TYPE(Message)
