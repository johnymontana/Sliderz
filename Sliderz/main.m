//
//  main.m
//  Sliderz
//
//  Created by lyonwj on 8/29/12.
//  Copyright (c) 2012 lyonwj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Problem.h"
#import "SolveWithAStar.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool
    
    {
        
        int columns = 3;        // number of columns for puzzle
        int rows = 3;           // number of rows for puzzle
        NSMutableArray* legalMoves;
   
        NSLog(@"Creating m*n puzzle from file: %@",[NSString stringWithCString:argv[1]]);
        
        NSString* fileName = [NSString stringWithCString:argv[1]];
        
        
        Problem* myPuzzle = [[Problem alloc] initWithFile:fileName andColumns:columns andRows:rows ];
        
     //   [myPuzzle printCurrentState];
     //   [myPuzzle testMoves];
        
       // if (myPuzzle.algoCode==1)
      //  {
      //      [SolveWithAStar givenProblem:myPuzzle];
      //  }
        
        
       // NSLog(@"Zero position: %i", [myPuzzle.zeroKey intValue]);
        
      //  legalMoves = [myPuzzle getAllLegalMoves];
        
   //    for (int i=0; i<[legalMoves count]; i++)
  //     {
  //          NSLog(@"Legal Moves: %@", [legalMoves objectAtIndex:i]);
  //     }
        
       // [myPuzzle testMoves];
    //    [myPuzzle printCurrentState];
        
    //    legalMoves = [myPuzzle getAllLegalMoves];
        
    //    for (NSString* move in legalMoves)
    //    {
    //        NSLog(@"Legal Moves: %@", move);
    //    }
        
    //    [myPuzzle printPathToCurrentNode];
        
    //    if ([myPuzzle goalTest])
     //   {
     //       NSLog (@"GOALTEST TRUE");
        
    //    }
    //    else
    //    {
    //        NSLog(@"GOALTEST FALSE");
    //    }
        
        
        
        //NSLog(@"GoalTest: %@",[myPuzzle goalTest]);
      //  NSLog(@"Legal moves:")
        
   //     for (int i=0; i<[myPuzzle.tileKeys count]; i++)
   //     {
   //         NSLog(@"Keys: %i", [[myPuzzle.tileKeys objectAtIndex:i] intValue]);
   //     }
        
        
    
        [myPuzzle BFS];
       // [myPuzzle testMoves];
    }
    
    return 0;
}

