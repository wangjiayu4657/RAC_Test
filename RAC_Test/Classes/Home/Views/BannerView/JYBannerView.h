//
//  JYBannerView.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/25.
//

#import <UIKit/UIKit.h>
@class JYBannerModel;


NS_ASSUME_NONNULL_BEGIN

@interface JYBannerView : UIView

/** banner图数据源信号 */
@property (nonatomic,strong) RACSignal<NSArray<JYBannerModel *> *> *imageURLSignal;



@end

NS_ASSUME_NONNULL_END
