//
//  JYAlertView.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/6.
//

#import "BaseView.h"


NS_ASSUME_NONNULL_BEGIN


@interface JYAlertView : BaseView

/// 弹窗
/// @param content 需要显示的内容
/// @param callBack 回调函数
+ (void)showAlertContent:(NSString *)content callBack:(void (^)(void))callBack;

/// 弹窗
/// @param title 需要显示的标题
/// @param content 需要显示的内容
/// @param callBack 回调函数
+ (void)showAlertTitle:(NSString *)title content:(NSString *)content callBack:(void (^)(void))callBack;

/// 弹窗
/// @param title 需要显示的标题
/// @param content 需要显示的内容
/// @param actionNames 按钮标题个数
/// @param callBack 回调函数
+ (void)showAlertTitle:(NSString *)title content:(NSString *)content actionNames:(NSArray<NSString *> *)actionNames callBack:(void (^)(void))callBack;


@end

NS_ASSUME_NONNULL_END
