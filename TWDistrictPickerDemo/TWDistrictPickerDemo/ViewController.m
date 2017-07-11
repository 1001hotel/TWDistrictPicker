//
//  ViewController.m
//  TWDistrictPickerDemo
//
//  Created by luomeng on 2017/7/11.
//  Copyright © 2017年 XRY. All rights reserved.
//

#import "ViewController.h"
#import "DistrictPickerVC.h"

@interface ViewController ()
<
UITextFieldDelegate,
DistrictPickerPickerDelegate
>
{

    DistrictPickerVC *_dc;
}
@property (weak, nonatomic) IBOutlet UITextField *_inputField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    if (!_dc) {
        
        _dc = [[DistrictPickerVC alloc] initWithStyle:DistrictPickerWithStateAndCityAndDistrict delegate:self];
        
    }
    _dc.pTitle.text = @"所在地区";
    [_dc show];
    return NO;
}


#pragma mark -
#pragma mark - DistrictPickerVCDelegate
- (void)districtPicker:(DistrictPickerVC *)picker didPickDistrict:(NSString *)districtStr{
    
    __inputField.text = districtStr;

}
- (void)districtPicker:(DistrictPickerVC *)picker didFinishWithDistrict:(NSString *)districtStr{
    
    __inputField.text = districtStr;

}

@end











