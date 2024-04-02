  static Future<Uint8List> getBytesFromCanvasDynamic(
      {required String plateReg}) async {
    String iconPath = "assets/images/marker.png";
    double fontSize = 18;
    Size iconSize = const Size(100, 100);
    final Paint paint = Paint()
      ..color = const Color.fromARGB(255, 240, 200, 50);
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    TextPainter painter = TextPainter(
        textAlign: TextAlign.center, textDirection: ui.TextDirection.ltr);
    painter.text = TextSpan(
        text: plateReg,
        style: TextStyle(
            fontSize: fontSize,
            letterSpacing: 2,
            color: Colors.black,
            fontWeight: FontWeight.w600));

    painter.layout(
      minWidth: 0,
    );
    int halfTextHeight = painter.height ~/ 2;
    double fortyPercentWidth = painter.width * 0.20;
    int textWidth = painter.width.toInt() + fortyPercentWidth.toInt();
    int textHeight = painter.height.toInt() + halfTextHeight;

    Rect rect =
        Rect.fromLTWH(0, 0, textWidth.toDouble(), textHeight.toDouble());
    RRect rectRadius = RRect.fromRectAndRadius(rect, const Radius.circular(10));

    canvas.drawRRect(rectRadius, paint);
    painter.paint(
        canvas, Offset(fortyPercentWidth / 2, halfTextHeight.toDouble() / 2));

    double x = (textWidth) / 2;
    double y = textHeight.toDouble();

    Path arrow = Path()
      ..moveTo(x - 25, y)
      ..relativeLineTo(50, 0)
      ..relativeLineTo(-25, 25)
      ..close();

    canvas.drawPath(arrow, paint);

    final ByteData dataStart = await rootBundle.load(iconPath);

    ui.Codec codec = await ui.instantiateImageCodec(
        dataStart.buffer.asUint8List(),
        targetWidth: iconSize.width.toInt());
    ui.FrameInfo fi = await codec.getNextFrame();

    Uint8List dataEnd =
        ((await fi.image.toByteData(format: ui.ImageByteFormat.png)) ??
                ByteData(0))
            .buffer
            .asUint8List();

    ui.Image image = await _loadImage(Uint8List.view(dataEnd.buffer));

    canvas.drawImage(image, Offset(x - (image.width / 2), y + 25), Paint());

    ui.Picture p = pictureRecorder.endRecording();

    ByteData? pngBytes = await (await p.toImage(
      textWidth < image.width ? image.width : textWidth,
      textHeight + image.height + 25,
    ))
        .toByteData(format: ui.ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }

  static Future<ui.Image> _loadImage(Uint8List img) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
    List<Polyline> polylines = [];
  addPolylines() {
    for (var i = 0; i < latLngs.length; i++) {
      polylines.add(Polyline(
          polylineId: PolylineId("$i"),
          color: Colors.red,
          jointType: JointType.round,
          onTap: () {
            Utils.printMessage(latLngs[i]);
          },
          visible: true,
          endCap: Cap.roundCap,
          points: latLngs));
    }
  }
