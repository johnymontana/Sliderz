//
//  PuzzleNode.h
//  Sliderz
//
//  Created by lyonwj on 9/4/12.
//  Copyright (c) 2012 lyonwj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuzzleNode : NSObject

@property NSMutableDictionary *state;
@property int columns;
@property int rows;
@property NSArray* tileKeys;
@property NSNumber* zeroKey;
@property BOOL zeroIsOnRight;
@property BOOL zeroIsOnLeft;
@property PuzzleNode* parent;
@property NSString* action;

-(PuzzleNode*) initWithState: (NSDictionary*) a_state andRows: (int) a_rows andColumns: (int) a_columns andParent: (PuzzleNode*) a_parent andTileKeys:(NSArray*) a_keys andAction: (NSString*) a_action;

@end
