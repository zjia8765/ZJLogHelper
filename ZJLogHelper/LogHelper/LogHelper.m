//
//  LogHelper.m
//  ZJLogHelper
//
//  Created by zhangjia on 16/2/4.
//
//

#import "LogHelper.h"
#import "Aspects.h"
#import <UIKit/UIKit.h>
#import "StatisticsProfile.h"

typedef void (^AspectHandlerBlock)(id<AspectInfo> aspectInfo);


@implementation LogHelper

+(void)setupWithConfiguration
{
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                       withOptions:AspectPositionAfter
                        usingBlock:^(id<AspectInfo> aspectInfo) {
                            NSLog(@"%@: %@", aspectInfo.instance, aspectInfo.arguments);
                            
                        }error:NULL];
    
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   NSLog(@"%@: %@", aspectInfo.instance, aspectInfo.arguments);
                                   
                               }error:NULL];
    
    
    [UIControl aspect_hookSelector:@selector(sendAction:to:forEvent:)
                       withOptions:AspectPositionAfter
                        usingBlock:^(id<AspectInfo> aspectInfo,SEL action,id target, UIEvent * events) {
                            NSLog(@"%@: %@", aspectInfo.instance, aspectInfo.arguments);
                            NSString* ctrString = NSStringFromClass([target class]);
                            NSString* targetString = NSStringFromClass([aspectInfo.instance class]);
                            NSString* selecterString = NSStringFromSelector(action);
                            
                            NSLog(@"%@----%@---%@",ctrString,targetString,selecterString);
                            
                            NSDictionary *comfigFile = [StatisticsProfile sharedInstance].loggingConfig;
                            NSDictionary *ctrConfigDic = comfigFile[ctrString][selecterString];
                            if (ctrConfigDic) {
                                NSNumber *logtype = ctrConfigDic[LoggingEventType];
                                if (logtype.integerValue == 0) {
                                    NSLog(@"%@",ctrConfigDic[LoggingEventName]);
                                }else if (logtype.integerValue == 1){
                                    AspectHandlerBlock eventblock = ctrConfigDic[LoggingEventHandlerBlock];
                                    eventblock(aspectInfo);
                                }
                            }
                            
                        }error:NULL];
    
    
    [UIScrollView aspect_hookSelector:@selector(setDelegate:)
                       withOptions:AspectPositionAfter
                        usingBlock:^(id<AspectInfo> aspectInfo,id target) {
                            NSLog(@"%@: %@", aspectInfo.instance, aspectInfo.arguments);
                            
                            if ([aspectInfo.instance isKindOfClass:[UITableView class]]) {
                                [target aspect_hookSelector:@selector(tableView:didSelectRowAtIndexPath:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo,UITableView* tableView, NSIndexPath* indexPath){
                                    NSLog(@"%@: %@", aspectInfo.instance, aspectInfo.arguments);
                                    
                                    NSString* ctrString = NSStringFromClass([aspectInfo.instance class]);
                                    NSLog(@"----%@----",ctrString);
                                    
                                    NSDictionary *comfigFile = [StatisticsProfile sharedInstance].loggingConfig;
                                    NSDictionary *ctrConfigDic = comfigFile[ctrString][LogTableViewDidSelect];
                                    if (ctrConfigDic) {
                                        NSNumber *logtype = ctrConfigDic[LoggingEventType];
                                        if (logtype.integerValue == 0) {
                                            NSLog(@"%@",ctrConfigDic[LoggingEventName]);
                                        }else if (logtype.integerValue == 1){
                                            AspectHandlerBlock eventblock = ctrConfigDic[LoggingEventHandlerBlock];
                                            eventblock(aspectInfo);
                                        }
                                    }
                                }error:NULL];
                            } else if ([aspectInfo.instance isKindOfClass:[UICollectionView class]]){
                                [target aspect_hookSelector:@selector(collectionView:didSelectItemAtIndexPath:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo,UITableView* tableView, NSIndexPath* indexPath){
                                    NSLog(@"%@: %@", aspectInfo.instance, aspectInfo.arguments);
                                    
                                    NSString* ctrString = NSStringFromClass([aspectInfo.instance class]);
                                    NSLog(@"----%@----",ctrString);
                                    
                                    NSDictionary *comfigFile = [StatisticsProfile sharedInstance].loggingConfig;
                                    NSDictionary *ctrConfigDic = comfigFile[ctrString][LogTableViewDidSelect];
                                    if (ctrConfigDic) {
                                        NSNumber *logtype = ctrConfigDic[LoggingEventType];
                                        if (logtype.integerValue == 0) {
                                            NSLog(@"%@",ctrConfigDic[LoggingEventName]);
                                        }else if (logtype.integerValue == 1){
                                            AspectHandlerBlock eventblock = ctrConfigDic[LoggingEventHandlerBlock];
                                            eventblock(aspectInfo);
                                        }
                                    }
                                }error:NULL];
                            }
    
                        }error:NULL];
    
}

+(void)setupCustomWithConfiguration
{
    NSDictionary *comfigFile = [StatisticsProfile sharedInstance].loggingConfigWithCustom;
    for (NSString *className in [comfigFile allKeys]) {
        Class clazz = NSClassFromString(className);
        NSArray *eventArray = comfigFile[className];
        
            for (NSDictionary *event in eventArray) {
                SEL selekor = NSSelectorFromString(event[LoggingEventSelect]);
                AspectHandlerBlock block = event[LoggingEventHandlerBlock];
                
                [clazz aspect_hookSelector:selekor
                               withOptions:AspectPositionAfter
                                usingBlock:^(id<AspectInfo> aspectInfo) {
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                        block(aspectInfo);
                                    });
                                } error:NULL];
                
            }
    }
}
@end
