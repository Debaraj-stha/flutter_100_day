import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:useRef_hooks.dart';

class UseStateHook extends HookWidget {
  const UseStateHook({super.key});

  @override
  Widget build(BuildContext context) {
    var counter = useState(0);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                counter.value++;
              },
              child: const Text("increase")),
          Text(counter.value.toString()),
          MyValueNotifier(),
        ],
      ),
    );
  }
}

class MyValueNotifier extends StatelessWidget {
  MyValueNotifier({super.key});
  ValueNotifier<int> counter = ValueNotifier(0);
  updateVAlue() {
    counter.value++;

    print(counter.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          updateVAlue();
        },
        child: Column(
          children: [
            const Text("Update value"),
            Text(counter.value.toString()),
          ],
        ));
  }
}

class UseCallBackHooks extends HookWidget {
  const UseCallBackHooks({super.key});

  @override
  Widget build(BuildContext context) {
    const value = 6;
    final res = useCallback(() {
      return value * value;
    }, [value])(); // Invoke the callback function to get the result

    return Center(
      child: Text("$res"),
    );
  }
}

class MyUseRefHooks extends HookWidget {
  const MyUseRefHooks({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize count using useState
    final count = useState<int>(0);

    // Create a mutable reference using useRef
    final clickCountRef = useRef<int>(0);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text(
          //   'Count: ${count.value}',
          //   style: const TextStyle(fontSize: 24),
          // ),
          Text(
            'Button Click Count: ${clickCountRef.value}',
            style: const TextStyle(fontSize: 18),
          ),
          ElevatedButton(
            onPressed: () {
              // count.value++;

              clickCountRef.value++;
            },
            child: const Text('Increment Count'),
          ),
        ],
      ),
    );
  }
}

class UseMomozedHooks extends HookWidget {
  const UseMomozedHooks({super.key});

  @override
  Widget build(BuildContext context) {
    const int input = 5;

    final result = useMemoized(() {
      print('Performing expensive computation...');
      return fibonacci(input);
    }, [input]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('useMemoized Example'),
      ),
      body: Center(
        child: Text('Result: $result'),
      ),
    );
  }

  int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
  }
}

class MyUseEffect extends HookWidget {
  const MyUseEffect({super.key});

  @override
  Widget build(BuildContext context) {
    // Define count as a state variable
    final count = useState<int>(0);

    useEffect(() {
      print("use effect");
      return null;
    }, [count]);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          print("object");
          // Update count value by incrementing it
          count.value++;
        },
        child: Text("${count.value}"),
      ),
    );
  }
}
