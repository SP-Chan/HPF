//
//  LocationViewController.m
//  Happy Sharing
//
//  Created by dengchongkang on 16/3/7.
//  Copyright © 2016年 jackTang. All rights reserved.
//

#import "LocationViewController.h"
#import "NSString+Characters.h"
#import "LocationManager.h"

@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>

@property(nonatomic,strong)NSMutableDictionary *locationMdic;
//右边小标题的数组
@property(nonatomic,strong)NSMutableArray *sortedKayArr;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong) UISearchController *searchController;

@property(nonatomic,strong) NSMutableArray *searchList;
//判断是否在搜索状态
@property (nonatomic, assign)BOOL search;

@property(nonatomic,strong) NSMutableArray *locationArr;
//分区头标题
@property (nonatomic, strong)NSMutableArray *littleTitleArr;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, assign)BOOL localSuccess;
@end

@implementation LocationViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self locationRequeste];
}

-(instancetype)init
{
    if (self = [super init])
    {
        [self loadData];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settitleLabelWithCity:self.city];

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    backButton.backgroundColor = [UIColor blackColor];
    backButton.frame = CGRectMake(15, kSCREEN_HEIGHT * 0.1 - 35, 30, 30);
    [backButton setBackgroundImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
//    self.tableView.dk_backgroundColorPicker =  DKColorWithRGB(0xffffff, 0x343434);
//    self.tableView.dk_separatorColorPicker = DKColorWithRGB(0xaaaaaa, 0x313131);
    //在没有导航栏状态下使tableview顶在状态栏下
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"respool"];
    self.tableView.tableFooterView = [UIView new];
    [self seTSearchController];
}


-(void)locationRequeste
{
    //当进入的搜索城市的时候开始定位
    __weak typeof(self) weakself = self;
    [[LocationManager shareLocationManager].locationManager startUpdatingLocation];
    [[LocationManager shareLocationManager] startUpdatingLocationWithSuccess:^(CLLocation *location, CLPlacemark *placemark) {
        
        NSString *city = [placemark.locality substringWithRange:NSMakeRange(0, placemark.locality.length - 1)];

        if (city != nil)
        {
            NSString *str = @"当前城市-";
            weakself.titleLabel.text = [str stringByAppendingString:city];
            weakself.city = city;
            NSArray *arr = @[city];
            [weakself.locationMdic setObject:arr forKey:@"您当前的位置可能是"];
             weakself.localSuccess = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.tableView reloadData];
            });
            
            
        }
        //没有定位到城市
        else
        {
            NSArray *arr = @[@"无法定位..."];
            [weakself.locationMdic setObject:arr forKey:@"您当前的位置可能是"];
            [weakself.tableView reloadData];
            if (weakself.view.window)
            {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位失败" preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
                     [alertVC addAction:action];
                     [weakself presentViewController:alertVC animated:YES completion:NULL];
                 });

            }
        }
     
    } andFailure:^(CLRegion *region, NSError *error) {
        if (weakself.view.window)
        {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
        [alertVC addAction:action];
        [weakself presentViewController:alertVC animated:YES completion:NULL];
        }
    } WithViewcontroller:self connotLocation:^{
        NSArray *arr = @[@"无法定位..."];
        [weakself.locationMdic setObject:arr forKey:@"您当前的位置可能是"];
        [weakself.tableView reloadData];
    }];
    
    
}
-(void)backButtonAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//设置当前的城市
-(void)settitleLabelWithCity:(NSString *)city
{

    NSString *str = @"当前城市-";
    self.navigationItem.title = [str stringByAppendingString:city];

}
//创建搜索框
-(void)seTSearchController
{
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44);
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

//点击搜索框调用此方法
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    NSString *fieldStr = searchController.searchBar.text;
    if (fieldStr.length > 0)//长度大于0，判断输入的是否是汉字
    {
        
        unichar c = [fieldStr characterAtIndex: fieldStr.length - 1];//得到最新输入的字符
        if (c >= /* DISABLES CODE */ (0x4E00) && c <= 0x9FFF)//判读最后输入的字符是否为汉字
        {
            NSMutableArray *arr = [self searchChineseMatchLocation:fieldStr];
            if (arr.count != 0)//第一个字符找的时候
            {
                self.searchList = arr;
                [self.tableView reloadData];
            }
            if (arr.count == 0)
            {
               
                [self.tableView reloadData];
            }
             self.search = YES;
        }
        else//输入为英文
        {
            fieldStr = [fieldStr uppercaseString];//所有字母变为大写，因为名字的拼音首字母也为大写
            NSMutableArray *arr = [self searchEglishMatchContact:fieldStr];
            if (arr.count != 0)//第一个字符找的时候
            {
                self.searchList = arr;
                [self.tableView reloadData];
            }
            if (arr.count == 0)
            {
                [self.tableView reloadData];
            }
            self.search = YES;
        }
    }
    else//当搜索之后又删除完毕的时候就删除所有搜索到的联系人(搜索框中没有文本)
    {
        [self.searchList removeAllObjects];
        [self.tableView reloadData];
    }
   
}



-(NSMutableArray*)searchEglishMatchContact:(NSString *)fieldStr
{
    NSMutableArray *locationArr = [NSMutableArray array];
    if (fieldStr.length == 1)//如果它的长度为1，并且是英文，则先去分区直接找
    {
        for (int i = 0; i < self.sortedKayArr.count; i ++)
        {
            for (NSString *locationName in [self.locationMdic objectForKey:self.sortedKayArr[i]])
            {
                NSString *locationNameStr = [self getLocationPinyinOfName:locationName];
                
                if ([locationNameStr containsString:fieldStr])//如果联系人的拼音首字母包含输入的第一个字母，则添加到搜索的联系人数组中
                {
                    [locationArr addObject:locationName];
                    
                }
            }
        }
    }
    else//如果输入字符的长度大于一
    {
        NSInteger number = self.searchList.count;
        if (number > 0)//如果搜索到的联系人数量不为零
        {
            NSInteger deleteContactNumber = 0;
            for (int i = 0; i < number; i ++)//在找到的联系人数组中寻找
            {
                NSString *locationNameStr = [self getLocationPinyinOfName:self.searchList[i - deleteContactNumber]];
                
                for (int j = 0; j < fieldStr.length; j ++)//依次判断是否一样
                {
                    unichar fieldChar = [fieldStr characterAtIndex:j];
                    unichar contactNameChar ;
                    if (j < locationNameStr.length)
                    {
                        contactNameChar = [locationNameStr characterAtIndex:j];
                    }
                    else
                    {
                        break;
                    }
                    
                    if (fieldChar != contactNameChar)//只要有一个不包含，就从搜索到的联系人数组中删除联系人
                    {
                        
                        [self.searchList removeObjectAtIndex:i - deleteContactNumber];
                        deleteContactNumber ++;//没删除一个,计数加一
                        break;
                    }
                }
            }
        }
        
    }
    return locationArr;
}

-(NSString *)getLocationPinyinOfName:(NSString *)locationName//得到地点拼音的首字母，并返回
{
    NSMutableString *Mstr = [NSMutableString string];
    for (int i = 0 ; i < locationName.length; i ++)
    {
        NSString *str = [locationName substringFromIndex:i];
        [Mstr appendString:[str firstCharacterOfName]];
    }
    return Mstr;
}
-(NSMutableArray *)searchChineseMatchLocation:(NSString *)fieldStr
{
    NSMutableArray *locationArr = [NSMutableArray array];
    if (fieldStr.length == 1)//如果输入的是第一个字符
    {
        for (int i = 0; i < self.sortedKayArr.count; i ++)
        {
            for (NSString *locationName in self.locationMdic[self.sortedKayArr[i]])
            {
                for (int j = 0; j < fieldStr.length; j ++)
                {
                    if ([locationName containsString:fieldStr])
                    {
                        [locationArr addObject:locationName];
                    }
                }
            }
        }
    }
    else
    {
        NSInteger number = self.searchList.count;
        if (number > 0)//如果搜索到的联系人数量不为零
        {
            NSInteger deleteLocationNumber = 0;
            for (int i = 0; i < number; i ++)//在找到的地点数组中寻找
            {
                NSString *locationName = self.searchList[i - deleteLocationNumber];
                for (int j =
                     0; j < fieldStr.length; j ++)//依次判断是否一样
                {
                    NSString *field = [fieldStr substringWithRange:NSMakeRange(j, 1)];
                    NSString *locationNameStr = nil;
                    if (j < locationName.length)
                    {
                        locationNameStr = [locationName substringWithRange:NSMakeRange(j, 1)];
                    }
                    else//如果输入的字符长度大于地点的长度就直接跳出循环，进入下一个地点的判断
                    {
                        break;
                    }
                    
                    if (![locationNameStr isEqualToString:field])//只要有一个不包含，就从搜索到的联系人数组中删除地点
                    {
                        [self.searchList removeObjectAtIndex:i - deleteLocationNumber];
                        deleteLocationNumber ++;//每删除一个,计数加一
                        break;
                    }
                }
            }
        }
    }
    return locationArr;
}

-(void)loadData
{
    NSArray *pathArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Location List" ofType:@"plist"]];
    
    for (NSArray * arr in pathArr)
    {
        for (NSString *location in arr)
        {
            //地点添加到字典上
            [self addLocationStr:location];
        }
    }

    //对索引数组进行排序
    [self sortFoyAllKey];
    
    [self.littleTitleArr addObjectsFromArray:self.sortedKayArr];
    NSArray *arr = @[@"正在定位..."];
    NSMutableArray *marr1 = [NSMutableArray arrayWithArray:@[@"北京",@"上海",@"广州",@"深圳"]];
    [self.locationMdic setObject:arr forKey:@"您当前的位置可能是"];
    [self.locationMdic setObject:marr1 forKey:@"经常选的城市"];

}



//添加地点到字典中
-(void)addLocationStr:(NSString *)location
{
    //得到地点拼音首字母大写
    NSString *GroupName = [[location pinyinOfName]firstCharacterOfName];
    
    //判断将要添加的地点有无对应的分组
    if ([[self.locationMdic allKeys] containsObject:GroupName])
    {
        [_locationMdic[GroupName] addObject:location];
    }
    else
    {
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:location];
        [_locationMdic setObject:arr forKey:GroupName];
    }
}

//对字典分组中的地点数组中的元素进行排序
-(void)sortCinatctArrWithGroupName:(NSString *)groupName
{
    NSMutableArray *mArr = _locationMdic[groupName];
    [mArr sortUsingComparator:^NSComparisonResult(id  obj1, id   obj2)
    {
      return [[obj1 pinyinOfName] compare:[obj2 pinyinOfName] ];
    }];

}

//对索引数组进行排序
-(void)sortFoyAllKey
{
    
    for (NSString *sort in [NSMutableArray arrayWithArray:[_locationMdic allKeys]])
    {
        [self.sortedKayArr addObject:sort];
    }
    
    [self.sortedKayArr  sortUsingComparator:^NSComparisonResult(id  obj1, id   obj2)
    {
        return [obj1 compare:obj2 ];
        
    }];
}








-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.littleTitleArr.count == 0)
    {
        return 1;
    }
    if ( self.searchController.searchBar.text.length != 0 )
    {
        return 1;
    }
    else
    {
    return self.littleTitleArr.count;
    
    }
    

}

#pragma mark tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.littleTitleArr.count == 0)
    {
        return 1;
    }
    
    if ( self.searchController.searchBar.text.length != 0)
    {
        return [self.searchList count];
    }
    else
    {
        NSMutableArray *marr = self.locationMdic[self.littleTitleArr[section]];
        return marr.count;
    }
    

   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //说明没有在搜索状态
    if ( self.searchController.searchBar.text.length != 0)
    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCity" object:nil userInfo:@{@"cityName":self.searchList[indexPath.row]}];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationCity object:nil];
        [[NSUserDefaults standardUserDefaults] setObject:self.searchList[indexPath.row] forKey:kLocationCity];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else
    {
        //定位成功第一个cell才可以点
        if (self.localSuccess == YES || (indexPath.section != 0 && self.localSuccess == NO))
        {
            NSString *text =  [self.locationMdic[self.littleTitleArr[indexPath.section]]objectAtIndex:indexPath.row];
            NSLog(@"%@",self.locationMdic[@"您当前的位置可能是"][0]);
            NSLog(@"%@",text);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCity" object:nil userInfo:@{@"cityName":text}];
            [[NSUserDefaults standardUserDefaults] setObject:text forKey:kLocationCity];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLocationCity object:nil];
           
            [self dismissViewControllerAnimated:YES completion:NULL];
             [self dismissViewControllerAnimated:YES completion:NULL];
        }
        
    }
   
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"respool" forIndexPath:indexPath];
    
    if ( self.searchController.searchBar.text.length != 0)
    {
        [cell.textLabel setText:self.searchList[indexPath.row]];
    }
    else
    {
        cell.textLabel.text =  [self.locationMdic[self.littleTitleArr[indexPath.section]]objectAtIndex:indexPath.row];

    }

    return cell;

}

//每行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


//分区标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.littleTitleArr.count == 0) {
        return 0;
    }
    if ( self.searchController.searchBar.text.length != 0)
    {
        return  0;
    }
    
    else
    {
        return self.littleTitleArr[section];
    }
      
    
}

//索引
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.littleTitleArr.count == 0)
    {
        return 0;
    }
    if (self.searchController.searchBar.text.length != 0)
    {
        return 0;
    }
    else
    
    {
        NSMutableArray *arr = [self.sortedKayArr mutableCopy];//在前面加两个有空格的东西
        [arr insertObjects:@[@"",@""] atIndexes:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 2)]];
        return arr;
    }
    
    
}



#pragma mark 懒加载
//懒加载
-(NSMutableDictionary *)locationMdic
{
    if (_locationMdic == nil) {
        _locationMdic = [NSMutableDictionary dictionary];
    }


    return _locationMdic;
}

-(NSMutableArray *)sortedKayArr
{
    if (_sortedKayArr == nil) {
        _sortedKayArr = [NSMutableArray array];

    }
    return _sortedKayArr;


}
-(NSMutableArray *)littleTitleArr
{
    if (_littleTitleArr == nil)
    {
        _littleTitleArr = [[NSMutableArray alloc]init];
        [_littleTitleArr addObject:@"您当前的位置可能是"];
        [_littleTitleArr addObject:@"经常选的城市"];
    }
    return _littleTitleArr;
}

//将源数据字典中的所有地点存到一个数组中
-(NSMutableArray *)locationArr
{
    if (_locationArr == nil) {
        _locationArr = [NSMutableArray array];
        for (NSString *key in _locationMdic) {
            NSMutableArray *marr = _locationMdic[key];
            for (NSString *location in marr) {
                [_locationArr addObject:location];
            }
        }
    }
    return _locationArr;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{      //因为self.searchController 默认会在页面退出后一段时间才dealloc
    //以下两种方法都能使退出页面时立刻把self.searchController.view dealloc掉
    [self.searchController.view removeFromSuperview];
    //    [self.searchController loadViewIfNeeded];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
