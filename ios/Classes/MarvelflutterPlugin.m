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
    if([dic isKindOfClass:[NSDictionary class]]){
      MarvelConfig *config  = [MarvelConfig new];
      config.sdkVersion = dic[@"sdkVersion"];
      config.userId =  dic[@"userId"];
      config.deviceIdentifier =  dic[@"deviceIdentifier"];
      config.sdkName =  dic[@"sdkName"];
      config.appKey =  dic[@"appKey"];
      config.extenInfo =  dic[@"extenInfo"];
      config.assLogFilePath =  dic[@"assLogFilePath"];
      NSString *marvelId = dic[@"marvelId"];
      [Marvel  startWithMarvelId:marvelId config:config];
      result(@(0));
      return;
    }
    result(@(-1));
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
