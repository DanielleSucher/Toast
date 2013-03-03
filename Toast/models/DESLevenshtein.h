//
//  DESLevenshtein.h
//  Toast
//
//  Created by Danielle Sucher on 3/2/13.
//  Copyright (c) 2013 Danielle Sucher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESLevenshtein : NSObject

@property (strong, nonatomic) NSString *stringOne;
@property (strong, nonatomic) NSString *stringTwo;

@property (readonly, nonatomic) NSMutableArray *editGrid;
@property (readonly, nonatomic) NSNumber *editDistance;

@end
