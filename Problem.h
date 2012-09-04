//
//  Problem.h
//  Sliderz
//
//  Created by lyonwj on 8/29/12.
//  Copyright (c) 2012 lyonwj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Problem : NSObject

//@property NSMutableDictionary *state;
@property Node* headNode;
@property int algoCode;
@property int heuristic;
@property int outputLevel;
@property int columns;
@property int rows;
@property NSArray* tileKeys;
@property NSNumber* zeroKey;
@property BOOL zeroIsOnRight;
@property BOOL zeroIsOnLeft;

-(NSMutableDictionary*) result: (int) action;
-(BOOL) goalTest: (NSMutableDictionary*) state;
-(void) printState: (NSMutableDictionary*) state;
-(void) printCurrentState;
- (Problem*) initWithFile: (NSString*) fileName andColumns: (int) a_cols andRows:(int) a_rows;
-(NSMutableArray*) getAllLegalMoves;

@end
