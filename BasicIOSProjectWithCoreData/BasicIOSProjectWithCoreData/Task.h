//
//  Task.h
//  BasicIOSProjectWithCoreData
//
//  Created by MATSUKI Hidenori on 2/19/13.
//  Copyright (c) 2013 Matsuki Hidenori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * title;

@end
