//
//  TopBarViewController.h
//  AutoQueue
//
//  Created by Lapland_Alone on 14-7-1.
//  Copyright (c) 2014年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueueViewController.h"
@interface TopBarViewController : UIViewController<MainTopBarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;

@property (weak, nonatomic) IBOutlet UIImageView *topBackBtn;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UIButton *areaImg;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@end
