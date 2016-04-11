//
//  ZLImageEditViewController.m
//  GPUImageDemo
//
//  Created by 张磊 on 16/4/11.
//  Copyright © 2016年 Leoi. All rights reserved.
//

#import "ZLImageEditViewController.h"
#import <OpenGLES/EAGL.h>

#import "GPUImage.h"

@interface ZLImageEditViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *filteredImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) UIImage *filteredImage;



@end

@implementation ZLImageEditViewController
{
    GPUImageOutput<GPUImageInput> *filter;
}
#pragma mark - Life Cycle
-(void)viewWillAppear:(BOOL)animated
{
    [self.nav setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.filteredImageView.image = self.originImage;
    // Do any additional setup after loading the view.
}
- (IBAction)filered:(UITapGestureRecognizer *)sender {
    
    filter = [[GPUImageWhiteBalanceFilter alloc] init];
    [(GPUImageWhiteBalanceFilter *)filter setTemperature:4000];
    _filteredImage =[filter imageByFilteringImage:self.originImage];
    self.filteredImageView.image = _filteredImage;
    
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

@end
