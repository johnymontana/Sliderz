//
//  PuzzleNode.m
//  Sliderz
//
//  Created by lyonwj on 9/4/12.
//  Copyright (c) 2012 lyonwj. All rights reserved.
//

#import "PuzzleNode.h"

@implementation PuzzleNode

@synthesize columns, rows, tileKeys, zeroKey, zeroIsOnLeft, zeroIsOnRight;

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

-(PuzzleNode*) initWithState:(NSDictionary *)a_state andRows:(int)a_rows andColumns:(int)a_columns andParent:(PuzzleNode *)a_parent andTileKeys:(NSArray *)a_keys
{
    self=[super init];
    
    self.state = a_state;
    self.columns = a_columns;
    self.rows = a_rows;
    self.parent = a_parent;
    self.tileKeys = a_keys;
    
    
    
    return self;
}


@end
