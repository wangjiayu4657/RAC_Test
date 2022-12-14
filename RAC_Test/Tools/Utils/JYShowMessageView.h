//
//  JYShowMessageView.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYShowMessageView : NSObject

/**
 *  展示错误信息
 *
 *  @param message 信息内容
 */
+ (void)showErrorWithMessage:(NSString *)message;
/**
 *  展示成功信息
 *
 *  @param message 信息内容
 */
+ (void)showSuccessWithMessage:(NSString *)message;
/**
 *  展示提交状态
 *
 *  @param message 信息内容
 */
+ (void)showStatusWithMessage:(NSString *)message;
/**
 *  隐藏弹出框
 */
+ (void)dismissSuccessView:(NSString *)message;
+ (void)dismissErrorView:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
