//
//  JYCollectionViewBindingHelper.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYCollectionViewBindingHelper : NSObject

@property (nonatomic,weak) id<UICollectionViewDelegate> delegate;

///刷新列表
- (void)reloadData;

/// 代码创建cell时调用
/// @param collectionView collectionView
/// @param codeCell cell类名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @return 配置好的collectionView
/// @param didSelectedCommand cell选中时的信号
+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                codeCell:(Class)codeCell
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                      didSelectedCommand:(RACCommand *_Nullable)didSelectedCommand;

/// xib创建cell时调用
/// @param collectionView collectionView
/// @param nibCell cell类名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectedCommand cell选中时的信号
/// @return 配置好的collectionView
+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                 nibCell:(Class)nibCell
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         didSelectedCommand:(RACCommand *_Nullable)didSelectedCommand;

/// 代码创建cell时调用
/// @param collectionView collectionView
/// @param codeCell cell类名
/// @param sectionHeader 组头视图名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectedCommand cell选中时的信号
/// @return 配置好的collectionView
+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                codeCell:(Class)codeCell
                           sectionHeader:(Class)sectionHeader
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         selectedCommand:(RACCommand * _Nullable)didSelectedCommand;


/// xib创建cell时调用
/// @param collectionView collectionView
/// @param nibCell cell类名
/// @param nibSectionHeader 组头视图名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectedCommand cell选中时的信号
/// @return 配置好的collectionView
+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                  nibCell:(Class)nibCell
                        nibSectionHeader:(Class)nibSectionHeader
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         selectedCommand:(RACCommand * _Nullable)didSelectedCommand;

/// 代码创建cell时调用
/// @param collectionView collectionView
/// @param codeCell cell类名
/// @param sectionFooter 组尾视图名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectedCommand cell选中时的信号
/// @return 配置好的collectionView
+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                codeCell:(Class)codeCell
                           sectionFooter:(Class)sectionFooter
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         selectedCommand:(RACCommand * _Nullable)didSelectedCommand;


/// xib创建cell时调用
/// @param collectionView collectionView
/// @param nibCell cell类名
/// @param nibSectionFooter 组尾视图名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectedCommand cell选中时的信号
/// @return 配置好的collectionView
+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                  nibCell:(Class)nibCell
                        nibSectionFooter:(Class)nibSectionFooter
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         selectedCommand:(RACCommand * _Nullable)didSelectedCommand;

/// 代码创建cell时调用
/// @param collectionView collectionView
/// @param codeCell cell类名
/// @param sectionHeader 组头视图名
/// @param sectionFooter 组尾视图名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectedCommand cell选中时的信号
/// @return 配置好的collectionView
+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                codeCell:(Class)codeCell
                           sectionHeader:(Class)sectionHeader
                           sectionFooter:(Class)sectionFooter
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         selectedCommand:(RACCommand * _Nullable)didSelectedCommand;


/// xib创建cell时调用
/// @param collectionView collectionView
/// @param nibCell cell类名
/// @param nibSectionHeader 组头视图名
/// @param nibSectionFooter 组尾视图名
/// @param source 数据源信号
/// @param viewModel 视图模型
/// @param didSelectedCommand cell选中时的信号
/// @return 配置好的collectionView
+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                  nibCell:(Class)nibCell
                        nibSectionHeader:(Class)nibSectionHeader
                        nibSectionFooter:(Class)nibSectionFooter
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         selectedCommand:(RACCommand * _Nullable)didSelectedCommand;


@end

NS_ASSUME_NONNULL_END
