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

-(NSMutableArray*) getAllLegalMoves
{
    NSMutableArray* moves = [[NSMutableArray alloc] init];
    
    // NSArray containsObject: on tileKeys to determine if the move stays on the board
    // how to find the zero to start determining moves?
    
   // if (zeroPosition-columns) is contained in self.tileKeys then add "U" to moves array
    
    if ([currentNode.tileKeys containsObject:[NSNumber numberWithInt:([currentNode.zeroKey intValue]+currentNode.columns)]])
    {
        [moves addObject:[NSString stringWithFormat:@"D"]];
        NSLog(@"Down move new zero key:%i", [[NSNumber numberWithInt:([currentNode.zeroKey intValue]+currentNode.columns)] intValue]);
    }
    
    NSLog(@"Up move new zero key:%i", [[NSNumber numberWithInt:([currentNode.zeroKey intValue]-currentNode.columns)] intValue]);
    
    if ([currentNode.tileKeys containsObject:[NSNumber numberWithInt:([currentNode.zeroKey intValue]-currentNode.columns)]])
    {
        
        [moves addObject:[NSString stringWithFormat:@"U"]];
    }
    
    if ([currentNode.tileKeys containsObject:[NSNumber numberWithInt:([currentNode.zeroKey intValue]+1)]] && !currentNode.zeroIsOnRight)
    {
        
        [moves addObject:[NSString stringWithFormat:@"R"]];
    }
    
    if ([currentNode.tileKeys containsObject:[NSNumber numberWithInt:([currentNode.zeroKey intValue]-1)]] && !currentNode.zeroIsOnLeft)
    {
        
        [moves addObject:[NSString stringWithFormat:@"L"]];
    }


    return moves;
    
}

-(PuzzleNode*) resultOfAction:(NSString *)a_action
{
    
    NSMutableDictionary* tmpState = [[NSMutableDictionary alloc] init];
    tmpState = self.currentNode.state;
    NSNumber *tmpOldZero;
    PuzzleNode* newNode = [[PuzzleNode alloc] init];
    int currentZeroKey = [self.currentNode.zeroKey intValue];
    
    tmpOldZero = [self.currentNode.state objectForKey:self.currentNode.zeroKey];
    
    if (a_action==@"D")
    {
        // swap state[zeroKey] with state[zeroKey+columns]
        NSNumber *tmpNewZero = [self.currentNode.state objectForKey:[NSNumber numberWithInt:(currentZeroKey+self.columns)]];
        
        [tmpState removeObjectForKey:self.currentNode.zeroKey];
        [tmpState removeObjectForKey:[NSNumber numberWithInt:(currentZeroKey+self.columns)]];
        
        [tmpState setObject:tmpNewZero forKey:[NSNumber numberWithInt:currentZeroKey]];
                                                                                                                   
        [tmpState setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInt:(currentZeroKey+self.columns)]];
        
    }
    
    
    if (a_action==@"U")
    {
        NSNumber *tmpNewZero = [self.currentNode.state objectForKey:[NSNumber numberWithInt:(currentZeroKey-self.columns)]];
        
        [tmpState removeObjectForKey:self.currentNode.zeroKey];
        [tmpState removeObjectForKey:[NSNumber numberWithInt:(currentZeroKey-self.columns)]];
        
        [tmpState setObject:tmpNewZero forKey:[NSNumber numberWithInt:currentZeroKey]];
        
        [tmpState setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInt:(currentZeroKey-self.columns)]];
    }
    
    if (a_action==@"R")
    {
        NSNumber *tmpNewZero = [self.currentNode.state objectForKey:[NSNumber numberWithInt:(currentZeroKey+1)]];
        
        [tmpState removeObjectForKey:self.currentNode.zeroKey];
        [tmpState removeObjectForKey:[NSNumber numberWithInt:(currentZeroKey+1)]];
        
        [tmpState setObject:tmpNewZero forKey:[NSNumber numberWithInt:currentZeroKey]];
        
        [tmpState setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInt:(currentZeroKey+1)]];
    }

    if (a_action==@"L")
    {
        NSNumber *tmpNewZero = [self.currentNode.state objectForKey:[NSNumber numberWithInt:(currentZeroKey-1)]];
        
        [tmpState removeObjectForKey:self.currentNode.zeroKey];
        [tmpState removeObjectForKey:[NSNumber numberWithInt:(currentZeroKey-1)]];
        
        [tmpState setObject:tmpNewZero forKey:[NSNumber numberWithInt:currentZeroKey]];
        
        [tmpState setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInt:(currentZeroKey-1)]];
    }
    
    
newNode = [newNode initWithState:tmpState andRows:self.rows andColumns:self.columns andParent:self.currentNode andTileKeys:self.currentNode.tileKeys andAction:a_action];

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
    [self resultOfAction:@"R"];
    [self resultOfAction:@"U"];
    [self resultOfAction:@"L"];
}

-(void) printPathToCurrentNode
{
    PuzzleNode *tmpNode;
    tmpNode = self.currentNode;
    
    do {
        NSLog(@"Path: %@", [tmpNode action]);
        tmpNode = tmpNode.parent;} while (tmpNode!=nil);
    
    
}

-(BOOL) goalTest
{
    // if key == objectForKey-1 for all entries except last
    // && last objectForKey = 0
    
    
    for (int i=0;i<[self.currentNode.tileKeys count]; i++)
    //for (NSNumber* key in self.currentNode.tileKeys)
    {
        
        if ([[self.currentNode.tileKeys objectAtIndex:i] intValue] == (self.rows*self.columns-1))
            {
                if ([[self.currentNode.state objectForKey:[self.currentNode.tileKeys objectAtIndex:i]] intValue] == 0)
                {
                    return YES;
                }
                
                else
                {
                    return FALSE;
                }
            }
        
        else if ([[self.currentNode.tileKeys objectAtIndex:i] intValue] != ([[self.currentNode.state objectForKey:[self.currentNode.tileKeys objectAtIndex:i]] intValue]-1))
        {
            return FALSE;
        }
    }
}

-(BOOL) BFS
{
    
}
    
@end
