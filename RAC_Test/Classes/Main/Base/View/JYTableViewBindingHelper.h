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
/// @param codeCell cell的类名
/// @param viewModel 视图模型
/// @return 配置好的tableView
+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                             		 codeCell:(Class)codeCell
                            			 source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand;


/// 代码创建cell时调用
/// @param tableView tableView
/// @param source 数据源信号
/// @param didSelectCommand cell选中时的信号
/// @param nibCell nib的类名
/// @param viewModel 视图模型
/// @return 配置好的tableView
+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                     						  nibCell:(NSString *)nibCell
                          			   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand *_Nullable)didSelectCommand;


/// 代码创建cell时调用
/// @param tableView tableView
/// @param codeCell cell类名
/// @param sectionHeader 组头类名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectCommand cell选中时的信号
/// @return 返回配置好的
+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                 codeCell:(Class)codeCell
                            sectionHeader:(Class)sectionHeader
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand;


/// xib创建cell时调用
/// @param tableView tableView
/// @param nibCell cell 类名
/// @param nibSectionHeader 组头类名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectCommand cell选中时的信号
+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                  nibCell:(Class)nibCell
                         nibSectionHeader:(Class)nibSectionHeader
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand;


/// 代码创建cell时调用
/// @param tableView tableView
/// @param codeCell cell类名
/// @param sectionFooter 组尾类名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectCommand cell选中时的信号
/// @return 返回配置好的
+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                 codeCell:(Class)codeCell
                            sectionFooter:(Class)sectionFooter
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand;


/// xib创建cell时调用
/// @param tableView tableView
/// @param nibCell cell 类名
/// @param nibSectionFooter 组尾类名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectCommand cell选中时的信号
+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                  nibCell:(Class)nibCell
                         nibSectionFooter:(Class)nibSectionFooter
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand;


/// 代码创建cell时调用
/// @param tableView tableView
/// @param codeCell cell类名
/// @param sectionHeader 组头类名
/// @param sectionFooter 组尾类名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectCommand cell选中时的信号
/// @return 返回配置好的
+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                 codeCell:(Class)codeCell
                            sectionHeader:(Class)sectionHeader
                            sectionFooter:(Class)sectionFooter
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand;


/// xib创建cell时调用
/// @param tableView tableView
/// @param nibCell cell 类名
/// @param nibSectionHeader 组头类名
/// @param nibSectionFooter 组尾类名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectCommand cell选中时的信号
+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                  nibCell:(Class)nibCell
                         nibSectionHeader:(Class)nibSectionHeader
                         nibSectionFooter:(Class)nibSectionFooter
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand;




@end

NS_ASSUME_NONNULL_END
