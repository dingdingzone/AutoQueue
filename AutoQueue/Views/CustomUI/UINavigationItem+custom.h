//
//  UINavigationItem+custom.h
//  AutoQueue
//
//  Created by alone on 13-11-21.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (custom)

-(void) setUIBarButtonItem:(UINavigationItem*)item : (UIButton*) btn;

- (void) setUIBarButtonTitle:(UINavigationItem *)item :(NSString *)title;

@end
