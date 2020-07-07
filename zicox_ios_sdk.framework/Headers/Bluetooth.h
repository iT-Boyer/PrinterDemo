#ifndef Bluetooth_h
#define Bluetooth_h

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#include <CoreGraphics/CGImage.h>
#import <UIKit/UIKit.h>
#import "zlib.h"
#define MAX_DATA_SIZE (1024*1000)
//#define MAX_DATA_SIZE (1024*20)
typedef void(^BLOCK_CALLBACK_SCAN_FIND)(CBPeripheral*);

@interface Bluetooth : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    Byte _buffer[MAX_DATA_SIZE];
    int _offset;
    int _sendedDataLength;
    int leftDataLength;
    CGImageRef CGImage;
    NSMutableArray * array1;
    int isconnect;
}



+(NSData*) gzipData:(NSData*)pUncompressedData;  //压缩
+(NSData*) ungzipData:(NSData *)compressedData;  //解压缩
//@property(assign)WrapDatas *wrap;
-(void) print_status_detect;
-(int)print_status_get:(int)timeout;

- (void)scanStart:(BLOCK_CALLBACK_SCAN_FIND)callback;
- (void)scanStop;
- (bool)open:(CBPeripheral*)peripheral;
- (void)close;
- (bool)write:(NSString*)strData;
- (bool)writeData:(NSData*)data;
- (void)flushRead;
- (bool)readBytes:(BytePtr)data len:(int)len timeout:(int)timeout;

+(NSData*) gzipData:(NSData*)pUncompressedData;  //压缩
-(void)StartPage:(int) pageWidth  pageHeight:(int)pageHeight skip:(bool)skip rotate:(int)rotate;
-(void)end;
-(void)zp_drawText:(int)x y:(int)y text:(NSString*)text font:(int)fontsize fontsize:(int)fontsize bold:(int)bold rotate:(int)rotate;
-(void)zp_drawLine:(int)startPointX startPiontY:(int)startPointY endPointX:(int)endPointX endPointY:(int)endPointY width:(int)width;
-(void)zp_darw1D_barcode:(int)x y:(int)y  height:(int)height text:(NSString*)text;
-(void) zp_darwQRCode:(int)x y:(int)y unit_width:(int)unit_width  text:(NSString*)text;
-(void)zp_darwRect:(int)left top:(int)top right:(int)right bottom:(int)bottom width:(int)width;
-(bool) drawBitmap:(UIImage*) image x:(float) x y:(float)  y widths:(float) widths heihts:( float) heights rotations:(int)rotations gotopaper:(int )gotopaper;
-(bool) DrawBigBitmap:(UIImage*) image  gotopaper:(int )gotopaper;
-(void) drawImg:(UIImage*) image x:(int) x y:(int)  y;//小图

@property (getter=getDataLength,readonly)int dataLength;
-(BOOL) addData:(Byte *)data length:(int)length;
-(BOOL) addByte:(Byte)byte;
-(BOOL) addShort:(ushort)data;
-(BOOL) add:(NSString *)text;
-(NSData*) getData:(int)sendLength;
-(void) reset;
-(BOOL) addC:(NSString *)text;

@end


    

#endif /* Bluetooth_h */





