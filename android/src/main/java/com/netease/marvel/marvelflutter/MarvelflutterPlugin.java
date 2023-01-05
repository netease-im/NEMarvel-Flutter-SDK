package com.netease.marvel.marvelflutter;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.netease.marvel.exception.reporting.client.ExceptionReportingClient;
import com.netease.marvel.exception.reporting.client.MarvelConstants;
import com.netease.marvel.exception.reporting.client.UserInfo;

import org.json.JSONException;
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
      userInfo.userSdkType = MarvelConstants.UserSdkType.MARVEL_USER_SDK_TYPE_FLUTTER;
      ExceptionReportingClient.getInstance().start(userInfo); // 启动
      result.success(0);
    }else if ( call.method.equals("reportUserException")) {
      String exception = call.argument("exception");
      String reason = call.argument("reason");
      String information =  call.argument("information");
      String buildId = call.argument("buildId");
      String stackTrace =  call.argument("stackTrace");
      Boolean fatal = call.argument("fatal");

      JSONObject jsonObject = new JSONObject();
      try {
        jsonObject.put("exception", exception);
        jsonObject.put("reason", reason);
        jsonObject.put("information", information);
        jsonObject.put("buildId", buildId);
        jsonObject.put("stackTrace", stackTrace);
        jsonObject.put("fatal", fatal);
      } catch (JSONException e) {
        e.printStackTrace();
      }
      ExceptionReportingClient.getInstance().reportUserException(jsonObject.toString());
      result.success(0);

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
