//
//  JYOptionModel.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/1.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

/*
 "name":"预订设置",
 "image":"apply_ydset",
 "target":"PlatformTypeViewController",
 "section":1,
 "item":0,
 "selected":0
 */

@interface JYOptionModel : BaseModel

/** 名称 */
@property (nonatomic,strong) NSString *name;
/** 图标 */
@property (nonatomic,strong) NSString *image;
/** 目标控制器 */
@property (nonatomic,strong) NSString *target;
/** section */
@property (nonatomic,assign) int section;
/** item */
@property (nonatomic,assign) int item;
/** 是否选中 */
@property (nonatomic,assign) BOOL selected;

//额外字段
/** 状态图标 */
@property (nonatomic,strong) UIImage *icon;

@end

NS_ASSUME_NONNULL_END
