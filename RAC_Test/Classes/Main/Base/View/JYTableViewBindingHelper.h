//
//  JYTableViewBindingHelper.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYTableViewBindingHelper : NSObject

@property (nonatomic,weak) id<UITableViewDelegate> delegate;

/** 刷新列表信号 */
@property (nonatomic,strong) RACSignal *reloadSignal;

/// 代码创建cell时调用
/// @param tableView tableView
/// @param source 数据源信号
/// @param didSelectCommand cell选中时的信号
/// @param templateCell cell的类名
/// @param viewModel 视图模型
/// @return 配置好的tableView

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
														sourceSignale:(RACSignal *)source
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand
                             templateCell:(NSString *)templateCell
                            withViewModel:(id _Nullable)viewModel;


/// 代码创建cell时调用
/// @param tableView tableView
/// @param source 数据源信号
/// @param didSelectCommand cell选中时的信号
/// @param templateCell nib的类名
/// @param viewModel 视图模型
/// @return 配置好的tableView

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                            sourceSignale:(RACSignal *)source
                         selectionCommand:(RACCommand *_Nullable)didSelectCommand
                      templateCellWithNib:(NSString *)templateCell
                            withViewModel:(id _Nullable)viewModel;



@end

NS_ASSUME_NONNULL_END
