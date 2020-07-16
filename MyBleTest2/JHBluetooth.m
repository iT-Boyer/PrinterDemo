//
//  JHBluetooth.m
//  MyBleTest2
//
//  Created by jhmac on 2020/7/16.
//  Copyright © 2020 mycj.wwd. All rights reserved.
//

#import "JHBluetooth.h"

@implementation JHBluetooth

//- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
//    for (CBService *service in peripheral.services) {
//        [peripheral discoverCharacteristics:nil forService:service];
//    }
//}
//- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
//    for (CBCharacteristic *characteristic in service.characteristics) {
//        if ([characteristic.UUID.UUIDString isEqualToString:@"585A"]) {
//            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//            [peripheral readValueForCharacteristic:characteristic];
//        }
//    }
//}
//-(void)peripheral:(CBPeripheral*)peripheral didUpdateValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error
//{
//    NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
//    NSLog(@"MAC地址是macString:%@",value);
//}



- (void)centralManager:(CBCentralManager*)central didDiscoverPeripheral:(CBPeripheral*)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber*)RSSI
{
    NSData *data = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
    NSString *mac = [self dataToHexString:data];
    if ([mac hasPrefix:@"5a58"] && data.length >= 8) {
       
        NSData *macdata = [data subdataWithRange:NSMakeRange(2, 6)];
        NSMutableString *allMac = [NSMutableString string];
   
        for (int i = 0; i < macdata.length; i++) {
            NSData *dt = [macdata subdataWithRange:NSMakeRange(i, 1)];
            NSString *str = [[self dataToHexString:dt]uppercaseString];
            if (i == 0) {
                [allMac appendString:str];
            }else{
                [allMac appendString:@":"];
                [allMac appendString:str];
            }
        }
        NSLog(@"mac地址：%@",allMac);
    }
    [super centralManager:central didDiscoverPeripheral:peripheral advertisementData:advertisementData RSSI:RSSI];
}

#pragma -mark 十六进制转换成字符串
-(NSString*)dataToHexString:(NSData*)data {
    if (data == nil) {
        return @"";
    }
    Byte *dateByte = (Byte *)[data bytes];
    
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",dateByte[i]&0xff]; ///16进制数
        if([newHexStr length]==1){
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}

@end
