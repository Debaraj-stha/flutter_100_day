import 'package:flutter/material.dart';

class DragableWIdget extends StatefulWidget {
  const DragableWIdget({super.key});

  @override
  State<DragableWIdget> createState() => _DragableWIdgetState();
}

class _DragableWIdgetState extends State<DragableWIdget> {
  Color caughtColor=Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Draggable(
            data: Colors.orange,
            feedback: Container(
              height: 150,
              width: 150,
              color: Colors.indigo.withOpacity(0.5),
              child: const Text("dragging..."),
            ),
            onDragCompleted: () {
              // Handle drag completion if needed
              print("drag completed");
            },
            onDragEnd: (details) {
              print("drag completed");
            },
            onDraggableCanceled: (velocity, offset) {},
            dragAnchorStrategy: pointerDragAnchorStrategy,
            child: Container(
              height: 200,
              width: 200,
              color: Colors.indigo,
              child: const Text("draggable widget"),
            ), // Set the dragAnchor property
          ),
          DragTarget(
            onAccept: (Color color) {
             
              caughtColor=color;
            },
            builder: (context, List<dynamic> accepted, rejectedData) {
              return Container(
                height: 300,
                width: 300,
                color:accepted.isEmpty ? caughtColor:Colors.green,
                child: const Text("drag target"),
              );
            },
          )
        ],
      ),
    );
  }
}
/*
class DragableWIdget extends StatefulWidget {
  const DragableWIdget({Key? key}) : super(key: key);
  @override
  State<DragableWIdget> createState() => _DragableWIdgetState();
}

class _DragableWIdgetState extends State<DragableWIdget> {
  Color caughtColor = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable widget'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Draggable Widget
            Draggable(
                data: Colors.orangeAccent,
                // calling onDraggableCanceled property

                onDraggableCanceled: (velocity, offset) {},
                feedback: Container(
                  width: 150,
                  height: 150,
                  color: Colors.orangeAccent.withOpacity(0.5),
                  child: const Center(
                    child: Text(
                      'Box...',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.orangeAccent,
                  child: const Center(
                    child: Text('box'),
                  ),
                )),

            // building Drag Target Widget
            DragTarget(onAccept: (Color color) {
              caughtColor = color;
            }, builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                width: 200,
                height: 200,
                color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                child: const Center(
                  child: Text('Drag here'),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
*/