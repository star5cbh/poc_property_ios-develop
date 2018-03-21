//
//  ViewController.m
//  PropertyPOC
//
//  Created by STAR on 2018/3/21.
//  Copyright © 2018年 peersafe. All rights reserved.
//

#import "ViewController.h"
#import "FCPPSDK.h"
#import "MBProgressHUD.h"
#import "UIImage+FCExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightItemTitle:@"选择照片" action:@selector(changeImage)];
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - Navigation_Height)];
//    bg.backgroundColor = kAppMainColor;
    [self.view addSubview:bg];

    self.imageView = [[UIImageView alloc] init];
    self.tokenLabel = [[UILabel alloc] init];
    self.tokenLabel.textColor = kAppMainColor;
    self.tokenLabel.numberOfLines = 0;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bg addSubview:self.imageView];
    [bg addSubview:self.tokenLabel];
    self.imageView.sd_layout
    .topSpaceToView(bg, 30)
    .centerXIs(Main_Screen_Width/2.0)
    .widthIs(100)
    .heightIs(100);
    self.tokenLabel.sd_layout
    .topSpaceToView(self.imageView, 30)
    .centerXEqualToView(bg)
    .widthIs(Main_Screen_Width)
    .heightIs(100);
    
    [self begainCompare:nil];
}

- (void)handleImage:(UIImage *)image{
    FCPPFaceDetect *faceDetect = [[FCPPFaceDetect alloc] initWithImage:image];
    self.imageView.image = faceDetect.image;
    self.image = faceDetect.image;
    
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //需要获取的属性
    NSArray *att = @[@"gender",@"age",@"headpose",@"smiling",@"blur",@"eyestatus",@"emotion",@"facequality",@"ethnicity"];
    [faceDetect detectFaceWithReturnLandmark:YES attributes:att completion:^(NSDictionary *info, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        weakSelf.tableView.contentOffset = CGPointMake(0, -64);
//        [weakSelf.dataArray removeAllObjects];
//        _tokenLabel.text =
        if (info) {
            NSArray *array = info[@"faces"];
            if (array.count > 0) {
                self.imageView.image = faceDetect.image;
                NSString *tokens = @"";
                for (NSDictionary *dic in array) {
                    tokens  = [[tokens stringByAppendingString: [dic valueForKey: @"face_token"]] stringByAppendingString:@"\n"];
                }
                weakSelf.tokenLabel.text = tokens;
//                //绘制关键点和矩形框
//                [weakSelf handleImage:image withInfo:array];
//
//                //显示每个人脸的详细信息
//                [weakSelf.dataArray addObjectsFromArray:array];
//                //显示json
//                [weakSelf showResult:info];
            }else{
                [weakSelf showDeatilHint:@"没有检测到人脸"];
            }
        }else{
//            [weakSelf showError:error];
        }
//        [weakSelf.tableView reloadData];
    }];
    
}


- (void)changeImage{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"修改图片" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    
    UIAlertAction *libAction = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = weakSelf;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [weakSelf presentViewController:picker animated:YES completion:nil];
    }];
    [alertVC addAction:libAction];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = weakSelf;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [weakSelf presentViewController:picker animated:YES completion:nil];
    }];
    [alertVC addAction:cameraAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancelAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self handleImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)showResult:(id)result{
    if (result) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [self showContent:str];
    }
}

- (void)showError:(NSError *)error{
    NSData *errorData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
    if (errorData) {
        NSString *errorStr = [[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];
        [self showContent:errorStr];
    }else{
        [self showContent:@"网络请求失败"];
    }
}

- (void)begainCompare:(UIButton *)sender {
    
    FCPPFace *face1 = [[FCPPFace alloc] initWithFaceToken:@"5f15294a8c80bbc0858b013b477f5e61"];
    FCPPFace *face2 = [[FCPPFace alloc] initWithFaceToken:@"e8f031492d1cbd6fbc2523e41a2b5cda"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [face1 compareFaceWithOther:face2 completion:^(id info, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (info) {
//            NSArray *face1 = info[@"faces1"];
//            NSArray *face2 = info[@"faces2"];
//            if (face1.count == 0) {
//                self.textView.text = @"图片1没有检测到人脸";
//                return ;
//            }
//            if(face2.count == 0){
//                self.textView.text = @"图片2没有检测到人脸";
//                return;
//            }
            
            NSNumber *confidence = info[@"confidence"];
            NSDictionary *thresholds = info[@"thresholds"];
            NSMutableString *string = [NSMutableString string];
            [string appendFormat:@"置信度: %@\n",confidence];
            [string appendFormat:@"不同误识率下的置信度阈值:\n"];
            [thresholds enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [string appendFormat:@"%@ : %@\n",key,obj];
            }];
            
            [string appendString:@"\n比对结果:\n"];
            
            CGFloat confidenceValue = confidence.floatValue;
            CGFloat maxThreshold = [thresholds[@"1e-5"] floatValue];
            CGFloat midThreshold = [thresholds[@"1e-4"] floatValue];
            CGFloat minThreshold = [thresholds[@"1e-3"] floatValue];
            
            //用户可根据自己的业务场景,选择不同的阈值.要求严格选择max,宽松则选择min
            if (confidenceValue >= maxThreshold) {
                [string appendString:@"是否是同一个人: 可能性高"];
            }else if (confidenceValue <= minThreshold){
                [string appendString:@"是否是同一个人: 可能性低"];
            }else{
                [string appendString:@"是否是同一个人: 可能性一般"];
            }
            
//            [self handleWithImageView:self.imageView1 withInfo:info[@"faces1"]];
//            [self handleWithImageView:self.imageView2 withInfo:info[@"faces2"]];
        }else{
            NSData *errorData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            if (errorData) {
                NSString *errorStr = [[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];
//                self.textView.text = errorStr;
            }else{
//                self.textView.text = @"网络请求失败";
            }
        }
    }];
}

- (void)showContent:(NSString *)content{
//    if (content.length == 0) {
//        self.tableView.tableFooterView = [[UIView alloc] init];
//        return;
//    }
//    UILabel *label = [[UILabel alloc] init];
//    label.numberOfLines = 0;
//    label.text = content;
//    label.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 0);
//    [label sizeToFit];
//
//    self.tableView.tableFooterView = label;
}
#pragma mark- delegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
