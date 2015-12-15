//
//  ViewController.m
//  02-AsyncRequestDemo
//
//  Created by qingyun on 15/12/15.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#define kSongURLStr   @"http://down.5nd.com/a/down.ashx?t=1&xcode=0b28de1ff927eb3c16eea3c14442219c&sid=602471"

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSMutableData *songData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)downloadMusic:(id)sender {
    // 1. URL
    NSURL *url = [NSURL URLWithString:kSongURLStr];
    
    // 2. Request
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:60];
    
    // 3. Connection
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionData Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // 如果响应成功，则申请内存
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        _songData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // 如果收到数据，在songData后面追加数据
    static int count = 0;
    [_songData appendData:data];
    NSLog(@"<%d>:%@", count++, data);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // 将数据保存到文件
    [_songData writeToFile:@"/Users/qingyun/Desktop/song.mp3" atomically:YES];
}

@end
