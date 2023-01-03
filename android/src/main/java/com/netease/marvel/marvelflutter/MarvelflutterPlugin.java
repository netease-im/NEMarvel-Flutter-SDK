package com.netease.marvel.marvelflutter;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.netease.marvel.exception.reporting.client.ExceptionReportingClient;
import com.netease.marvel.exception.reporting.client.UserInfo;

import org.json.JSONObject;

/** MarvelflutterPlugin */
public class MarvelflutterPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "marvelflutter");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if (call.method.equals("startMarvel")){
      String userId = call.argument("userId");
      String deviceId = call.argument("deviceId");
      String marvelId =  call.argument("marvelId");
      String sdkVersion =  call.argument("sdkVersion");


      UserInfo userInfo = new UserInfo();
      userInfo.userId = userId; // 用户信息，非必需qos管理数据，可不填
      userInfo.deviceId = deviceId; // 设备信息，非必需qos管理数据，可不填
      userInfo.sdkVersion = sdkVersion; // 你的sdk/app版本号，用于统计，可不填
      userInfo.marvelId = marvelId; // 你申请的marvel id
      ExceptionReportingClient.getInstance().start(userInfo); // 启动
      result.success(0);
    }else if ( call.method.equals("reportUserException")) {
//      NSDictionary * dic = call.arguments;
//      if([dic isKindOfClass:[NSDictionary class]]){
//        NSString*exception = dic[@"exception"];
//        NSString*information = dic[@"information"];
//        NSString*reason = dic[@"reason"];
////            NSString*fatal = dic[@"fatal"];
//        NSString*buildId = dic[@"buildId"];
//        NSString*stackTrace= dic[@"stackTrace"];
//        NSArray* stackTraces = NULL;
//        if(stackTrace){
//          stackTraces = [stackTrace componentsSeparatedByString:@"\n"];
//        }
//        NSMutableDictionary * info = [NSMutableDictionary dictionary];
//        info[@"stackTrace"] = stackTraces;
//        info[@"exception"] = exception;
//        info[@"information"] = information;
//        info[@"buildId"] = buildId;
//        info[@"reason"] = reason;
//
//        [Marvel reportUserException:info];
//        result(@(0));
//        return;
//      }
      result.success("Android " + android.os.Build.VERSION.RELEASE);

    }
    else {
      result.notImplemented();
    }

  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
