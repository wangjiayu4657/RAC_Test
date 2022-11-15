//
//  JYCollectionViewBindingHelper.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/30.
//

#import "JYCollectionViewBindingHelper.h"
#import "JYReactiveViewDelegate.h"

@interface JYCollectionViewBindingHelper()<UICollectionViewDelegate,UICollectionViewDataSource>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** 数据源 */
@property (nonatomic,strong) NSArray *sources;
/** cell选中时的信号 */
@property (nonatomic,strong) RACCommand *didSelecetdCommand;
/** 重用标识 */
@property (nonatomic,strong) NSString *cellIdentifier;
/** 重用组头标识 */
@property (nonatomic,strong) NSString *headerIdentifier;
/** 重用组尾标识 */
@property (nonatomic,strong) NSString *footerIdentifier;
/** 视图模型 */
@property (nonatomic,strong) id viewModel;
/** 是否为分组 */
@property (nonatomic,assign) BOOL isGroup;
/** 刷新信号 */
@property (nonatomic,strong) RACSignal *reloadSignal;

@end

@implementation JYCollectionViewBindingHelper

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                                  cell:(Class)cell
                         sectionHeader:(Class)sectionHeader
                         sectionFooter:(Class)sectionFooter
                                source:(RACSignal *)source
                         withViewModel:(id)viewModel
                             cellParam:(NSDictionary *)cellParam
                       selectedCommand:(RACCommand *)didSelectedCommand {
  
  if (self = [super init]) {
    self.isGroup = NO;
    self.sources = [NSArray array];
    self.collectionView = collectionView;
    self.didSelecetdCommand = didSelectedCommand;
    self.viewModel = viewModel;
    self.reloadSignal = source;
    
    @weakify(self)
    [source subscribeNext:^(id _Nullable x) {
     @strongify(self)
      self.sources = (NSArray *)x;
      [self.collectionView reloadData];
    }];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    NSString *cellType = cellParam[@"cellType"];
    self.cellIdentifier = NSStringFromClass(cell);
    
    NSString *headerType = cellParam[@"headerType"];
    self.headerIdentifier = NSStringFromClass(sectionHeader);
    
    NSString *footerType = cellParam[@"footerType"];
    self.footerIdentifier = NSStringFromClass(sectionFooter);
    
    self.isGroup = [self.headerIdentifier isNotBlank] || [self.footerIdentifier isNotBlank];
    
    if ([cellType isEqualToString:@"codeType"]) {
      [self.collectionView registerClass:cell forCellWithReuseIdentifier:self.cellIdentifier];
    } else {
      UINib *nib = [UINib nibWithNibName:_cellIdentifier bundle:nil];
      [self.collectionView registerNib:nib forCellWithReuseIdentifier:self.cellIdentifier];
    }
    
    if ([self.headerIdentifier isNotBlank]) {
      if ([headerType isEqualToString:@"codeType"]) {
        Class header = NSClassFromString(self.headerIdentifier);
        [self.collectionView registerClass:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.headerIdentifier];
      } else {
        UINib *nib = [UINib nibWithNibName:self.headerIdentifier bundle:nil];
        [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.headerIdentifier];
      }
    }
    
    if ([self.footerIdentifier isNotBlank]) {
      if ([footerType isEqualToString:@"codeType"]) {
        Class footer = NSClassFromString(self.footerIdentifier);
        [self.collectionView registerClass:footer forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:self.footerIdentifier];
      } else {
        UINib *nib = [UINib nibWithNibName:self.footerIdentifier bundle:nil];
        [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:self.footerIdentifier];
      }
    }
  }
  return self;
}

- (void)reloadData {
  @weakify(self)
  [self.reloadSignal subscribeNext:^(id _Nullable x) {
   @strongify(self)
    self.sources = (NSArray *)x;
    [self.collectionView reloadData];
  }];
}

+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                codeCell:(Class)codeCell
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                      didSelectedCommand:(RACCommand *_Nullable)didSelectedCommand {
  
  NSDictionary *cellParam = @{@"cellType":@"codeType"};
  return [[JYCollectionViewBindingHelper alloc] initWithCollectionView:collectionView
                                                                   cell:codeCell
                                                         sectionHeader:nil
                                                         sectionFooter:nil
                                                                source:source
                                                         withViewModel:viewModel
                                                             cellParam:cellParam
                                                       selectedCommand:didSelectedCommand];
  
}

+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                 nibCell:(Class)nibCell
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                      didSelectedCommand:(RACCommand *_Nullable)didSelectedCommand {
  
  NSDictionary *cellParam = @{@"cellType":@"nibType"};
  return [[JYCollectionViewBindingHelper alloc] initWithCollectionView:collectionView
                                                                  cell:nibCell
                                                         sectionHeader:nil
                                                         sectionFooter:nil
                                                                source:source
                                                         withViewModel:viewModel
                                                             cellParam:cellParam
                                                       selectedCommand:didSelectedCommand];
}

+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                codeCell:(Class)codeCell
                           sectionHeader:(Class)sectionHeader
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         selectedCommand:(RACCommand * _Nullable)didSelectedCommand {
  
  NSDictionary *cellParam = @{@"cellType":@"codeType", @"headerType":@"codeType"};
  return [[JYCollectionViewBindingHelper alloc] initWithCollectionView:collectionView
                                                                   cell:codeCell
                                                         sectionHeader:sectionHeader
                                                         sectionFooter:nil
                                                                source:source
                                                         withViewModel:viewModel
                                                             cellParam:cellParam
                                                       selectedCommand:didSelectedCommand];
  
}

+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                  nibCell:(Class)nibCell
                        nibSectionHeader:(Class)nibSectionHeader
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         selectedCommand:(RACCommand * _Nullable)didSelectedCommand {
  
  NSDictionary *cellParam = @{@"cellType":@"nibType", @"headerType":@"nibType"};
  return [[JYCollectionViewBindingHelper alloc] initWithCollectionView:collectionView
                                                                  cell:nibCell
                                                         sectionHeader:nibSectionHeader
                                                         sectionFooter:nil
                                                                source:source
                                                         withViewModel:viewModel
                                                             cellParam:cellParam
                                                       selectedCommand:didSelectedCommand];
}

+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                codeCell:(Class)codeCell
                           sectionFooter:(Class)sectionFooter
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         selectedCommand:(RACCommand * _Nullable)didSelectedCommand  {
  
  NSDictionary *cellParam = @{@"cellType":@"codeType", @"footerType":@"codeType"};
  return [[JYCollectionViewBindingHelper alloc] initWithCollectionView:collectionView
                                                                  cell:codeCell
                                                         sectionHeader:nil
                                                         sectionFooter:sectionFooter
                                                                source:source
                                                         withViewModel:viewModel
                                                             cellParam:cellParam
                                                       selectedCommand:didSelectedCommand];
  
}

+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                  nibCell:(Class)nibCell
                        nibSectionFooter:(Class)nibSectionFooter
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         selectedCommand:(RACCommand * _Nullable)didSelectedCommand  {
  
  NSDictionary *cellParam = @{@"cellType":@"nibType", @"footerType":@"nibType"};
  return [[JYCollectionViewBindingHelper alloc] initWithCollectionView:collectionView
                                                                  cell:nibCell
                                                         sectionHeader:nil
                                                         sectionFooter:nibSectionFooter
                                                                source:source
                                                         withViewModel:viewModel
                                                             cellParam:cellParam
                                                       selectedCommand:didSelectedCommand];
  
}
  
+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                codeCell:(Class)codeCell
                           sectionHeader:(Class)sectionHeader
                           sectionFooter:(Class)sectionFooter
                                  source:(RACSignal *)source
                               viewModel:(id _Nullable)viewModel
                         selectedCommand:(RACCommand * _Nullable)didSelectedCommand {
                           
  NSDictionary *cellParam = @{@"cellType":@"codeType", @"headerType":@"codeType", @"footerType":@"codeType"};
  return [[JYCollectionViewBindingHelper alloc] initWithCollectionView:collectionView
                                                                  cell:codeCell
                                                         sectionHeader:sectionHeader
                                                         sectionFooter:sectionFooter
                                                                source:source
                                                         withViewModel:viewModel
                                                             cellParam:cellParam
                                                       selectedCommand:didSelectedCommand];
                                
}

+ (instancetype)bindCollectionViewHelper:(UICollectionView *)collectionView
                                nibCell:(Class)nibCell
                       nibSectionHeader:(Class)sectionHeader
                       nibSectionFooter:(Class)sectionFooter
                                 source:(RACSignal *)source
                              viewModel:(id _Nullable)viewModel
                        selectedCommand:(RACCommand * _Nullable)didSelectedCommand {
                           
  NSDictionary *cellParam = @{@"cellType":@"nibType", @"headerType":@"nibType", @"footerType":@"nibType"};
  return [[JYCollectionViewBindingHelper alloc] initWithCollectionView:collectionView
                                                                  cell:nibCell
                                                         sectionHeader:sectionHeader
                                                         sectionFooter:sectionFooter
                                                                source:source
                                                         withViewModel:viewModel
                                                             cellParam:cellParam
                                                       selectedCommand:didSelectedCommand];
                                
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return self.isGroup ? self.sources.count : 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  NSArray *sections = self.isGroup ? self.sources[section] : self.sources;
  return sections.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  id<JYReactiveViewDelegate> cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
  id model = nil;
  
  if(self.isGroup) {
    if(indexPath.section < self.sources.count){
      NSArray *temp = self.sources[indexPath.section];
      if(indexPath.item < temp.count){
        model = temp[indexPath.item];
      }
    }
  } else {
    if(indexPath.item < self.sources.count) {
      model = self.sources[indexPath.item];
    }
  }
  
  if([self respondsToSelector:@selector(handlerDelegate:sendModel:indexPath:)]){
    [self handlerDelegate:cell sendModel:model indexPath:indexPath];
  }
  
//  id model = self.isGroup ? self.sources[indexPath.section][indexPath.item] : self.sources[indexPath.item];
//  [self handlerDelegate:cell sendModel:model indexPath:indexPath];
  
  return (UICollectionViewCell *)cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  
  if([kind isEqualToString:UICollectionElementKindSectionHeader]){
    id<JYReactiveViewDelegate> headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                               withReuseIdentifier:_headerIdentifier
                                                                                      forIndexPath:indexPath];
    [headerView bindModel:self.viewModel withParam:@{ModelOfIndexPath:indexPath}];
    return (UICollectionReusableView *)headerView;
  } else {
    id<JYReactiveViewDelegate> footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                               withReuseIdentifier:_footerIdentifier
                                                                                      forIndexPath:indexPath];
    [footerView bindModel:self.viewModel withParam:@{ModelOfIndexPath:indexPath}];
    return (UICollectionReusableView *)footerView;
  }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [collectionView deselectItemAtIndexPath:indexPath animated:YES];
  id model = self.isGroup ? self.sources[indexPath.section][indexPath.item] : self.sources[indexPath.item];
  [self.didSelecetdCommand execute:model];
  
  if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
    [self.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
  }
}

#pragma mark - UICollectionViewDelegate forwarding

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
    [self.delegate scrollViewDidScroll:scrollView];
  }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
  if ([self.delegate respondsToSelector:aSelector]) {
    return YES;
  }
  
  return [super respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
  if ([self.delegate respondsToSelector:aSelector]) {
    return self.delegate;
  }
  
  return [super forwardingTargetForSelector:aSelector];
}


- (void)handlerDelegate:(id<JYReactiveViewDelegate>)delegate sendModel:(id)model indexPath:(NSIndexPath *)indexPath {
  NSDictionary *param = @{ModelOfIndexPath:indexPath};
  
  if ([delegate respondsToSelector:@selector(bindViewModel:model:withParam:)]) {
      [delegate bindViewModel:self.viewModel model:model withParam:param];
  } else if ([delegate respondsToSelector:@selector(bindModel:withParam:)]) {
    [delegate bindModel:model withParam:param];
  } else if ([delegate respondsToSelector:@selector(bindModel:)]) {
    [delegate bindModel:model];
  }
}

@end
