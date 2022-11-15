//
//  LoginInputView.h
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginInputView : BaseView

/** 是否需要隐藏右侧按钮 */
@property (nonatomic,assign) BOOL isHiddenRightBtn;
/** 获取输入框中的内容 */
@property (nonatomic,strong,readonly) NSString *text;
/** 获取输入框中的文本信号 */
@property (nonatomic,strong,readonly) RACSignal *textSignal;

///imgName:输入框左边图标  placeHolder:占位文本
- (void)initLeftImgName:(NSString *)imgName placeHolder:(NSString *)placeHolder;
@end

NS_ASSUME_NONNULL_END
