//
//  JYRecommendedView.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/29.
//

#import "BaseView.h"
@class JYDomainModel;

NS_ASSUME_NONNULL_BEGIN

@interface JYRecommendedView : UIView

/** 域名数据源信号 */
@property (nonatomic,strong) RACSignal *domainSignal;

@end

NS_ASSUME_NONNULL_END
