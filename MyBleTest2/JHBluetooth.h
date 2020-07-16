//
//  JHBluetooth.h
//  MyBleTest2
//
//  Created by jhmac on 2020/7/16.
//  Copyright © 2020 mycj.wwd. All rights reserved.
//

#import <zicox_ios_sdk/zicox_ios_sdk.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHBluetooth : Bluetooth
@property (strong, nonatomic) NSString *macAddr;
@end

NS_ASSUME_NONNULL_END
