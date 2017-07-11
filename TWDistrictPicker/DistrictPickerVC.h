//
//  DistrictPickerVC.h
//  MicroFinance
//
//  Created by passwordis123 on 11/19/14.
//  Copyright (c) 2014 SPMach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"


typedef enum {
    
    DistrictPickerWithStateAndCity,
    DistrictPickerWithStateAndCityAndDistrict
} DistrictPickerStyle;



@class DistrictPickerVC;

@protocol DistrictPickerPickerDelegate;

@interface DistrictPickerVC : UIViewController
<UIPickerViewDelegate,
UIPickerViewDataSource
>{

    IBOutlet UIPickerView *_districtPicker;
    id <DistrictPickerPickerDelegate> _delegate;
    DistrictPickerStyle _pickerStyle;
    Location *_locate;
    NSArray *provinces, *cities, *areas;
}


@property (retain, nonatomic) IBOutlet UILabel *pTitle;


-(id)initWithStyle:(DistrictPickerStyle)pickerStyle delegate:(id <DistrictPickerPickerDelegate>)delegate;
-(void)show;
-(IBAction)done;


@end


@protocol DistrictPickerPickerDelegate <NSObject>

@optional
-(void)pickerDidChaneStatus:(DistrictPickerVC *)picker;
@optional
-(void)districtPicker:(DistrictPickerVC *)picker didPickDistrict:(NSString *)districtStr;
@optional
-(void)districtPicker:(DistrictPickerVC *)picker didFinishWithDistrict:(NSString *)districtStr;

@end








