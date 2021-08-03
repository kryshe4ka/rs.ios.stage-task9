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
#import "RSSchool_T9-Bridging-Header.h"
#import "RSSchool_T9-Swift.h"

@interface SettingsViewController ()

@property (nonatomic, strong) UITableView * tableView;
@property NSArray * data;
@property BOOL drawOFF;
@property ColorsViewController * colorsViewController;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorNamed:@"F2F2F7"];
    [self setupView];
    
    self.colorsViewController = [[ColorsViewController alloc] init];
    self.colorsViewController.delegate = self;
    
}

- (void)setupView {
    
    self.navigationItem.title = @"Settings";
    self.data = @[@"Draw stories", @"Stroke color"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    [NSLayoutConstraint activateConstraints:@[
       [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:0],
       [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:0],
       //[self.tableView.heightAnchor constraintEqualToConstant:144],
       [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:0],

       [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:0]
    ]];
    
    self.tableView.layer.cornerRadius = 16;
    self.tableView.backgroundColor = [UIColor colorNamed:@"F2F2F7"];
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
            cell.detailTextLabel.text = @"#92003B";
            cell.detailTextLabel.textColor = [UIColor colorFromHexFormat:@"#92003B"];
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
    self.drawOFF = switchControl.on ? YES : NO;
    [self.delegateKL setSwitcher:(switchControl.on ? YES : NO)];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //ColorsViewController * colorsViewController = [[ColorsViewController alloc] init];
    //self.colorsViewController.delegate = self;
            
    [self.navigationController pushViewController:self.colorsViewController animated:YES];
}

- (void) setColor: (NSString *) strokeColor{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: 1 inSection:0];
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = strokeColor;
    cell.detailTextLabel.textColor = [UIColor colorFromHexFormat:strokeColor];
    [self.delegateColor setColor:(strokeColor)];
}
@end
