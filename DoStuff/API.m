//
//  API.m
//  DoStuff
//
//  Created by Sebastian Bredberg on 13/05/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "API.h"
#import "AFNetworking.h"

@implementation API

static API *_client;

-(id)init{
    self = [super initWithBaseURL:[NSURL URLWithString:@"www.ollelind.se"]];
    if(self){
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setParameterEncoding:AFJSONParameterEncoding];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

+(API *)client{
    static dispatch_once_t onceToken;
    //thread-safe way to create a singleton
    dispatch_once(&onceToken, ^{
        _client = [[API allocWithZone:nil] init];
    });
    return _client;
}

@end
