//
//  addContactVC.m
//  banana
//
//  Created by 袁David on 16/5/24.
//  Copyright © 2016年 Yuan. All rights reserved.
//

#import "addContactVC.h"

@interface addContactVC ()
- (IBAction)ClickBackBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

- (IBAction)clickAddBtn:(id)sender;

@end

@implementation addContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)ClickBackBtn:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否注销" message:@"这里是详细说明" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
        [self.navigationController popViewControllerAnimated:YES];
    } ]];
    [self presentViewController:alert animated:YES completion:NULL];
}
- (IBAction)clickAddBtn:(id)sender {
}
@end
