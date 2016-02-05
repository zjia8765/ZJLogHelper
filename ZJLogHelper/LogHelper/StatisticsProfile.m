//
//  StatisticsProfile.m
//  ZJLogHelper
//
//  Created by zhangjia on 16/2/4.
//
//

#import "StatisticsProfile.h"
#import "Aspects.h"

@implementation StatisticsProfile

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = self.new;
    });
    return instance;
}

- (NSDictionary*)loggingConfig
{
    if (!_loggingConfig) {
        NSDictionary *configDic = @{
                                    @"MainViewController": @{
                                            @"settingBtnAction:": @{
                                                    LoggingEventType:@"0",
                                                    LoggingEventName:@"setting button clicked"
                                                    
                                                    },
                                            @"userInfoBtnAction:": @{
                                                    LoggingEventType:@"1",
                                                    LoggingEventHandlerBlock:^(id<AspectInfo> aspectInfo) {
                                                        NSLog(@"user info clicked");
                                                    }
                                                    },
                                            LogTableViewDidSelect: @{
                                                    LoggingEventType:@"0",
                                                    LoggingEventName:@"tableView didclicked"
                                                    }
                                            },
                                    
                                    @"DetailViewController": @{
                                            LogTableViewDidSelect: @{
                                                    LoggingEventType:@"1",
                                                    LoggingEventHandlerBlock:^(id<AspectInfo> aspectInfo) {
                                                        NSLog(@"tableView didclicked");
                                                    }
                                                    }
                                            }
                                    };
        
        _loggingConfig = configDic;
    }
    return _loggingConfig;
}

- (NSDictionary*)loggingConfigWithCustom
{
    if (!_loggingConfigWithCustom) {
        NSDictionary *configDic = @{
                                    @"MainViewController": @[
                                            @{
                                                LoggingEventSelect:@"settingBtnAction:",
                                                LoggingEventName:@"setting button clicked",
                                                LoggingEventHandlerBlock:^(id<AspectInfo> aspectInfo) {
                                                    NSLog(@"setting button clicked");
                                                }
                                                },
                                            @{
                                                LoggingEventSelect:@"userInfoBtnAction:",
                                                LoggingEventName:@"userinfo button clicked",
                                                LoggingEventHandlerBlock:^(id<AspectInfo> aspectInfo) {
                                                    NSLog(@"userinfo button clicked");
                                                }
                                                }
                                            ],
                                    
                                    @"DetailViewController": @[
                                            @{
                                                LoggingEventSelect:@"tableView:didSelectRowAtIndexPath:",
                                                LoggingEventName:@"tableView didclicked",
                                                LoggingEventHandlerBlock:^(id<AspectInfo> aspectInfo) {
                                                    NSLog(@"tableView didclicked");
                                                }
                                                }
                                            ]
                                    };
        
        _loggingConfigWithCustom = configDic;
    }
    return _loggingConfigWithCustom;
}
@end
