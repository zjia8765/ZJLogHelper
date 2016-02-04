//
//  DetailViewController.m
//  ZJLogHelper
//
//  Created by zhangjia on 16/2/4.
//
//

#import "DetailViewController.h"
#import "Masonry.h"

@interface DetailViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *listTableView;
@end

@implementation DetailViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"详情";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _listTableView = [[UITableView alloc]initWithFrame:CGRectZero];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self.view addSubview:_listTableView];
    
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];
    
}

-(void)dealloc
{
    NSLog(@"%@",@"DetailViewController--dealloc");
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
    cell.textLabel.text = [NSString stringWithFormat:@"详情%d",indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
