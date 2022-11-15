//
//  HomeProtocol.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/25.
//

#import <Foundation/Foundation.h>

@class JYBannerModel;
@class JYDomainModel;

@protocol HomeProtocol <NSObject>

@optional

//获取首页banner视图的数据
- (RACSignal<NSArray <JYBannerModel *> *> *)requestBannerDataSignal:(NSString *)url;

//获取推荐视图数据
- (RACSignal<NSArray <JYDomainModel *> *> *)requestRecommendDataSignale:(NSString *)url;

//获取竞价视图数据
- (RACSignal<NSArray <JYDomainModel *> *> *)requestBiddingDataSignale:(NSString *)url;


@end
