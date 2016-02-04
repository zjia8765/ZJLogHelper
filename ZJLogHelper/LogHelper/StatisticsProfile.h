//
//  StatisticsProfile.h
//  ZJLogHelper
//
//  Created by zhangjia on 16/2/4.
//
//

#import <Foundation/Foundation.h>

//0 or 1，0-直接获取LoggingEventName的值，并打印，1-调用LoggingEventHandlerBlock自行处理
#define LoggingEventType @"LoggingEventType"
//LoggingEventType == 0 时需要
#define LoggingEventName @"LoggingEventName"
//LoggingEventType == 1 时需要
#define LoggingEventHandlerBlock @"LoggingEventHandlerBlock"
//UITableView 点击事件
#define LogTableViewDidSelect @"LogTableViewDidSelect"
@interface StatisticsProfile : NSObject
@property (nonatomic,strong) NSDictionary *loggingConfig;
+ (instancetype)sharedInstance;

@end
