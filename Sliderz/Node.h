//
//  Node.h
//  Sliderz
//
//  Created by lyonwj on 9/3/12.
//  Copyright (c) 2012 lyonwj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

// state, action, cost, parent

@property NSDictionary* state;
@property NSString* action;
@property int cost;
@property Node* parent;

@end
