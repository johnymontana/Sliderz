//
//  Problem.h
//  Sliderz
//
//  Created by lyonwj on 8/29/12.
//  Copyright (c) 2012 lyonwj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PuzzleNode.h"

@interface Problem : NSObject


@property PuzzleNode* currentNode;
@property int algoCode;
@property int heuristic;
@property int outputLevel;
@property int rows;
@property int columns;


-(NSMutableDictionary*) result: (int) action;
-(BOOL) goalTest: (NSMutableDictionary*) state;
-(void) printState: (NSMutableDictionary*) state;
-(void) printCurrentState;
- (Problem*) initWithFile: (NSString*) fileName andColumns: (int) a_cols andRows:(int) a_rows;
-(NSMutableArray*) getAllLegalMoves;

@end
