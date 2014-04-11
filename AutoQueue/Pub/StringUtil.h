//
//  StringUtil.h
//  AutoQueue
//
//  Created by leo on 13-12-2.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

+ (bool) isNullString:(NSString *)arg,...;

+ (void) tipsInfo:(NSString *)title :(NSString *)content;

+ (UIActivityIndicatorView *) loading:(UIViewController *)viewController;

+ (bool) checkIsNumber:(NSString *)numStr;

+(void)getImageView:(NSString *)url :(UIImageView *)imageView;

+(void)loadImage:(NSMutableArray *)arr;

+(void)showPickView:(NSString *)title :(NSMutableArray *)dataArr delegate:(UIViewController *)view;

+(bool)validatePhoneNum:(NSString *)phoneNum;

@end
