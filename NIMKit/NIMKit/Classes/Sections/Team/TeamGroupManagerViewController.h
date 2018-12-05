//
//  TeamGroupManagerViewController.h
//  BusinessCardProject
//
//  Created by 鼎耀 on 2018/12/5.
//  Copyright © 2018 Linyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NIMSDK/NIMSDK/NIMSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamGroupManagerViewController : UIViewController

@property (nullable,nonatomic,strong)  NSString *teamId;

@property(nullable,nonatomic,strong) NIMTeam *team;

@end

NS_ASSUME_NONNULL_END
