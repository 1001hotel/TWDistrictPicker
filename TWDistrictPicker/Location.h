//
//  Location.h
//  MicroFinance
//
//  Created by passwordis123 on 11/19/14.
//  Copyright (c) 2014 SPMach. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Location : NSObject


@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *district;
@property (copy, nonatomic) NSString *street;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;


@end
