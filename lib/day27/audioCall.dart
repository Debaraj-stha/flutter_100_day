import 'package:flutter/material.dart';
import 'package:hundred_day/day27/const.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCall extends StatelessWidget {
  const AudioCall({super.key, required this.callID, required this.userId});
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
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall());
  }
}
