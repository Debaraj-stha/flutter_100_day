import 'package:flutter/material.dart';
import 'package:hundred_day/day27/audioCall.dart';
import 'package:hundred_day/day27/videoCall.dart';

import 'package:zego_zimkit/zego_zimkit.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conversations'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ZIMKit().showDefaultNewPeerChatDialog(context);
          },
          child: const Icon(Icons.add),
        ),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: conversation.id,
                  conversationType: conversation.type,
                  appBarActions: [
                    IconButton(
                        onPressed: () {
                          String id = "11";

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoCall(
                                      callID: id,
                                      userId: conversation.id.toString())));
                        },
                        icon: const Icon(Icons.video_call)),
                        IconButton(
                        onPressed: () {
                          String id = "11";

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AudioCall(
                                      callID: id,
                                      userId: conversation.id.toString())));
                        },
                        icon: const Icon(Icons.call))
                  ],
                );
              },
            ));
          },
        ),
      ),
    );
  }
}
