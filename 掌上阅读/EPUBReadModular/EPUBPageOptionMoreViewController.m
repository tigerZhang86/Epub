//
//  EPUBPageOptionMoreViewController.m
//  掌上阅读
//
//  Created by 易云时代 on 2017/8/10.
//  Copyright © 2017年 易云时代_ZXW. All rights reserved.
//
#import "EPUBReadMainViewController.h"
#import "EPUBPageOptionMoreViewController.h"

typedef NS_ENUM(NSInteger, EPUBREADBUTTONTAG)
{
    OPTIONMORE_BUTTON_BACK=200,
    
};

@interface EPUBPageOptionMoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSInteger changed;

@end

@implementation EPUBPageOptionMoreViewController
-(void)dealloc
{
    //析构
    self.backBlock=nil;
    
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    
#ifdef DEBUG
    NSLog(@"析构 EPUBPageOptionMoreViewController");
#endif
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        //准备数据
        [self dataPrepare];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //__weak typeof(self) _weakself = self;
    
    
    //界面
    [self customViewInit:self.view.bounds];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self resizeViews:self.view.bounds];
}
////////////////////////////////////////////////////////////////////////////////
//////////////     life circle   界面 相关  ////////// ///////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark - life circle
-(void)customViewInit:(CGRect)viewRect
{
    //创建
    
    CGRect rectContent=viewRect;
    
    _headView=[[UIView alloc] init];
    _headView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:_headView];
    if (_headView)
    {
        
        _lbTitle=[[UILabel alloc] init];
        _lbTitle.backgroundColor=[UIColor clearColor];
        _lbTitle.textColor=[UIColor whiteColor];
        _lbTitle.textAlignment=NSTextAlignmentCenter;
        _lbTitle.font=[UIFont boldSystemFontOfSize:16.0f];
        _lbTitle.text=NSLocalizedString(@"更多设置", @"");
        [_headView addSubview:_lbTitle];
        
        self.btnBack=[UIButton buttonWithType:UIButtonTypeCustom];
        self.btnBack.tag=OPTIONMORE_BUTTON_BACK;
        [self.btnBack addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:self.btnBack];
        self.btnBack.titleLabel.font=[UIFont systemFontOfSize:14.0f];
        [self.btnBack setTitle:NSLocalizedString(@"返回", @"") forState:UIControlStateNormal];
    }
    
    //
    _contentView=[[UIView alloc] initWithFrame:rectContent];
    [self.view addSubview:_contentView];
    _contentView.backgroundColor=[UIColor clearColor];
    if (_contentView)
    {
        _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.autoresizesSubviews=YES;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        [_contentView addSubview:_tableView];
        
    }
    
}

-(void)resizeViews:(CGRect)viewRect
{
    //整体界面调整
    
    if (viewRect.size.width<1 || viewRect.size.height<1) {
        return;
    }
    
    CGRect rectHead=viewRect;
    rectHead.size.height=64.0f;
    _headView.frame=rectHead;
    if (_headView) {
        CGRect rectBound=_headView.bounds;
        
        CGRect rectTitle=CGRectMake(80, 20, 0, 44);
        rectTitle.size.width=rectBound.size.width-rectTitle.origin.x*2;
        _lbTitle.frame=rectTitle;
        
        CGRect rect1=CGRectMake(10, 20, 60, 44);
        self.btnBack.frame=rect1;
    }
    
    
    CGRect rectContent=viewRect;
    rectContent.origin.y=rectHead.origin.y+rectHead.size.height;
    rectContent.size.height=viewRect.size.height-rectContent.origin.y;
    _contentView.frame=rectContent;
    if (_contentView) {
        CGRect rectBound=_contentView.bounds;
        
        _tableView.frame=rectBound;
    }
    
    
}
-(void)dataPrepare
{
    _changed=0;
}
-(void)initAfter
{
    //后续初始化
    
}


-(void)refresh
{
    //刷新
    [self.tableView reloadData];
    
}
////////////////////////////////////////////////////////////////////////
///////// Table view data source ///////////////
////////////////////////////////////////////////////////////////////////
#pragma mark - TableView data source delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //int sectionIndex=indexPath.section;
    NSInteger rowIndex =indexPath.row;
    
    UITableViewCell *cell=nil;
    
    static NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if( !cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    if (rowIndex == 0)
    {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        NSInteger  transitionStyle= [self.epubVC pageViewTransitionStyle];
        NSString *strContent=[NSString stringWithFormat:@"翻页方式 - %@",transitionStyle?@"简约":@"仿真"];
        cell.textLabel.text =strContent;
        cell.textLabel.font=[UIFont boldSystemFontOfSize:14.0f];
    }
        

    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sectionIndex=indexPath.section;
    NSInteger rowIndex =indexPath.row;

    
    if (rowIndex == 0 && sectionIndex==0) {
        
        __weak typeof(self) _weakself = self;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择" message:@"翻页方式" preferredStyle: UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",@"") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            //Cancel
        }];

        UIAlertAction *action1 = [UIAlertAction actionWithTitle:NSLocalizedString(@"仿真",@"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            NSInteger  transitionStyle= [_weakself.epubVC pageViewTransitionStyle];
            if (transitionStyle !=0) {
                [_weakself.epubVC setPageViewTransitionStyle:0];
                _weakself.changed=1;
                [_weakself refresh];
        
            }
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:NSLocalizedString(@"简约",@"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSInteger  transitionStyle= [_weakself.epubVC pageViewTransitionStyle];
            if (transitionStyle !=1) {
                [_weakself.epubVC setPageViewTransitionStyle:1];
                _weakself.changed=1;
                [_weakself refresh];
            }

        }];

        [alertController addAction:cancelAction];
        [alertController addAction:action1];
        [alertController addAction:action2];
        
        if ( !self.epubVC.isPhone) {
            UIPopoverPresentationController *pop = alertController.popoverPresentationController;
            pop.delegate = nil; // UIPopoverPresentationControllerDelegate
            pop.sourceView = self.view;
            CGRect rect1=[self.tableView rectForRowAtIndexPath:indexPath];
            CGRect rect2=[self.view convertRect:rect1 fromView:self.tableView];
            pop.sourceRect=rect2;
        }

        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
////////////////////////////////////////////////////////////////////////
//////////////////////        其他         ///////////////
////////////////////////////////////////////////////////////////////////
#pragma mark - 其他
-(void)btnClick:(id)sender
{
    //上下工具栏响应
    NSInteger btnTag= [sender tag];
    
    if (btnTag == OPTIONMORE_BUTTON_BACK )
    {
        if (self.backBlock) {
            NSMutableDictionary *para=[NSMutableDictionary dictionary];
            [para setObject:[NSString stringWithFormat:@"%@",@(self.changed)] forKey:@"changed"];
            self.backBlock(para);
        }
    }
    
    
}

@end
