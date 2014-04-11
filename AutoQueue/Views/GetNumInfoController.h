//
//  GetNumInfoController.h
//  AutoQueue
//
//  Created by leo on 13-12-19.
//  Copyright (c) 2013年 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetNumInfoController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *queueSeqTxt;
@property (weak, nonatomic) IBOutlet UILabel *queueCountTxt;

@property (strong, nonatomic) NSString *merchantId;
@property (strong, nonatomic) NSString *queueSeq;
@property (strong, nonatomic) NSString *queueCount;
@property (strong, nonatomic) NSString *queueId;

@end
