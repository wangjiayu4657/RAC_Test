//
//  JYDomainModel.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYDomainModel : NSObject

/*
 {
   "ext" : ".com",
   "delete_type" : "12",
   "count" : "11",
   "name" : "76899",
   "domain" : "76899.com",
   "delete_time" : "2022-03-29"
 },
 */

/** ext */
@property (nonatomic,strong) NSString *ext;
/** 删除类型 */
@property (nonatomic,strong) NSString *delete_type;
/** 数量 */
@property (nonatomic,strong) NSString *count;
/** 名称 */
@property (nonatomic,strong) NSString *name;
/** 域名 */
@property (nonatomic,strong) NSString *domain;
/** 删除时间 */
@property (nonatomic,strong) NSString *delete_time;

@end

NS_ASSUME_NONNULL_END
