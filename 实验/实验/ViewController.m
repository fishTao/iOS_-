//
//  ViewController.m
//  实验
//
//  Created by qingyun on 15/12/15.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
@property (nonatomic ,strong)NSMutableData *songData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)xiazai:(UIButton *)sender {
    //第一步，创建url
    NSURL *url = [NSURL URLWithString:@"http://pic15.nipic.com/20110619/1901904_140154707195_2.jpg"];
    
    //第二步，创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //第三步，连接服务器
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
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

//数据传输完后，调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //将数据保存到文件
    [_songData writeToFile:@"/Users/qingyun/Desktop/image.jpg" atomically:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
