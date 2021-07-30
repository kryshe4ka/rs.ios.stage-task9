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

@interface ColorsViewController ()

@property (nonatomic, strong) UITableView * tableView;
@property NSArray * data;

@end

@implementation ColorsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"EFEFF4"];
    [self setupView];
}

- (void)setupView {
    self.data = @[@"#BE2813", @"#3802DA", @"#467C24", @"#808080", @"#8E5AF7", @"#F07F5A", @"#F3AF22", @"#3DACF7", @"#E87AA4", @"#0F2E3F", @"#213711", @"#511307", @"#92003B"];
    self.tableView = [[UITableView alloc] init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    [NSLayoutConstraint activateConstraints:@[
       [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:36],
       [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-35],
       [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-16],
       [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:30]
    ]];
    
    self.tableView.layer.cornerRadius = 16;
    self.tableView.backgroundColor = [UIColor colorNamed:@"F9F9F9"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // регистрируем ячейку
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"TableViewCell"];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    //здесь мы должны получить ячейку (ячейку нужно зарегистрировать)
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    
    [self.delegate setColor:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
