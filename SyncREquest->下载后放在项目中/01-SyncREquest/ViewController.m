//
//  ViewController.m
//  01-SyncREquest
//
//  Created by qingyun on 15/12/15.
//  Copyright © 2015年 qingyun. All rights reserved.
//


#define kSongURLStr   @"http://imgsrc.baidu.com/baike/pic/item/b812c8fcc3cec3fd6724bf03d588d43f879427a9.jpg"
#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
@property (nonatomic, strong)NSMutableData *songData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
   
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)xiazai:(UIButton *)sender {
    // 1. URL（将网址初始化）
    NSURL *url = [NSURL URLWithString:kSongURLStr];
    
    // 2. Request（网络请求）[第一个参数请求访问路径，第二个是缓存协议，第三个是网络请求超时时间]
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:60];

    // 3 .Connection（链接到服务器）
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) ];
    image.image = [UIImage imageNamed:@"/Users/qingyun/Desktop/WTT/Code/1215/（练习02）-SyncREquest/image.jpg"];
     [self.view addSubview:image];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, 300, 25)];
    [lable setText:@"徐璐"];
    [image addSubview:lable];
}
#pragma mark  --NSURLConnectionData  Delegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //如果响应成功，则申请内存
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        _songData = [NSMutableData data];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //如果收到数据，在songData后面追加数据
    static int count = 0;
    [_songData appendData:data];
    NSLog(@"<%d>:%@",count++,data);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //将数据保存到文件
    [_songData writeToFile:@"/Users/qingyun/Desktop/WTT/Code/1215/（练习02）-SyncREquest/image.jpg" atomically:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
