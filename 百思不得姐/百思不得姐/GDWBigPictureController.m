//
//  GDWBigPictureController.m
//  百思不得姐
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "GDWBigPictureController.h"
#import "GDWTopicModel.h"
#import <Photos/Photos.h>

#import "SVProgressHUD.h"

@interface GDWBigPictureController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/* 图片 */
@property (nonatomic,weak) UIImageView *imageView;


@end

@implementation GDWBigPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    CGFloat screenH=[UIScreen   mainScreen].bounds.size.height;


    //创建imageView
    UIImageView *imageView=[[UIImageView  alloc]   init];
    self.imageView=imageView;
    
    //计算imageView尺寸.
    CGFloat  x=0;
    CGFloat  y=0;
    CGFloat  w=self.scrollView.width;
    CGFloat  h=w/self.topic.width*self.topic.height;
    if (h<screenH) {//图片高度大于屏幕高度.
        y=(screenH-h)*.5;
    }else{
    
        self.scrollView.contentSize=CGSizeMake(0, h);
    }
    
    imageView.frame=CGRectMake(x, y, w, h);
    imageView.image=self.image;
    //imageView.frame=CGRectMake(100, 100, 200, 200);
    //imageView.image=[UIImage  imageNamed:@"Profile_AddV_authen"];
    [self.scrollView  insertSubview:imageView atIndex:0];
    
    
    //缩放图片.
    self.scrollView.delegate=self;
    CGFloat  scale=self.topic.width/w;
    if (scale>1) {
        self.scrollView.maximumZoomScale=scale;
    }


}
#pragma mark -   UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return self.imageView;
}



#pragma mark - dismiss.
- (IBAction)dismissClick:(UIButton *)sender {
    //取消madal控制器.
    [self  dismissViewControllerAnimated:YES completion:nil];
}


/*
 #import <Photos/PHPhotoLibrary.h>
 #import <Photos/PhotosTypes.h>
 
 #import <Photos/PHObject.h>
 #import <Photos/PHAsset.h>
 #import <Photos/PHCollection.h>
 
 #import <Photos/PHFetchOptions.h>
 #import <Photos/PHFetchResult.h>
 
 #import <Photos/PHChange.h>
 
 #import <Photos/PHAssetChangeRequest.h>
 #import <Photos/PHAssetCreationRequest.h>
 #import <Photos/PHAssetCollectionChangeRequest.h>
 #import <Photos/PHCollectionListChangeRequest.h>
 */
static  NSString * const  PHCollectionName=@"雨浩天";


#pragma mark - 保存图片到相册.
- (IBAction)saveClick:(UIButton *)sender {
    
    //判断相册权限
    PHAuthorizationStatus  status=[PHPhotoLibrary  authorizationStatus];
    if (status==PHAuthorizationStatusRestricted) {//app没有权限,用户也无法授权.
        GDWLog(@"app没有权限访问相册,用户也无法授权.")
    } else if(status==PHAuthorizationStatusDenied){//用户拒绝app访问相册.
        GDWLog(@"用户拒绝app访问相册")
    }else  if(status==PHAuthorizationStatusNotDetermined){//用户还没有决定是否授权app访问相册.
        GDWLog(@"用户还没有决定是否授权app访问相册.")
        [self  savePhoto];
    }else if(status==PHAuthorizationStatusAuthorized){//用户授权app访问相册.
        GDWLog(@"用户授权app访问相册.")
        [self  savePhoto];
    }
}

#pragma mark - 保存图片到相册
- (void)savePhoto{
    
    
    __block  NSString *assetID=nil;
    [[PHPhotoLibrary  sharedPhotoLibrary]  performChanges:^{
        // 1.新建一个PHAssetCreationRequest对象, 保存图片到"相机胶卷"\
             返回PHAsset(图片)的字符串标识
        UIImage *image=self.image;
        assetID = [PHAssetCreationRequest  creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        if (error) {
            GDWLog(@"保存到相机胶卷失败");
            return ;
        }
        
        //2.保存到相机胶卷成功\
            获取相册.
        PHAssetCollection *collection = [self  getDesiredCollectionByName:PHCollectionName];
        
        //3.创建的图片保存到相册.
        [[PHPhotoLibrary   sharedPhotoLibrary]   performChanges:^{
            
            //3.1获取图片
            PHAsset *asset = [PHAsset  fetchAssetsWithLocalIdentifiers:@[assetID]  options:nil].firstObject;
            //3.2保存图片到相册.
          PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest   changeRequestForAssetCollection:collection];
            [request  addAssets:@[asset]];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                GDWLog(@"图片保存到相册失败")
                return ;
            }
            [[NSOperationQueue  mainQueue]  addOperationWithBlock:^{
                [SVProgressHUD   showSuccessWithStatus:@"保存到相册成功"];
            }];
            
        }];
        
        
        
    }];
}

#pragma mark 获取相册的方法
- (PHAssetCollection *)getDesiredCollectionByName:(NSString *)collectionName
{
    
    //1.所需的相册是否存在.
    PHFetchResult *result = [PHAssetCollection  fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection  * collection in result) {
        if ([collection.localizedTitle isEqualToString:collectionName]) {
            return collection;
        }
        
    }
    //2.没有找到,创建所需相册\
        这个方法会在相册创建完毕后才会返回

    __block  NSString * collectionID=nil;
    [[PHPhotoLibrary   sharedPhotoLibrary]   performChangesAndWait:^{
        
       collectionID = [PHAssetCollectionChangeRequest  creationRequestForAssetCollectionWithTitle:collectionName].placeholderForCreatedAssetCollection.localIdentifier;
        
    } error:nil];
    //根据标识符,获取所需的相册.
    PHAssetCollection *collection = [PHAssetCollection   fetchAssetCollectionsWithLocalIdentifiers:@[collectionID] options:nil].firstObject;

    return collection;
}




#pragma mark 方案1
//- (IBAction)saveClick:(UIButton *)sender {
//    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//}
////保存相册,会回调的方法.(方法名可以自定义,必须有下面的3个参数,形式)
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    if (!error) {//保存成功
//        [SVProgressHUD  showSuccessWithStatus:@"图片保存成功"];
//
//    } else {//保存失败
//        [SVProgressHUD  showErrorWithStatus:@"图片保存失败,请您查看相册的写入权限是否开启"];
//    }
//}
@end
