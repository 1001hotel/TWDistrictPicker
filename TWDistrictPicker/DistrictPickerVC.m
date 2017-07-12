//
//  DistrictPickerVC.m
//  MicroFinance
//
//  Created by passwordis123 on 11/19/14.
//  Copyright (c) 2014 SPMach. All rights reserved.
//

#import "DistrictPickerVC.h"


@implementation DistrictPickerVC


#pragma mark
#pragma mark - lifecycle
-(id)initWithStyle:(DistrictPickerStyle)pickerStyle delegate:(id <DistrictPickerPickerDelegate>)delegate{
    
    if (self = [super initWithNibName:@"DistrictPickerVC" bundle:[NSBundle mainBundle]]) {
        
        if (delegate) {
            
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height);
            _districtPicker.frame = CGRectMake(_districtPicker.frame.origin.x, _districtPicker.frame.origin.y, [UIScreen mainScreen].bounds.size.width, _districtPicker.frame.size.height);
            _delegate = delegate;
        }
        _pickerStyle = pickerStyle;
        
        //加载数据
        if (_pickerStyle == DistrictPickerWithStateAndCityAndDistrict) {
            
            provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areaofchina.plist" ofType:nil]];
            cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
            
            _locate = [[Location alloc] init];
            _locate.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
            _locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
            
            areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
            if (areas.count > 0) {
                
                _locate.district = [areas objectAtIndex:0];
            } else{
                
                _locate.district = @"";
            }
            
        } else{
            
            provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
            cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
            _locate.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
            _locate.city = [cities objectAtIndex:0];
        }
    }
    return self;
}
-(void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height);
    _districtPicker.frame = CGRectMake(_districtPicker.frame.origin.x, _districtPicker.frame.origin.y, [UIScreen mainScreen].bounds.size.width, _districtPicker.frame.size.height);
    // Do any additional setup after loading the view from its nib.
}



#pragma mark
#pragma mark - public
-(void)showInView:(UIView *)view{
    
    
    
    self.view.frame = CGRectMake(0, view.frame.size.height, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height);
    [view addSubview:self.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, view.frame.size.height - self.view.frame.size.height, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height);
    }];
    
}
-(void)show{
    
    [self.view endEditing:YES];
    if (![self.view superview]) {
        [[[UIApplication sharedApplication] windows].lastObject addSubview:self.view];
        
        CGRect pos0 = CGRectMake(0,[[UIScreen mainScreen] bounds].size.height,
                                 [[UIScreen mainScreen] bounds].size.width,
                                 self.view.frame.size.height);
        CGRect pos1 = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - self.view.frame.size.height,
                                 [[UIScreen mainScreen] bounds].size.width,
                                 self.view.frame.size.height);
        self.view.frame = pos0;
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.view.frame = pos1;
                             self.view.hidden = NO;
                         }
                         completion:^(BOOL finished) {
                             if ([_delegate respondsToSelector:@selector(districtPicker:didPickDistrict:)]) {
                                 
                                 NSString *districtStr = @"";
                                 if (_locate.district.length != 0) {
                                     
                                     districtStr = [NSString stringWithFormat:@"%@省%@市%@",_locate.state,_locate.city,_locate.district];
                                 }
                                 else{
                                     
                                     districtStr = [NSString stringWithFormat:@"%@市%@区%@",_locate.state,_locate.city,_locate.district];
                                 }
                                 if ([_locate.state isEqualToString:@"国外"]) {
                                     
                                     districtStr = [NSString stringWithFormat:@"%@%@%@",_locate.state,_locate.city,_locate.district];
                                 }
                                 [_delegate districtPicker:self didPickDistrict:districtStr];
                             }
                         }];
    }
}
-(IBAction)done{
    
    if ([_delegate respondsToSelector:@selector(districtPicker:didPickDistrict:)]) {
        
        NSString *districtStr = @"";
        if (_locate.district.length != 0) {
            
            districtStr = [NSString stringWithFormat:@"%@省%@市%@",_locate.state,_locate.city,_locate.district];
        }
        else{
            
            districtStr = [NSString stringWithFormat:@"%@市%@区%@",_locate.state,_locate.city,_locate.district];
        }
        if ([_locate.state isEqualToString:@"国外"]) {
            
            districtStr = [NSString stringWithFormat:@"%@%@%@",_locate.state,_locate.city,_locate.district];
        }
        [_delegate districtPicker:self didPickDistrict:districtStr];
    }
    
    if ([self.view superview]) {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.view.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, [UIScreen mainScreen].bounds.size.height + self.view.bounds.size.height);
                         }
                         completion:^(BOOL finished) {
                             self.view.hidden = YES;
                             [self.view removeFromSuperview];
                             if ([_delegate respondsToSelector:@selector(districtPicker:didFinishWithDistrict:)]) {
                                 
                                 NSString *districtStr = @"";
                                 if (_locate.district.length != 0) {
                                     
                                     districtStr = [NSString stringWithFormat:@"%@省%@市%@",_locate.state,_locate.city,_locate.district];
                                 }
                                 else{
                                     
                                     districtStr = [NSString stringWithFormat:@"%@市%@区%@",_locate.state,_locate.city,_locate.district];
                                 }
                                 if ([_locate.state isEqualToString:@"国外"]) {
                                     
                                     districtStr = [NSString stringWithFormat:@"%@%@%@",_locate.state,_locate.city,_locate.district];
                                 }
                                 [_delegate districtPicker:self didFinishWithDistrict:districtStr];
                             }
                         }];
    }
}


#pragma mark
#pragma mark - PickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if (_pickerStyle == DistrictPickerWithStateAndCityAndDistrict) {
        
        return 3;
    }
    else{
        
        return 2;
    }
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    switch (component) {
            
        case 0:
            return [provinces count];
            break;
            
        case 1:
            return [cities count];
            break;
            
        case 2:
            if (_pickerStyle == DistrictPickerWithStateAndCityAndDistrict) {
                
                return [areas count];
                break;
            }
            
        default:
            return 0;
            break;
            
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (_pickerStyle == DistrictPickerWithStateAndCityAndDistrict) {
        
        switch (component) {
                
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"state"];
                break;
                
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"city"];
                break;
                
            case 2:
                if ([areas count] > 0) {
                    
                    return [areas objectAtIndex:row];
                    break;
                }
                
            default:
                return  @"";
                break;
                
        }
    }
    else{
        
        switch (component) {
                
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"state"];
                break;
                
            case 1:
                return [cities objectAtIndex:row];
                break;
                
            default:
                return @"";
                break;
                
        }
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (_pickerStyle == DistrictPickerWithStateAndCityAndDistrict) {
        
        switch (component) {
                
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [_districtPicker selectRow:0 inComponent:1 animated:YES];
                [_districtPicker reloadComponent:1];
                
                areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
                [_districtPicker selectRow:0 inComponent:2 animated:YES];
                [_districtPicker reloadComponent:2];
                
                _locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                _locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                if ([areas count] > 0) {
                    
                    _locate.district = [areas objectAtIndex:0];
                }
                else{
                    
                    _locate.district = @"";
                }
                break;
                
            case 1:
                areas = [[cities objectAtIndex:row] objectForKey:@"areas"];
                [_districtPicker selectRow:0 inComponent:2 animated:YES];
                [_districtPicker reloadComponent:2];
                
                _locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
                if ([areas count] > 0) {
                    
                    _locate.district = [areas objectAtIndex:0];
                }
                else{
                    
                    _locate.district = @"";
                }
                break;
                
            case 2:
                if ([areas count] > 0) {
                    
                    _locate.district = [areas objectAtIndex:row];
                } else{
                    
                    _locate.district = @"";
                }
                break;
                
            default:
                break;
        }
    }
    else{
        
        switch (component) {
                
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [_districtPicker selectRow:0 inComponent:1 animated:YES];
                [_districtPicker reloadComponent:1];
                
                _locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                _locate.city = [cities objectAtIndex:0];
                break;
                
            case 1:
                _locate.city = [cities objectAtIndex:row];
                break;
                
            default:
                break;
        }
    }
    
    if ([_delegate respondsToSelector:@selector(districtPicker:didPickDistrict:)]) {
        
        NSString *districtStr = @"";
        if (_locate.district.length != 0) {
            
            districtStr = [NSString stringWithFormat:@"%@省%@市%@",_locate.state,_locate.city,_locate.district];
        }
        else{
            
            districtStr = [NSString stringWithFormat:@"%@市%@区%@",_locate.state,_locate.city,_locate.district];
        }
        if ([_locate.state isEqualToString:@"国外"]) {
            
            districtStr = [NSString stringWithFormat:@"%@%@%@",_locate.state,_locate.city,_locate.district];
        }
        [_delegate districtPicker:self didPickDistrict:districtStr];
    }
}


@end














