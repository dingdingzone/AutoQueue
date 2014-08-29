//
//  ShopDetailViewController.h
//  AutoQueue
//
//  Created by alone on 13-11-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueueAppDelegate.h"
#import "SlideImageView.h"
#import "BaseViewController.h"

@interface ShopDetailViewController : BaseViewController<UIAlertViewDelegate,SlideImageViewDelegate>
{
    SlideImageView* slideImageView;
    UIButton *remBtn;
}
@property (weak, nonatomic) IBOutlet UILabel *MerName;
@property (weak, nonatomic) IBOutlet UILabel *MerAveConsume;
@property (weak, nonatomic) IBOutlet UILabel *MerType;
@property (weak, nonatomic) IBOutlet UILabel *MerCount;
@property (weak, nonatomic) IBOutlet UILabel *MerAddr;
@property (weak, nonatomic) IBOutlet UILabel *MerPhone;
@property (weak, nonatomic) IBOutlet UILabel *MerDiscount;
@property (weak, nonatomic) IBOutlet UILabel *MerDisc;
@property (weak, nonatomic) IBOutlet UILabel *MerTime;
@property (weak, nonatomic) IBOutlet UIImageView *MerPicImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewArea;


@property (nonatomic,retain) QueueAppDelegate * myDelegate;

@property (nonatomic, strong) NSString *MerId;

- (IBAction)getNumClick:(id)sender;


@end
