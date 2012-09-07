//
//  Problem.m
//  Sliderz
//
//  Created by lyonwj on 8/29/12.
//  Copyright (c) 2012 lyonwj. All rights reserved.
//

#import "Problem.h"

@implementation Problem
@synthesize  algoCode, heuristic, outputLevel, currentNode, rows, columns;



-(Problem*) initWithFile: (NSString*) fileName andColumns: (int) a_cols andRows: (int) a_rows
{
    
    self.rows=a_rows;
    self.columns = a_cols;
    
    int myInt = 0;
    NSArray* tileArray = [NSArray alloc];
    NSMutableArray* keyArray = [[NSMutableArray alloc] init];
    PuzzleNode* tmpNode = [[PuzzleNode alloc] init];
    
    
    NSMutableArray* fileInputArray = [[NSMutableArray alloc] init];
    
    self = [super init];
    NSError *error;
   // NSData* data = [[NSData alloc] initWithContentsOfFile:fileName];
    
    //NSString* fileContents = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString* fileContents = [[NSString alloc] initWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:&error];
    
    
    
    if (fileContents != nil)
    {
        NSLog(@"Read successful!");
        NSLog(@"%@", fileContents);
        
    }
    if (fileContents == nil)
    {
        // an error occurred
        NSLog(@"Error reading file at %@\n%@", fileName, [error localizedFailureReason]);
    }
    
    
   // NSLog(fileContents);
    
    
    NSScanner *theScanner = [NSScanner scannerWithString:fileContents];
    while ([theScanner isAtEnd] == NO)
    {
        [theScanner scanInt:&myInt];
       // NSLog(@"This is the scanner: %i", myInt);
        [fileInputArray addObject:[NSNumber numberWithInt:myInt]];
        
       // NSLog(@"This is the NSNumber: %i", (int)[NSNumber numberWithInt:myInt]);
        
      //  [myArray addObject:[theScanner scanInt:myInt]]
        
        
    }
    
    self.algoCode = [[fileInputArray objectAtIndex:0] intValue];
    self.heuristic = [[fileInputArray objectAtIndex:1] intValue];
    self.outputLevel = [[fileInputArray objectAtIndex:2] intValue];
    
    NSRange range = NSMakeRange(3, [fileInputArray count]-3);
    
    tileArray = [fileInputArray subarrayWithRange:range];
    for (int i=0; i<(a_rows*a_cols); i++)
    {
        [keyArray addObject:[NSNumber numberWithInt:i]];
    }
    
    
    tmpNode = [tmpNode initWithState:[[NSMutableDictionary alloc] initWithObjects:tileArray forKeys:keyArray] andRows:a_rows andColumns:a_cols andParent:nil andTileKeys:keyArray andAction:nil];
    
    
    self.currentNode = tmpNode;
   
    //self.state = [[NSMutableDictionary alloc] initWithObjects:tileArray forKeys:keyArray];
    //self.tileKeys = keyArray;
    return self;
}

-(void) printCurrentState
{
    //NSEnumerator *enumerator = [state keyEnumerator];
    NSArray* keys = [currentNode.state allKeys];
    
   printf("PRINT STATE:\n");
    
  //  printf("objectForKey 2: %i", [[state objectForKey:[NSNumber numberWithInt:2]] intValue]);
    
    for (int i=0; i<[currentNode.tileKeys count]; i++)
    {
        
        
    //    NSLog(@"KEYS: %i", [[keys objectAtIndex:i] intValue]);
    
    //    printf("enumerating dictionary\n");
        printf("%i ", [[currentNode.state objectForKey:[currentNode.self.tileKeys objectAtIndex:i]] intValue]);
        
               
        
     if (([[keys objectAtIndex:i] intValue]-1)%columns==0 && [[keys objectAtIndex:i] intValue]!=0)
        {
            printf("\n");
        }
            
    }
}

-(NSMutableArray*) getAllLegalMoves: (PuzzleNode*) a_node
{
    NSMutableArray* moves = [[NSMutableArray alloc] init];
    
    // NSArray containsObject: on tileKeys to determine if the move stays on the board
    // how to find the zero to start determining moves?
    
   // if (zeroPosition-columns) is contained in self.tileKeys then add "U" to moves array
    
    if ([a_node.tileKeys containsObject:[NSNumber numberWithInt:([a_node.zeroKey intValue]+a_node.columns)]])
    {
        [moves addObject:@"D"];
      //  NSLog(@"Down move new zero key:%i", [[NSNumber numberWithInt:([a_node.zeroKey intValue]+a_node.columns)] intValue]);
    }
    
   // NSLog(@"Up move new zero key:%i", [[NSNumber numberWithInt:([a_node.zeroKey intValue]-a_node.columns)] intValue]);
    
    if ([a_node.tileKeys containsObject:[NSNumber numberWithInt:([a_node.zeroKey intValue]-a_node.columns)]])
    {
        
        [moves addObject:@"U"];
    }
    
    if ([a_node.tileKeys containsObject:[NSNumber numberWithInt:([a_node.zeroKey intValue]+1)]] && !a_node.zeroIsOnRight)
    {
        
       [moves addObject:@"R"];
    }
    
    if ([a_node.tileKeys containsObject:[NSNumber numberWithInt:([a_node.zeroKey intValue]-1)]] && !a_node.zeroIsOnLeft)
    {
        
        [moves addObject:@"L"];
    }

   // NSLog(@"ALL LEGAL MOVES: %@", moves);
    return moves;
   // NSMutableArray *tmp = [[NSMutableArray alloc] init];
   // [tmp addObject:@"D"];
   // [tmp addObject:@"U"];
  //  return tmp;
}

-(PuzzleNode*) resultOfAction:(NSString *)a_action givenNode: (PuzzleNode*) a_node
{
    
    NSMutableDictionary* tmpState = [[NSMutableDictionary alloc] init];
    tmpState = a_node.state;
    NSNumber *tmpOldZero;
    PuzzleNode* newNode = [[PuzzleNode alloc] init];
    int currentZeroKey = [a_node.zeroKey intValue];
    
    tmpOldZero = [a_node.state objectForKey:a_node.zeroKey];
    
    if (a_action==@"D")
    {
        // swap state[zeroKey] with state[zeroKey+columns]
        NSNumber *tmpNewZero = [a_node.state objectForKey:[NSNumber numberWithInt:(currentZeroKey+self.columns)]];
        
        [tmpState removeObjectForKey:a_node.zeroKey];
        [tmpState removeObjectForKey:[NSNumber numberWithInt:(currentZeroKey+self.columns)]];
        
        [tmpState setObject:tmpNewZero forKey:[NSNumber numberWithInt:currentZeroKey]];
                                                                                                                   
        [tmpState setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInt:(currentZeroKey+self.columns)]];
        
    }
    
    
    else if (a_action==@"U")
    {
        NSNumber *tmpNewZero = [a_node.state objectForKey:[NSNumber numberWithInt:(currentZeroKey-self.columns)]];
        
        [tmpState removeObjectForKey:a_node.zeroKey];
        [tmpState removeObjectForKey:[NSNumber numberWithInt:(currentZeroKey-self.columns)]];
        
        [tmpState setObject:tmpNewZero forKey:[NSNumber numberWithInt:currentZeroKey]];
        
        [tmpState setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInt:(currentZeroKey-self.columns)]];
    }
    
    else if (a_action==@"R")
    {
        NSNumber *tmpNewZero = [a_node.state objectForKey:[NSNumber numberWithInt:(currentZeroKey+1)]];
        
        [tmpState removeObjectForKey:a_node.zeroKey];
        [tmpState removeObjectForKey:[NSNumber numberWithInt:(currentZeroKey+1)]];
        
        [tmpState setObject:tmpNewZero forKey:[NSNumber numberWithInt:currentZeroKey]];
        
        [tmpState setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInt:(currentZeroKey+1)]];
    }

    else if (a_action==@"L")
    {
        NSNumber *tmpNewZero = [a_node.state objectForKey:[NSNumber numberWithInt:(currentZeroKey-1)]];
        
        [tmpState removeObjectForKey:a_node.zeroKey];
        [tmpState removeObjectForKey:[NSNumber numberWithInt:(currentZeroKey-1)]];
        
        [tmpState setObject:tmpNewZero forKey:[NSNumber numberWithInt:currentZeroKey]];
        
        [tmpState setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInt:(currentZeroKey-1)]];
    }
    
    
newNode = [newNode initWithState:[[NSMutableDictionary alloc] initWithDictionary:tmpState] andRows:self.rows andColumns:self.columns andParent:a_node andTileKeys:a_node.tileKeys andAction:a_action];

    return newNode;
    
    
}
-(void) printState:(NSMutableDictionary *) a_state
{
    
    
    NSArray* keys = [currentNode.state allKeys];
    
    printf("PRINT STATE:\n");
    
    //  printf("objectForKey 2: %i", [[state objectForKey:[NSNumber numberWithInt:2]] intValue]);
    
    for (int i=0; i<[currentNode.tileKeys count]; i++)
    {
        
        
        //    NSLog(@"KEYS: %i", [[keys objectAtIndex:i] intValue]);
        
        //    printf("enumerating dictionary\n");
        printf("%i ", [[a_state objectForKey:[currentNode.self.tileKeys objectAtIndex:i]] intValue]);
        
        
        
        if (([[keys objectAtIndex:i] intValue]-1)%columns==0 && [[keys objectAtIndex:i] intValue]!=0)
        {
            printf("\n");
        }
        
    }

    
}


-(void) testMoves
{
    PuzzleNode *secondNode = [[PuzzleNode alloc] init];
    secondNode = [self resultOfAction:@"R" givenNode:self.currentNode];
    [self printState:secondNode.state];
    self.currentNode=secondNode;
    
    [self printPathToCurrentNode];
    
    [self printState:self.currentNode.state];
   // [self resultOfAction:@"U"];
   // [self resultOfAction:@"L"];
}


-(void) printPathToCurrentNode
{
    PuzzleNode *tmpNode;
    tmpNode = self.currentNode;
    
    while (tmpNode != nil)
    {
        NSLog(@"Path: %@", [tmpNode action]);
        tmpNode = tmpNode.parent;
    }
    
    
}

-(BOOL) goalTest: (PuzzleNode*) testNode
{
    // if key == objectForKey-1 for all entries except last
    // && last objectForKey = 0
    
    
    for (int i=0;i<[self.currentNode.tileKeys count]; i++)
    //for (NSNumber* key in self.currentNode.tileKeys)
    {
        
        if ([[self.currentNode.tileKeys objectAtIndex:i] intValue] == (self.rows*self.columns-1))
            {
                if ([[testNode.state objectForKey:[self.currentNode.tileKeys objectAtIndex:i]] intValue] == 0)
                {
                    return YES;
                }
                
                else
                {
                    return FALSE;
                }
            }
        
        else if ([[self.currentNode.tileKeys objectAtIndex:i] intValue] != ([[testNode.state objectForKey:[self.currentNode.tileKeys objectAtIndex:i]] intValue]-1))
        {
            return FALSE;
        }
    }
}

-(NSMutableArray*) getAllAdjacent:(PuzzleNode *)a_node
{
    NSMutableArray* adjacents = [[NSMutableArray alloc] init];
    
    for (NSString* string in [self getAllLegalMoves:a_node])
    {
        [adjacents addObject:(PuzzleNode*)[self resultOfAction:string givenNode:a_node]];
    }
    
    return adjacents;
}

-(BOOL) haveWeBeenHereBefore: (NSMutableDictionary*) a_state givenHistory: (NSMutableArray*) a_history
{
    for (NSMutableDictionary* dict in a_history)
    {
        NSEnumerator *enumerator = [dict keyEnumerator];
        id key;
        id x;
        id y;
        
        while ((key = [enumerator nextObject]))
        {
           // NSLog(@"dict:");
        //    [self printState:dict];
          //  NSLog(@"a_state");
       //     [self printState:a_state];
            x= [NSNumber numberWithInt:[dict objectForKey:key]];
            
            
            y = [NSNumber numberWithInt:[a_state objectForKey:key]];
           
            if (x!=y)
            {
                NSLog(@"Returning NO");
                return NO;
            }
        }
        
        NSLog(@"returning yes");
        return YES;
    }
    NSLog(@"Returning yes");
    return YES;
}
-(BOOL) BFS
{
    NSMutableArray* queue = [[NSMutableArray alloc] init];
    NSMutableArray* visited = [[NSMutableArray alloc] init];
    
    //PuzzleNode* tmpNode = [[PuzzleNode alloc] init];
    
    [queue addObject:self.currentNode];
    
    self.currentNode.visited = YES;
    [visited addObject:self.currentNode.state];
    while ( ([queue count]>0))
    {
        NSLog(@"%ld", [queue count]);
        
    PuzzleNode* tmpNode = [[PuzzleNode alloc] init];
    
        tmpNode = [queue objectAtIndex:0];
        //tmpNode.visited = YES;
        [visited addObject:[[NSDictionary alloc] initWithDictionary:tmpNode.state]];
    //    [self printCurrentState];
     //   [self printState:tmpNode.state];
        
        [queue removeObjectAtIndex:0];
        //tmpNode.visited = YES;
       // self.currentNode=tmpNode;
        
        if ([self goalTest: tmpNode])
        {
            self.currentNode = tmpNode;
            NSLog(@"Path found!");
            [self printPathToCurrentNode];
            return YES;
        }
        
        PuzzleNode* tmpTmpNode = [[PuzzleNode alloc] init];
        tmpTmpNode = [tmpTmpNode initWithState:tmpNode.state andRows:tmpNode.rows andColumns:tmpNode.columns andParent:tmpNode.parent andTileKeys:tmpNode.tileKeys andAction:tmpNode.action];
        
        for (PuzzleNode* edge in [self getAllAdjacent:tmpNode])
        {
        //NSUInteger index = [queue indexOfObject:edge];
            
            if (![self haveWeBeenHereBefore: edge.state givenHistory:visited])
            {
                
                [queue addObject:edge];
            }
        }
        
        //tmpNode.parent = self.currentNode;
        
        
        
        
        
         self.currentNode = tmpNode;
        
     //   [self printPathToCurrentNode];
    } 
    return NO;
    
}
    
@end
