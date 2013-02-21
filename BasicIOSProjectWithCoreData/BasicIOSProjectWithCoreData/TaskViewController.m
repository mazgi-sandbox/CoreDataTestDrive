//
//  TaskViewController.m
//  BasicIOSProjectWithCoreData
//
//  Created by MATSUKI Hidenori on 2/19/13.
//  Copyright (c) 2013 Matsuki Hidenori. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskEntity+Control.h"
#import "TaskDetailViewController.h"
#import "AppDelegate.h"

@interface TaskViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
- (IBAction)editBarButtonItemDidSelect:(id)sender;
- (IBAction)addBarButtonItemDidSelect:(id)sender;
#pragma mark - Data
@property (strong, nonatomic) NSArray *tasks;
@end

@implementation TaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tasks = [TaskEntity all];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [TaskEntity setupTemplates];
    [[TaskEntity fetchTasksWhereTitleLike:@"a"]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSLog(@"%02d:%@", idx, [(TaskEntity *)obj title]);
    }];
    [[TaskEntity fetchTasksWithTemplateWhereTitleLike:@"a"]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSLog(@"%02d:%@", idx, [(TaskEntity *)obj title]);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Events

- (IBAction)editBarButtonItemDidSelect:(id)sender {
    self.tableView.editing = !self.tableView.editing;
}

- (IBAction)addBarButtonItemDidSelect:(id)sender {
    TaskDetailViewController *taskDetailViewController = [[TaskDetailViewController alloc]initWithNibName:nil bundle:nil];
    UINavigationController *taskNavigationViewController = [[UINavigationController alloc]initWithRootViewController:taskDetailViewController];
    [self presentViewController:taskNavigationViewController animated:YES completion:^{}];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    TaskEntity *task = [self.tasks objectAtIndex:indexPath.row];
    cell.textLabel.text = task.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
        {
            AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
            TaskEntity *entity = [self.tasks objectAtIndex:[indexPath row]];
            [appDelegate.managedObjectContext deleteObject:entity];
            [appDelegate saveContext];
            self.tasks = [TaskEntity all];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationAutomatic];
            if ([self.tasks count] == 0) {
                self.tableView.editing = NO;
            }
        }
            break;
        case UITableViewCellEditingStyleInsert:
        case UITableViewCellEditingStyleNone:
        default:
            //do nothing
            NSLog(@"editingstyle[%d]", editingStyle);
            break;
    }
}

@end
