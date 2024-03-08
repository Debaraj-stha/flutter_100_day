import 'package:flutter/material.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'const.dart';

class VideoCall extends StatelessWidget {
  const VideoCall({super.key, required this.callID, required this.userId});
  final String callID;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: constants().APPID,
        appSign: constants().APPSIGN,
        callID: callID,
        userID: userId,
        userName: "userName:$userId",
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}
