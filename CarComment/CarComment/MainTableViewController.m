//
//  MainTableViewController.m
//  CarComment
//
//  Created by Jiao Liu on 6/20/19.
//  Copyright © 2019 ChangHong. All rights reserved.
//

#import "MainTableViewController.h"
#import "classifier.h"

@interface MainTableViewController () {
    NSMutableArray *data;
    classifier *model;
}

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    data = [NSMutableArray arrayWithObjects:@"这玩意都是给有钱任性又不懂车的土豪用的，这价格换一次我妹夫EP020可以换三锅了",
            @"听过，价格太贵，但一直念念不忘",
            @"说实话，基本上用不上车上导航，用手机更方便！音响效果不用纠结，毕竟不是想成为移动音乐厅。",
            @"换4条静音轮胎才是正道",
            @"2.0 平均油耗10个 不到四千公里",
            @"同样的颜色 你们觉得是16款好看还是19款好看",
            @"女孩子打算买国六1.5t中配，12万多，首付20％不到3万，上路5万左右，分4年，一月还2500左右。贵吗？",
            @"我想问一下 16寸轮毂要比17寸轮毂小，那车子底盘离地面的距离是不是16寸的比17寸的还要矮上很多？？？",
            @"这车没有自动落锁吗",
            @"想要动力强提速快就菲斯塔 情怀就思域 我们开本田125长大的就是喜欢买本田",
            nil];
    model = [[classifier alloc] init];
    self.tableView.allowsSelection = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *comment = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = comment;
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [[model predictionFromText:comment error:nil] label];
    
    return cell;
}

- (IBAction)AddClicked:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New Post" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *newComment = alert.textFields.firstObject.text;
        if (newComment.length != 0) {
            [self->data insertObject:newComment atIndex:0];
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }];
    [alert addAction:confirm];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
