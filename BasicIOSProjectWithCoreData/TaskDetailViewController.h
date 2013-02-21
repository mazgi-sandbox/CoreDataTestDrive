//
//  TaskDetailViewController.h
//  BasicIOSProjectWithCoreData
//
//  Created by Matsuki Hidenori on 2/21/13.
//  Copyright (c) 2013 Matsuki Hidenori. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaskEntity;
@interface TaskDetailViewController : UIViewController
@property (strong, nonatomic) TaskEntity *task;
@end
