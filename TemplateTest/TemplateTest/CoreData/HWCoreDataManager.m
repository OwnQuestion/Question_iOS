//
//  HWCoreDataManager.m
//  Template-OC
//
//  Created by niedi on 15/4/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWCoreDataManager.h"
#import "AppDelegate.h"

@implementation HWCoreDataManager

+ (BOOL)saveContext:(NSManagedObjectContext *)context
{
    AppDelegate* delegate = SHARED_APP_DELEGATE;
    
    [context performBlock:^{
        
        [context save:nil];
        [delegate.managedObjectContext performBlock:^{
            NSError* error;
            if (![delegate.managedObjectContext save:&error])
            {
                NSLog(@"error is %@",error);
            }
        }];
        
    }];
    
    return YES;
}

+ (void)deleteAllDate:(NSString *)tableName
{
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSManagedObjectContext* context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects != nil)
    {
        for (NSManagedObject * obj in fetchedObjects) {
            
            [delegate.managedObjectContext deleteObject:obj];
        }
        
        [self saveContext:context];
    }
    else
        
    {
        NSLog(@" error:%@",error.localizedDescription);
    }
    
}


@end
