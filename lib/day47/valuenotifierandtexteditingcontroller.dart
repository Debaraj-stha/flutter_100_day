import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseTextEditingControllerHook extends HookWidget {
  const UseTextEditingControllerHook({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = useValueNotifier(0);
    final texteditingcontroller = useTextEditingController();
    final value = useState(texteditingcontroller.text);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: texteditingcontroller,
              onChanged: (val) {
                value.value = val;
              },
            ),
            Text("value=>${value.value}"),
            GestureDetector(
                onTap: () {
                  notifier.value++;
                },
                child: ValueListenableBuilder(
                    valueListenable: notifier,
                    builder: (context, value, child) {
                      return Text(
                        value.toString(),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
