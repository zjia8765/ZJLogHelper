//
//  MainViewController.m
//  ZJLogHelper
//
//  Created by zhangjia on 16/2/4.
//
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "SettingViewController.h"

#import "Masonry.h"

@interface MainViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *listTableView;
@end

@implementation MainViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    settingBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [settingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    settingBtn.layer.borderColor = [UIColor blackColor].CGColor;
    settingBtn.layer.borderWidth = 1.0;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    UIButton *userBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [userBtn setTitle:@"个人" forState:UIControlStateNormal];
    userBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [userBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(userInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    userBtn.layer.borderColor = [UIColor blackColor].CGColor;
    userBtn.layer.borderWidth = 1.0;
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:userBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _listTableView = [[UITableView alloc]initWithFrame:CGRectZero];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self.view addSubview:_listTableView];
    
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];

}
#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListTableViewCellIdentifier"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"列表%d",indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:nil];
}

-(void)userInfoBtnAction:(id)sender
{
    
}

-(void)settingBtnAction:(id)sender
{
    [self performSegueWithIdentifier:@"showSetting" sender:nil];
}

#pragma mark -
#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}
@end
