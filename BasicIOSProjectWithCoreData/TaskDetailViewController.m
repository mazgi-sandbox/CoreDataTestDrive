//
//  TaskDetailViewController.m
//  BasicIOSProjectWithCoreData
//
//  Created by Matsuki Hidenori on 2/21/13.
//  Copyright (c) 2013 Matsuki Hidenori. All rights reserved.
//

#import "TaskDetailViewController.h"
#import "TaskEntity+Control.h"
#import "AppDelegate.h"

@interface TaskDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
- (IBAction)doneButtonDidTouchUpInside:(id)sender;
@end

@implementation TaskDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.task) {
        NSManagedObjectContext *context = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([TaskEntity class]) inManagedObjectContext:context];
        self.task = [[TaskEntity alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:nil];
    }
    self.titleTextField.text = self.task.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Events

- (IBAction)doneButtonDidTouchUpInside:(id)sender {
    self.task.title = self.titleTextField.text;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.managedObjectContext insertObject:self.task];
    [appDelegate saveContext];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
