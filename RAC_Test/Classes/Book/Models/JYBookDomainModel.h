//
//  JYBookDomainModel.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYBookDomainModel : NSObject

/** 域名 */
@property (nonatomic,strong) NSString *domain;
/** 最低价格 */
@property (nonatomic,strong) NSString *price;
/** 删除日期 */
@property (nonatomic,strong) NSString *delete_time_msg;
/** 删除类型 */
@property (nonatomic,strong) NSString *delete_type_value;

/* 添加额外字段 */

/** 按钮状态选择图标 */
@property (nonatomic,strong) UIImage *icon;
/** 是否选中 */
@property (nonatomic,assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
