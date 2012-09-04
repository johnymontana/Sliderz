//
//  Problem.m
//  Sliderz
//
//  Created by lyonwj on 8/29/12.
//  Copyright (c) 2012 lyonwj. All rights reserved.
//

#import "Problem.h"

@implementation Problem
@synthesize  algoCode, heuristic, outputLevel, columns, rows, tileKeys, zeroKey, zeroIsOnLeft, zeroIsOnRight, headNode;

-(NSNumber*) zeroKey
{
    NSArray* zeroPosition = [self.state allKeysForObject:[NSNumber numberWithInt:0]];
    zeroKey = [zeroPosition objectAtIndex:0];
    return [zeroPosition objectAtIndex:0];
}

-(BOOL) zeroIsOnLeft
{
    NSLog(@"Zero position from zeroIsOnLeft method: %i", [self.zeroKey intValue]);
    NSLog(@"zeroKey mod columns=:%i", [self.zeroKey intValue]%self.columns);
    if ([self.zeroKey intValue]%self.columns==0)
    {
        zeroIsOnLeft = YES;
        return YES;
    }
        
    else
    {
        zeroIsOnLeft = NO;
        return NO;
    }
        
}

-(BOOL) zeroIsOnRight
{
    if ([self.zeroKey intValue]%self.columns==self.rows)
        return YES;
    else
        return NO;
}


-(Problem*) initWithFile: (NSString*) fileName andColumns: (int) a_cols andRows: (int) a_rows
{
    
    self.rows=a_rows;
    self.columns = a_cols;
    
    int myInt = 0;
    NSArray* tileArray = [NSArray alloc];
    NSMutableArray* keyArray = [[NSMutableArray alloc] init];
   
    
    
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

    self.state = [[NSMutableDictionary alloc] initWithObjects:tileArray forKeys:keyArray];
    self.tileKeys = keyArray;
    return self;
}

-(void) printCurrentState
{
    //NSEnumerator *enumerator = [state keyEnumerator];
    NSArray* keys = [state allKeys];
    
   printf("PRINT STATE:\n");
    
  //  printf("objectForKey 2: %i", [[state objectForKey:[NSNumber numberWithInt:2]] intValue]);
    
    for (int i=0; i<[self.tileKeys count]; i++)
    {
        
        
    //    NSLog(@"KEYS: %i", [[keys objectAtIndex:i] intValue]);
    
    //    printf("enumerating dictionary\n");
        printf("%i ", [[state objectForKey:[self.tileKeys objectAtIndex:i]] intValue]);
        
               
        
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
    
    if ([self.tileKeys containsObject:[NSNumber numberWithInt:([self.zeroKey intValue]+self.columns)]])
    {
        [moves addObject:[NSString stringWithFormat:@"D"]];
        NSLog(@"Down move new zero key:%i", [[NSNumber numberWithInt:([self.zeroKey intValue]+self.columns)] intValue]);
    }
    
    NSLog(@"Up move new zero key:%i", [[NSNumber numberWithInt:([self.zeroKey intValue]-self.columns)] intValue]);
    
    if ([self.tileKeys containsObject:[NSNumber numberWithInt:([self.zeroKey intValue]-self.columns)]])
    {
        
        [moves addObject:[NSString stringWithFormat:@"U"]];
    }
    
    if ([self.tileKeys containsObject:[NSNumber numberWithInt:([self.zeroKey intValue]+1)]] && !self.zeroIsOnRight)
    {
        
        [moves addObject:[NSString stringWithFormat:@"R"]];
    }
    
    if ([self.tileKeys containsObject:[NSNumber numberWithInt:([self.zeroKey intValue]-1)]] && !self.zeroIsOnLeft)
    {
        
        [moves addObject:[NSString stringWithFormat:@"L"]];
    }


    return moves;
    
}
    
@end
