//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Liza Kryshkovskaya
// On: 28.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "SettingsViewController.h"
#import "ColorsViewController.h"

@interface SettingsViewController ()

@property (nonatomic, strong) UITableView * tableView;
@property NSArray * data;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"EFEFF4"];
    [self setupView];
    
}

- (void)setupView {
    
    self.navigationItem.title = @"Settings";
    self.data = @[@"Draw stories", @"Stroke color"];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    [NSLayoutConstraint activateConstraints:@[
       [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:36],
       [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-35],
       [self.tableView.heightAnchor constraintEqualToConstant:104],
       [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:30]
    ]];
    
    self.tableView.layer.cornerRadius = 16;
    self.tableView.backgroundColor = [UIColor colorNamed:@"F9F9F9"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        
    // регистрируем ячейку
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"CellId"];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //здесь мы должны получить ячейку (ячейку нужно зарегистрировать)
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    UISwitch * switchView;
    
    switch (indexPath.row) {
        case 0:
            switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
            cell.accessoryView = switchView;
            [switchView setOn:YES animated:YES];
            [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 1:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellId"];
            cell.detailTextLabel.text = @"92003B";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        default:
            break;
    }
    
    cell.textLabel.text = self.data[indexPath.row];
    [self.tableView setRowHeight:51];
    return cell;
}

- (void)switchChanged:(id)sender {
    UISwitch * switchControl = sender;
    NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ColorsViewController * colorsViewController = [[ColorsViewController alloc] init];
    colorsViewController.delegate = self;
            
    [self.navigationController pushViewController:colorsViewController animated:YES];
}

- (void) setColor: (NSString *) strokeColor{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: 1 inSection:0];
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = strokeColor;
}
@end
