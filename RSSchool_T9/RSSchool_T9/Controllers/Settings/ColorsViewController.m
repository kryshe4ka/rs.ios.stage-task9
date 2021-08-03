//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Liza Kryshkovskaya
// On: 28.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "ColorsViewController.h"
#import "ColorDelegate.h"
#import "UIColor+HexFormat.h"


@interface ColorsViewController ()

@property (nonatomic, strong) UITableView * tableView;
@property NSArray * data;

@end

@implementation ColorsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"EFEFF4"];
    [self setupView];
    self.currentColor = 12;
}

- (void)setupView {
    self.data = @[@"#be2813", @"#3802da", @"#467c24", @"#808080", @"#8e5af7", @"#f07f5a", @"#f3af22", @"#3dacf7", @"#e87aa4", @"#0f2e3f", @"#213711", @"#511307", @"#92003b"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];

    [NSLayoutConstraint activateConstraints: @[
            [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
            [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
            [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
            [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
    ]];
    
    self.tableView.layer.cornerRadius = 16;
    self.tableView.backgroundColor = [UIColor colorNamed:@"EFEFF4"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // регистрируем ячейку
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"TableViewCell"];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    //здесь мы должны получить ячейку (ячейку нужно зарегистрировать)
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.data[indexPath.row];
    cell.textLabel.textColor = [UIColor colorFromHexFormat:(self.data[indexPath.row])];
    cell.textLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];

    if (indexPath.row == self.currentColor) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.currentColor = indexPath.row;
    NSLog(@"%ld", (long)self.currentColor );
    [self.tableView reloadData];
    
    [self.delegate setColor:cell.textLabel.text];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
