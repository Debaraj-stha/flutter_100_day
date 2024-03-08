import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class SmartReplySystem extends StatefulWidget {
  const SmartReplySystem({super.key});

  @override
  State<SmartReplySystem> createState() => _SmartReplySystemState();
}

class _SmartReplySystemState extends State<SmartReplySystem> {
  final TextEditingController _localUser = TextEditingController();
  final TextEditingController _remoteUser = TextEditingController();
  final SmartReply _smartReply = SmartReply();
  SmartReplySuggestionResult? _smartReplySuggestionResult;
  void _addToConversation(TextEditingController controller, bool islocale) {
    if (controller.text.isNotEmpty) {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      if (islocale) {
        _smartReply.addMessageToConversationFromLocalUser(
            controller.text, timestamp);
      } else {
        _smartReply.addMessageToConversationFromRemoteUser(
            controller.text, timestamp, "userId");
      }
      controller.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Message addded to conversation")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Message can not be empty")));
    }
  }

  void _getSuggestion() async {
    final result = await _smartReply.suggestReplies();
    _smartReplySuggestionResult = result;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(helperText: "Locl user"),
              controller: _localUser,
            ),
            TextButton(
                onPressed: () {
                  _addToConversation(_localUser, true);
                },
                child: const Text("Add conversation")),
            TextFormField(
              decoration: const InputDecoration(helperText: "Remote user"),
              controller: _remoteUser,
            ),
            TextButton(
                onPressed: () {
                  _addToConversation(_remoteUser, false);
                },
                child: const Text("Add conversation")),
            Row(
              children: [
                if (_smartReply.conversation.isNotEmpty)
                  ElevatedButton(
                      onPressed: () {
                        _smartReply.clearConversation();
                        _smartReplySuggestionResult = null;
                        setState(() {});
                      },
                      child: const Text("Clear conversation")),
                ElevatedButton(
                    onPressed: () {
                      _getSuggestion();
                    },
                    child: const Text("Get suggestions")),
              ],
            ),
            if (_smartReplySuggestionResult != null)
              Text(_smartReplySuggestionResult!.status.name),
            if (_smartReplySuggestionResult != null &&
                _smartReplySuggestionResult!.suggestions.isNotEmpty)
              for (final suggestion in _smartReplySuggestionResult!.suggestions)
                GestureDetector(
                    onTap: () {
                      _remoteUser.text = suggestion;
                    },
                    child: Text('\t $suggestion')),
          ],
        ),
      )),
    );
  }
}
