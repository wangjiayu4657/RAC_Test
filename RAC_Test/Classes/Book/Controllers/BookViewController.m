//
//  MessageViewController.m
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "BookViewController.h"
#import "JYBannerModel.h"
#import "RACReturnSignal.h"
#import "BookViewModel.h"
#import "JYBookTopView.h"
#import "JYBookBottomView.h"
#import "JYBookDomainCell.h"
#import "JYBookDetailController.h"
#import "UIViewController+HTHideBottomLine.h"


@interface BookViewController ()<UITableViewDelegate>
/** 底部视图 */
@property (nonatomic,strong) JYBookTopView *topView;
/** 列表 */
@property (nonatomic,strong) BaseTableView *tableView;
/** 底部工具视图 */
@property (nonatomic,strong) JYBookBottomView *bottomView;
/** 视图模型 */
@property (nonatomic,strong) BookViewModel *viewModel;
/** 绑定视图 */
@property (nonatomic,strong) JYTableViewBindingHelper *bookHelper;

@property (nonatomic,assign) int page;

@end

@implementation BookViewController

- (instancetype)initWithViewModel:(BookViewModel *)viewModel {
  if (self = [super init]) {
    _viewModel = viewModel;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"消息";
  
  [self buildSubviews];
  [self bindViewModel];
}

#pragma mark - 设置UI

- (void)buildSubviews {
  //隐藏tabbar上的横线
  [self HT_hideBottomLineInView:self.tabBarController.tabBar];
  
  [self addRightItem:@"筛选" callBack:^{
    NSLog(@"开始筛选");
  }];
  
  [self.view addSubview:self.topView];
  [self.topView makeConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(44);
    make.left.top.right.equalTo(self.view);
  }];
  
  [self.view addSubview:self.tableView];
  [self.tableView makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.view);
    make.top.equalTo(self.topView.mas_bottom);
  }];
  
  [self.view addSubview:self.bottomView];
  [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(50);
    make.left.bottom.right.equalTo(self.view);
    make.top.equalTo(self.tableView.mas_bottom);
  }];
}

#pragma mark - 绑定数据

- (void)bindViewModel {
	//下拉刷新
  @weakify(self)
  self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
  	@strongify(self)
    self.page = 1;
    [self.viewModel.sourceCommand execute:@(self.page)];
  }];
  
  //上拉加载
  self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    @strongify(self)
    self.page ++;
    [self.viewModel.sourceCommand execute:@(self.page)];
  }];
  
  //刷新状态监听
  [[[self.viewModel.sourceCommand executing] skip:1] subscribeNext:^(NSNumber * _Nullable x) {
    @strongify(self)
    if ([x boolValue] == NO) {
      [self.tableView.mj_header endRefreshing];
      [self.tableView.mj_footer endRefreshing];
    }
  }];
  
  //开始下拉刷新
  [self.tableView.mj_header beginRefreshing];
  
  //绑定数据
  self.bookHelper = [JYTableViewBindingHelper bindingHelperForTableView:self.tableView
                                                               codeCell:[JYBookDomainCell class]
                                                                 source:RACObserve(self.viewModel, sources)
                                                          withViewModel:self.viewModel
                                                       selectionCommand:nil];
  
  self.bookHelper.delegate = self;
  //根据信号刷新列表
  self.bookHelper.reloadSignal = self.viewModel.selectedSetSignal;
  //全选时刷新列表
  self.bottomView.allSelectedCommand = self.viewModel.allSelectedCommand;
}

#pragma mark - UItableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  JYBookDetailController *ctrl = [[JYBookDetailController alloc] init];
  [self.navigationController pushViewController:ctrl animated:YES];
}

#pragma mark - 懒加载

- (JYBookTopView *)topView {
  return JY_LAZY(_topView, [[JYBookTopView alloc] initWithFrame:CGRectZero]);
}

- (BaseTableView *)tableView {
  return JY_LAZY(_tableView, ({
    BaseTableView *tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.rowHeight = 44;
    tableView;
  }));
}

- (JYBookBottomView *)bottomView {
  return JY_LAZY(_bottomView, [[JYBookBottomView alloc] initWithFrame:CGRectZero]);
}

@end
