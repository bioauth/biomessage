//
//  Person.h
//  BioMessage
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "Message.h"
#import "RLMArray.h"
#import "RLMObject.h"

@interface Person : RLMObject

@property NSString *fullName;
@property int identifier;

@end
