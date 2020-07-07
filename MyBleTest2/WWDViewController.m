//
//  WWDViewController.m
//  MyBleTest2
//
//  Created by maginawin on 14-8-11.
//  Copyright (c) 2014年 mycj.wwd. All rights reserved.
//

#import "WWDViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface WWDViewController ()

@property (strong, nonatomic) Bluetooth* bluetooth;
@property (strong, nonatomic) CBPeripheral* peripheral;
@property (strong, nonatomic) NSMutableArray* listDevices;
@property (strong, nonatomic) NSMutableString* listDeviceInfo;
@end

@implementation WWDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.listDeviceInfo = [NSMutableString stringWithString:@""];
    self.listDevices = [NSMutableArray array];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;


    self.bluetooth = [[Bluetooth alloc]init];
}

- (IBAction)connDevice:(id)sender{
    if(_listDevices != nil){
        _listDevices = nil;
        _listDevices = [NSMutableArray array];
        [_tableView reloadData];
    }
    
    BLOCK_CALLBACK_SCAN_FIND callback =
    ^( CBPeripheral*peripheral)
    {
        [self.listDevices addObject:peripheral];
        NSLog(@"scan find: %@",self.listDevices );
        [_tableView reloadData];
    };
    
    [self.bluetooth scanStart:callback];
    
    double delayInSeconds = 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds* NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.bluetooth scanStop];
    });
}





//tableview的方法,返回section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//tableview的方法,返回rows(行数)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listDevices.count;
}

//tableview的方法,返回cell的view
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //为表格定义一个静态字符串作为标识符
    static NSString* cellId = @"cellId";
    //从IndexPath中取当前行的行号
    NSUInteger rowNo = indexPath.row;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    UILabel* labelName = (UILabel*)[cell viewWithTag:1];
    UILabel* labelUUID = (UILabel*)[cell viewWithTag:2];

    
    labelName.text = [[_listDevices objectAtIndex:rowNo] name];
     NSString* uuid = [NSString stringWithFormat:@"%@", [[_listDevices objectAtIndex:rowNo] identifier]];
    uuid = [uuid substringFromIndex:[uuid length] - 13];///////////////////////mac
    NSLog(@"%@", uuid);
    labelUUID.text = uuid;
    return cell;
}

//tableview的方法,点击行时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   self.peripheral =[_listDevices objectAtIndex:indexPath.row];
}



- (void)wrapPrintDatas
{
    
   
    [self.bluetooth StartPage:576 pageHeight:720 skip:false rotate:0];// skip:true为定位到标签，false为不定位 ;==--p0p-p---rotate:0\90\180\270
    [self.bluetooth zp_darwRect:2 top:2 right:400 bottom:600 width:1];
    [self.bluetooth zp_drawText:0 y:20 text:@"上海芝柯打印技术" font:24 fontsize:2 bold:0 rotate:0];
    [self.bluetooth zp_drawLine:2 startPiontY:200 endPointX:400 endPointY:200 width:2 ];
    [self.bluetooth zp_darw1D_barcode:10 y:240 height:100 text:@"1234567890"];
    [self.bluetooth zp_darwQRCode:10 y:400 unit_width:5 text:@"12234567890"];
    [self.bluetooth end];

    
}



- (IBAction)print:(id)sender {
    

   /*
    [self.bluetooth open:self.peripheral];
    [self.bluetooth flushRead];
    int status=0;
    for(int i=0;i<10;i++){
    [self.bluetooth drawBitmap:[UIImage imageNamed:@"11111.png"]  x:200 y:0 widths:280  heihts:280 rotations:0 gotopaper:0];
    [self.bluetooth reset];
    [self.bluetooth print_status_detect];
     status=[self.bluetooth print_status_get:4000];
        NSLog(@"status------------------%d",status);
    }
    if(status==0)
    [self.bluetooth close];
    */
    [self.bluetooth open:self.peripheral];
    [self wrapPrintDatas];
    [self sendPrintData];
    [self.bluetooth reset];
    [self.bluetooth print_status_detect];
    int status=[self.bluetooth print_status_get:3000];
    if(status==1)
    {
        NSLog(@"打印机缺纸" );
        
    }
    if(status==2)
    {
        NSLog(@"打印机开盖" );
        
    }
    if(status==0)
    {
        NSLog(@"打印机正常" );
        
    }
    [self.bluetooth close];
    
}



-(void) sendPrintData{
    int r = self.bluetooth.dataLength;
    NSData *data = [self.bluetooth getData:r];
    [self.bluetooth writeData:data];
    
  /*
    Byte a[2] ;
    a[0]=0x1d;a[1]=0x0c;
    NSData *adata = [[NSData alloc] initWithBytes:a length:2];
    [ self.bluetooth writeData:adata];
  */
    
}




@end
