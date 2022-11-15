//
//  JYReactiveView.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/30.
//

#import<Foundation/Foundation.h>


@protocol JYReactiveViewDelegate <NSObject>

@optional

/// 绑定一个model给cell
/// @param model 需要绑定的model类
- (void)bindModel:(id)model;


/// 绑定一个model给cell 并附带参数
/// @param model 需要绑定的model类
/// @param params 需要附带的参数
- (void)bindModel:(id)model withParam:(NSDictionary *)params;


/// 绑定一个model和viewModel给cell 并附带参数,绑定viewModel是为了cell中执行的数据操作可以直接通过viewModel实现
/// @param viewModel 需要绑定的viewModel
/// @param model 需要绑定model
/// @param params 需要附带的参数
- (void)bindViewModel:(id)viewModel model:(id)model withParam:(NSDictionary *)params;

@end
