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


//-(NSMutableDictionary*) result: (int) action;
-(BOOL) goalTest: (PuzzleNode*) testNode;
-(void) printState: (NSMutableDictionary*) a_state;
-(void) printCurrentState;
- (Problem*) initWithFile: (NSString*) fileName andColumns: (int) a_cols andRows:(int) a_rows;
-(NSMutableArray*) getAllLegalMoves: (PuzzleNode*) a_node;
- (PuzzleNode*) resultOfAction: (NSString*) a_action givenNode: (PuzzleNode*) a_node;

-(void) testMoves;
-(void) printPathToCurrentNode;
-(NSMutableArray*) getAllAdjacent: (PuzzleNode*) a_node;
-(BOOL) BFS;
-(BOOL) haveWeBeenHereBefore: (NSMutableDictionary*) a_state givenHistory: (NSMutableArray*) a_history;
@end
