//
//  NymiKit.m
//  BioMessage
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

#import "NymiKit.h"

@implementation NymiKit

- (id)init {
    self = [super init];
    if (self) {
        [self setEventTypeToWaitFor:NCL_EVENT_INIT];
        
        nclSetIpAndPort("127.0.0.1", 9089);
        NclBool result = nclInit(callback, (__bridge void *)(self), "BioMessage", NCL_MODE_DEFAULT, nil);
        
        if (!result) {
            NSLog(@"Failure during nclInit");
        } else {
            NSLog(@"nclInit returned success");
        }
        
        [self waitNclForEvent];
    }
    return self;
}

- (void)setEventTypeToWaitFor:(NclEventType)eventType {
    self.correctNclEventReceived = NO;
    self.waitOnEventType = eventType;
}

- (void)waitNclForEvent {
    if (!self.correctNclEventReceived) {
        [self performSelector:@selector(waitNclForEvent) withObject:nil afterDelay:0.5];
    }
}

- (void)discoverNymiBand {
    nclStartDiscovery();
}

- (void)agreeNymiBand:(int)withHandle {
    nclAgree(withHandle);
}

- (void)provisionNymiBand:(int)withHandle {
    nclProvision(withHandle, NCL_TRUE);
}

- (void)findNymiBand {
    nclStartFinding(self.currentProvision, 1, NO);
}

- (void)validateNymiBand:(int)withHandle {
    nclValidate(withHandle);
}

- (void)disconnectNymiBand:(int)withHandle {
    nclDisconnect(withHandle);
}

- (void)stopScan {
    nclStopScan();
}

bool nymiBandProvisioned = false;

void callback(NclEvent event, void *userData) {
    NymiKit *nk = (__bridge NymiKit *)userData;
    
    if (!nymiBandProvisioned) {
        switch (event.type) {
            case NCL_EVENT_INIT:
                if (event.init.success) {
                    [nk setEventTypeToWaitFor:NCL_EVENT_DISCOVERY];
                    [nk discoverNymiBand];
                    [nk waitNclForEvent];
                }
                break;
            case NCL_EVENT_DISCOVERY:
                [nk setEventTypeToWaitFor:NCL_EVENT_AGREEMENT];
                [nk agreeNymiBand:event.discovery.nymiHandle];
                [nk waitNclForEvent];
                break;
            case NCL_EVENT_AGREEMENT:
                [nk setEventTypeToWaitFor:NCL_EVENT_PROVISION];
                [nk provisionNymiBand:event.agreement.nymiHandle];
                [nk waitNclForEvent];
                break;
            case NCL_EVENT_PROVISION:
                nk.currentProvision = &(event.provision.provision);
                
                [nk disconnectNymiBand:event.provision.nymiHandle];
                nymiBandProvisioned = YES;
                NSLog(@"provisioned successfully");
                break;
            default:
                break;
        }
    } else {
        switch (event.type) {
            case NCL_EVENT_FIND:
                [nk setEventTypeToWaitFor:NCL_EVENT_VALIDATION];
                [nk validateNymiBand:event.find.nymiHandle];
                [nk waitNclForEvent];
                [nk stopScan];
                break;
            case NCL_EVENT_VALIDATION:
                [nk disconnectNymiBand:event.validation.nymiHandle];
                break;
            case NCL_EVENT_DISCONNECTION:
                NSLog(@"disconnected reason %s", disconnectionReasonToString(event.disconnection.reason));
                break;
            default:
                break;
        }
    }
    
    nk.currentEvent = event;
    
    if (event.type == nk.waitOnEventType) {
        nk.correctNclEventReceived = true;
    }
}

const char* disconnectionReasonToString(NclDisconnectionReason reason){
    switch(reason){
        case NCL_DISCONNECTION_LOCAL:
            return "NCL_DISCONNECTION_LOCAL";
        case NCL_DISCONNECTION_TIMEOUT:
            return "NCL_DISCONNECTION_TIMEOUT";
        case NCL_DISCONNECTION_FAILURE:
            return "NCL_DISCONNECTION_FAILURE";
        case NCL_DISCONNECTION_REMOTE:
            return "NCL_DISCONNECTION_REMOTE";
        case NCL_DISCONNECTION_CONNECTION_TIMEOUT:
            return "NCL_DISCONNECTION_CONNECTION_TIMEOUT";
        case NCL_DISCONNECTION_LL_RESPONSE_TIMEOUT:
            return "NCL_DISCONNECTION_LL_RESPONSE_TIMEOUT";
        case NCL_DISCONNECTION_OTHER:
            return "NCL_DISCONNECTION_OTHER";
        default: break;
    }
    return "invalid disconnection reason, something bad happened";
}

@end
