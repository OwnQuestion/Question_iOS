//
//  HWImagePickerWidget.m
//  TemplateTest
//
//  Created by caijingpeng.haowu on 15/5/7.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import "HWImagePickerWidget.h"
#import "AppDelegate.h"

@implementation HWImagePickerWidget

@synthesize presentViewController;
@synthesize actionSheetShowInView;
@synthesize delegate;
@synthesize imgPic;

- (id)init
{
    self = [super init];
    if (self)
    {
        AppDelegate *appDel = SHARED_APP_DELEGATE;
        self.presentViewController = appDel.window.rootViewController;
    }
    return self;
}

- (void)chooseImagePicker:(id)sender
{
    if (self.actionSheetShowInView != nil)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
        [actionSheet showInView:self.actionSheetShowInView];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        // 拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            self.imgPic = [[UIImagePickerController alloc] init];
            self.imgPic.sourceType = UIImagePickerControllerSourceTypeCamera;
            imgPic.delegate = self;
            [self.presentViewController presentViewController:self.imgPic animated:YES completion:nil];
        }
        else
        {
            [Utility showToastWithMessage:@"拍照功能不可用" inView:self.actionSheetShowInView];
        }
    }
    else if (buttonIndex == 2)
    {
        // 相册
        self.imgPic = [[UIImagePickerController alloc] init];
        self.imgPic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imgPic.delegate = self;
        [self.presentViewController presentViewController:self.imgPic animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (image != nil)
    {
        
        if (delegate != nil && [delegate respondsToSelector:@selector(imagePickerWidget:didFinishSelectImage:)] == YES)
        {
            [delegate imagePickerWidget:self didFinishSelectImage:image];
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
