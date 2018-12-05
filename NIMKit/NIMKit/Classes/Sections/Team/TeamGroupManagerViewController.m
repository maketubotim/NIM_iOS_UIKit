//
//  TeamGroupManagerViewController.m
//  BusinessCardProject
//
//  Created by 鼎耀 on 2018/12/5.
//  Copyright © 2018 Linyoung. All rights reserved.
//

#import "TeamGroupManagerViewController.h"
#import "NIMCommonTableData.h"
#import "NIMCommonTableDelegate.h"
#import "NIMContactSelectViewController.h"
#import "UIView+Toast.h"

@interface TeamGroupManagerViewController ()<NIMContactSelectDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) NIMCommonTableDelegate *delegator;

@end

@implementation TeamGroupManagerViewController

- (void)viewDidLayoutSubviews {
    if (@available(iOS 11.0, *)) {
        CGFloat height = self.view.safeAreaInsets.bottom;
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - height);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"群管理";
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildData];
    __weak typeof(self) wself = self;
    self.delegator = [[NIMCommonTableDelegate alloc] initWithTableData:^NSArray *{
        return wself.data;
    }];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.delegate   = self.delegator;
    self.tableView.dataSource = self.delegator;
    
}

- (void)buildData{
   
    NIMTeamJoinMode teamJoinMode = self.team.joinMode;
    NSArray *data = @[
                      @{
                          HeaderTitle:@"",
                          RowContent :@[
                                  @{
                                      Title        : @"群邀请请确认",
                                      CellClass    : @"NTESSettingSwitcherCell",
                                      ExtraInfo    : @(teamJoinMode == NIMTeamJoinModeNeedAuth? YES : NO),
                                      CellAction   : @"onActionNeedManagerAllowSetting:",
                                      ForbidSelect : @(YES)
                                      },
                                  ],
                          FooterTitle:@"启用后,群成员需群主确认才能邀请朋友进群,扫描二维码进群将同时停用。"
                          },
                      @{
                          HeaderTitle:@"",
                          RowContent :@[
                                  @{
                                      Title         : @"群主管理权转让",
                                      CellAction    : @"onTransferGroup:",
                                      ShowAccessory : @(YES),
                                      },
                                  ],
                          },
                      ];
    self.data = [NIMCommonTableSection sectionsWithData:data];
}

- (void)onActionNeedManagerAllowSetting:(UISwitch *)switcher
{
    NIMTeamJoinMode teamJoinMode;
    if (switcher.isOn) teamJoinMode = NIMTeamJoinModeNeedAuth;
    else teamJoinMode = NIMTeamJoinModeNoAuth;
    __weak typeof(self) wself = self;
    [[NIMSDK sharedSDK].teamManager updateTeamJoinMode:teamJoinMode teamId:self.team.teamId completion:^(NSError *error) {
        if (!error) {
            self.team.joinMode = teamJoinMode;
            [wself.view makeToast:@"修改成功" duration:2.0 position:CSToastPositionCenter];
        }else{
            [self.view makeToast:[NSString stringWithFormat:@"修改失败 code:%zd",error.code] duration:2.0 position:CSToastPositionCenter];
        }
    }];
}
- (void)onTransferGroup:(id)sender{
    
    __weak typeof(self) wself = self;
    __block ContactSelectFinishBlock finishBlock =  ^(NSArray * memeber){
        [[NIMSDK sharedSDK].teamManager transferManagerWithTeam:wself.team.teamId newOwnerId:memeber.firstObject isLeave:NO completion:^(NSError *error) {
            if (!error) {
                [wself.view makeToast:@"转移成功！" duration:2.0 position:CSToastPositionCenter];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
                    [wself.navigationController popViewControllerAnimated:YES];
                });
            }else{
                [wself.view makeToast:[NSString stringWithFormat:@"转移失败！code:%zd",error.code] duration:2.0 position:CSToastPositionCenter];
            }
        }];
    };
    
    NSString *currentUserID = [[[NIMSDK sharedSDK] loginManager] currentAccount];
    NIMContactTeamMemberSelectConfig *config = [[NIMContactTeamMemberSelectConfig alloc] init];
    config.teamId = self.team.teamId;
    config.filterIds = @[currentUserID];
    NIMContactSelectViewController *vc = [[NIMContactSelectViewController alloc] initWithConfig:config];
    vc.finshBlock = finishBlock;
    [vc show];
    
}



@end
