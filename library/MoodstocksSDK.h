//
//  Copyright 2010 Moodstocks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MImagePickerControllerDelegate;

@interface MImagePickerController : UIViewController {
    id<MImagePickerControllerDelegate> delegate;
}

@property (nonatomic, assign) id <MImagePickerControllerDelegate> delegate;

- (id)initWithKey:(NSString *)aKey andSecret:(NSString *)aSecret;

@end

@protocol MImagePickerControllerDelegate<NSObject>
- (void)imagePickerController:(MImagePickerController*)picker didFinishQueryingWithInfo:(NSDictionary *)info;
- (void)imagePickerControllerDidCancel:(MImagePickerController*)picker;
@end