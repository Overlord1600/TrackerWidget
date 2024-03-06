import 'package:flutter/material.dart';

class CustomTrackerWidget extends LeafRenderObjectWidget {
  bool? shouldIconHaveBorder;
  int nodeCount;
  double circleRadius;
  Color inProgressColor;
  Color? completedColor;
  Color? iconBackgroundColor;
  Color incompleteColor;
  Icon? statusIcon;
  List<String> titleList;
  List<String> contentList;
  bool isSecondaryColumnEnabled;
  List<String>? secondaryTitleList;
  List<String>? secondaryContentList;
  List<bool> statusCompletedList;
  CustomTrackerWidget({
    super.key,
    required this.nodeCount,
    required this.inProgressColor,
    required this.incompleteColor,
    required this.titleList,
    required this.contentList,
    required this.isSecondaryColumnEnabled,
    required this.statusCompletedList,
    this.secondaryContentList,
    this.secondaryTitleList,
    this.completedColor,
    this.statusIcon,
    this.iconBackgroundColor,
    this.shouldIconHaveBorder,
    required this.circleRadius,
  });
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomTrackerWidget(
        shouldIconHaveBorder: shouldIconHaveBorder,
        nodeCount: nodeCount,
        inProgressColor: inProgressColor,
        completedColor: completedColor,
        incompleteColor: incompleteColor,
        statusIcon: statusIcon,
        titleList: titleList,
        contentList: contentList,
        statusCompletedList: statusCompletedList,
        secondaryContentList: secondaryContentList,
        secondaryTitleList: secondaryTitleList,
        isSecondaryColumnEnabled: isSecondaryColumnEnabled,
        circleRadius: circleRadius,
        iconBackgroundColor: iconBackgroundColor);
    // throw UnimplementedError();
  }
}

class RenderCustomTrackerWidget extends RenderBox {
  final bool? _shouldIconHaveBorder;
  final int _nodeCount;
  final Color _inProgressColor;
  final double _circleRadius;
  Color? _completedColor;
  final Color? _iconBackgroundColor;
  final Color _incompleteColor;
  final Icon? _statusIcon;
  final List<String> _titleList;
  final List<String> _contentList;
  final bool _isSecondaryColumnEnabled;
  final List<String>? _secondaryTitleList;
  final List<String>? _secondaryContentList;
  final List<bool> _statusCompletedList;
  RenderCustomTrackerWidget(
      {required nodeCount,
      required inProgressColor,
      required incompleteColor,
      required titleList,
      required contentList,
      required isSecondaryColumnEnabled,
      required statusCompletedList,
      secondaryContentList,
      secondaryTitleList,
      completedColor,
      statusIcon,
      iconBackgroundColor,
      shouldIconHaveBorder,
      required circleRadius})
      : assert(isSecondaryColumnEnabled
            ? secondaryContentList != null && secondaryTitleList != null
            : true),
        assert(statusIcon != null || circleRadius > 0),
        assert(statusIcon != null ? iconBackgroundColor != null : true),
        _iconBackgroundColor = iconBackgroundColor,
        _nodeCount = nodeCount,
        _inProgressColor = inProgressColor,
        _incompleteColor = incompleteColor,
        _titleList = titleList,
        _contentList = contentList,
        _isSecondaryColumnEnabled = isSecondaryColumnEnabled,
        _secondaryContentList = secondaryContentList,
        _secondaryTitleList = secondaryTitleList,
        _statusCompletedList = statusCompletedList,
        _statusIcon = statusIcon,
        _circleRadius = circleRadius,
        _shouldIconHaveBorder = shouldIconHaveBorder;

  @override
  void performLayout() {
    size = constraints.biggest;
    super.performLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    double textGapWidth = 10.0;
    double strokeWidth = 2.0;
    double gapWidth = 5.0;
    double nodeWidth = size.width / 4;
    double primaryContentWidth = _isSecondaryColumnEnabled
        ? (size.width - nodeWidth) / 2
        : size.width - nodeWidth;
    double secondaryContentWidth =
        _isSecondaryColumnEnabled ? primaryContentWidth : 0.0;
    double lineLength = size.height / _nodeCount;
    double circleRadius = _circleRadius;
    double iconCircleRadius =
        _statusIcon != null ? _statusIcon!.size! / 2 + gapWidth : 0;
    Offset iconCircleOffset = Offset(
            _isSecondaryColumnEnabled
                ? size.width / 2
                : iconCircleRadius + strokeWidth,
            iconCircleRadius + strokeWidth) +
        offset;
    Offset circleOffset = Offset(
            _isSecondaryColumnEnabled ? size.width / 2 : circleRadius,
            circleRadius) +
        offset;
    Offset lineOffset =
        Offset(_statusIcon != null ? iconCircleOffset.dx : circleOffset.dx, 0) +
            offset;
    Offset iconOffset = Offset(
            _isSecondaryColumnEnabled && _statusIcon != null
                ? circleOffset.dx - _statusIcon!.size! / 2
                : _statusIcon != null
                    ? gapWidth + strokeWidth
                    : 0,
            _statusIcon != null ? strokeWidth + gapWidth : 0) +
        offset;
    Offset titleOffset = Offset(
            _statusIcon != null ? iconOffset.dx : circleOffset.dx,
            _statusIcon != null ? iconOffset.dy : circleOffset.dy) +
        offset;
    TextPainter titlePainter = TextPainter(
        textAlign: TextAlign.start, textDirection: TextDirection.ltr);
    TextPainter contentPainter = TextPainter(
        textAlign: TextAlign.start, textDirection: TextDirection.ltr);
    TextPainter iconPainter = TextPainter(textDirection: TextDirection.ltr);

    final canvas = context.canvas;
    for (int i = 0; i < _nodeCount; i++) {
      if (_statusIcon == null) {
        canvas.drawCircle(
            circleOffset,
            circleRadius,
            Paint()
              ..color =
                  _statusCompletedList[i] ? _inProgressColor : _incompleteColor
              ..style = PaintingStyle.fill);
      }
      if (i != _nodeCount - 1) {
        canvas.drawLine(
            lineOffset,
            Offset(lineOffset.dx, lineOffset.dy + lineLength),
            Paint()
              ..color =
                  _statusCompletedList[i] ? _inProgressColor : _incompleteColor
              ..style = PaintingStyle.fill
              ..strokeWidth = 5.0);
      }
      if (_statusIcon != null) {
        iconPainter.text = TextSpan(
            text: String.fromCharCode(_statusIcon!.icon!.codePoint),
            style: TextStyle(
                color: Colors.white,
                fontSize: _statusIcon!.size,
                fontFamily: _statusIcon!.icon!.fontFamily));
        iconPainter.layout();
        canvas.drawCircle(
            iconCircleOffset,
            iconCircleRadius,
            Paint()
              ..style = PaintingStyle.fill
              ..color = _iconBackgroundColor as Color);
        if (_shouldIconHaveBorder == true) {
          canvas.drawCircle(
              iconCircleOffset,
              iconCircleRadius,
              Paint()
                ..style = PaintingStyle.stroke
                ..color = const Color.fromRGBO(255, 255, 255, 1)
                ..strokeWidth = strokeWidth);
        }
        iconPainter.paint(canvas, iconOffset);
      }

      lineOffset = Offset(lineOffset.dx, lineOffset.dy + lineLength);
      circleOffset = Offset(circleOffset.dx, lineOffset.dy + circleRadius);
      iconCircleOffset =
          Offset(iconCircleOffset.dx, lineOffset.dy + iconCircleRadius);
      iconOffset = Offset(iconOffset.dx, lineOffset.dy + gapWidth);
    }
    super.paint(context, offset);
  }
}
