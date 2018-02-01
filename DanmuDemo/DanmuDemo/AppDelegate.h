//
//  AppDelegate.h
//  DanmuDemo
//
//  Created by lalala on 2018/2/1.
//  Copyright © 2018年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

