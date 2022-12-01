#import "MarvelflutterPlugin.h"
#import <Marvel/Marvel.h>
@implementation MarvelflutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"marvelflutter"
            binaryMessenger:[registrar messenger]];
  MarvelflutterPlugin* instance = [[MarvelflutterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"startMarvel" isEqualToString:call.method]) {
    NSDictionary * dic = call.arguments;
    
      
      
    
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
