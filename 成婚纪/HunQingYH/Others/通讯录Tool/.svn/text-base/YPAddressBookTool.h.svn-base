//
//  YPAddressBookTool.h
//  HunQingYH
//
//  Created by Else丶 on 2018/11/12.
//  Copyright © 2018 YanpengLee. All rights reserved.
//

#import <Foundation/Foundation.h>
/// iOS 9前的框架
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
/// iOS 9的新框架
#import <ContactsUI/ContactsUI.h>

#define Is_up_Ios_9    ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessBlock) (NSDictionary *object);

@interface YPAddressBookTool : NSObject<ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate>

+ (instancetype)yp_shareAddressBookTool;

@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, copy) SuccessBlock successBlock;

- (void)JudgeAddressBookPower;

@end

NS_ASSUME_NONNULL_END
