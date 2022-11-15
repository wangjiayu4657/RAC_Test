//
//  JYBannerModel.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYBannerModel : NSObject
/** 链接地址 */
@property (nonatomic,strong) NSString *link;
/** banner图片地址 */
@property (nonatomic,strong) NSString *src;
/** 标题 */
@property (nonatomic,strong) NSString *title;
@end

NS_ASSUME_NONNULL_END
