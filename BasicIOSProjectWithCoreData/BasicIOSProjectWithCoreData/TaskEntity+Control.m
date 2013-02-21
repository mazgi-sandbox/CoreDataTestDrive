//
//  Task+Control.m
//  BasicIOSProjectWithCoreData
//
//  Created by MATSUKI Hidenori on 2/19/13.
//  Copyright (c) 2013 Matsuki Hidenori. All rights reserved.
//

#import "TaskEntity+Control.h"
#import "AppDelegate.h"

@implementation TaskEntity (Control)
+ (NSArray *)all
{
    // build fetch request
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:
                                [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES],
                                nil];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    // execute query
    NSManagedObjectContext *context = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                                managedObjectContext:context
                                                                                  sectionNameKeyPath:nil
                                                                                           cacheName:nil];
    NSError *error = nil;
    BOOL success = [controller performFetch:&error];
    NSLog(@"success[%d], error[%@]", success, error);
    return controller.fetchedObjects;
}

+ (NSArray *)allWithTemplate
{
    // build fetch request
    NSManagedObjectModel *managedObjectModel = [(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectModel];
    NSFetchRequest *fetchRequest = [managedObjectModel fetchRequestTemplateForName:@"AllTasks"];

    // execute query
    NSManagedObjectContext *context = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                                managedObjectContext:context
                                                                                  sectionNameKeyPath:nil
                                                                                           cacheName:nil];
    NSError *error = nil;
    BOOL success = [controller performFetch:&error];
    NSLog(@"success[%d], error[%@]", success, error);
    return controller.fetchedObjects;
}

+ (NSArray *)fetchTasksWhereTitleLike:(NSString *)variable
{
    // build fetch request
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"title CONTAINS %@", variable, nil];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:
                                [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES],
                                nil];
    fetchRequest.sortDescriptors = sortDescriptors;
    NSLog(@"fetchRequest: %@", fetchRequest);
    
    // execute query
    NSManagedObjectContext *context = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                                managedObjectContext:context
                                                                                  sectionNameKeyPath:nil
                                                                                           cacheName:nil];
    NSError *error = nil;
    BOOL success = [controller performFetch:&error];
    NSLog(@"success[%d], error[%@]", success, error);
    return controller.fetchedObjects;
}

+ (NSArray *)fetchTasksWithTemplateWhereTitleLike:(NSString *)variable
{
    // build fetch request
    NSManagedObjectModel *managedObjectModel = [(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectModel];
    NSDictionary *substitutes = [NSDictionary dictionaryWithObjectsAndKeys:variable, @"CONTAINS_TITLE", nil];
    NSFetchRequest *fetchRequest = [managedObjectModel fetchRequestFromTemplateWithName:@"TasksWhereTitleLike"
                                                                  substitutionVariables:substitutes];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:
                                [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES],
                                nil];
    fetchRequest.sortDescriptors = sortDescriptors;
    NSLog(@"fetchRequest: %@", fetchRequest);
    
    // execute query
    NSManagedObjectContext *context = ((AppDelegate *)([UIApplication sharedApplication].delegate)).managedObjectContext;
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                                managedObjectContext:context
                                                                                  sectionNameKeyPath:nil
                                                                                           cacheName:nil];
    NSError *error = nil;
    BOOL success = [controller performFetch:&error];
    NSLog(@"success[%d], error[%@]", success, error);
    return controller.fetchedObjects;
}

+ (void)setupTemplates
{
    NSManagedObjectModel *managedObjectModel = [(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectModel];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // copy fetch request
        NSFetchRequest *allTasks = [managedObjectModel fetchRequestTemplateForName:@"AllTasks"];
        NSFetchRequest *orderedAllTasks = [allTasks copy];
        NSArray *sortDescriptors = [NSArray arrayWithObjects:
                                    [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES],
                                    nil];
        [orderedAllTasks setSortDescriptors:sortDescriptors];
        [managedObjectModel setFetchRequestTemplate:orderedAllTasks forName:@"orderedAllTasks"];
    });
    
    // show all fetch requests
    NSDictionary *requests = [managedObjectModel fetchRequestTemplatesByName];
    [requests enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop){
        NSLog(@"\nkey: %@, \nvalue: %@", key, value);
    }];
}
@end
