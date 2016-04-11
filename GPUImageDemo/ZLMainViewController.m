//
//  ZLMainViewController.m
//  GPUImageDemo
//
//  Created by 张磊 on 16/4/8.
//  Copyright © 2016年 Leoi. All rights reserved.
//

#import "ZLMainViewController.h"
#import "ZLImageEditViewController.h"
@interface ZLMainViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIImage *originImage;

@end

static NSString *const imageEditSegueId = @"showImageEdit";
static NSString *const cameraEditSegueId = @"showVideoEdit";
static NSString *const videoEditSegueId = @"showCameraEdit";

@implementation ZLMainViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.nav setNavigationBarHidden:YES animated:animated];
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Response
- (IBAction)ImageEdit:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;

    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    [self presentViewController:picker animated:YES completion:nil];

}
- (IBAction)VideoEdit:(id)sender {
}

- (IBAction)CameraEdit:(id)sender {
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
       
        picker.sourceType = sourceType;
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:picker animated:YES completion:nil];
        
    }
}

#pragma mark NavgationDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        _originImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [picker dismissViewControllerAnimated:NO completion:nil];
        [self performSegueWithIdentifier:imageEditSegueId sender:self];
    }else
    {
    [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:imageEditSegueId]) {
        ZLImageEditViewController *editViewController = (ZLImageEditViewController *)segue.destinationViewController;
        editViewController.originImage = _originImage;
    }
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    
}


@end
