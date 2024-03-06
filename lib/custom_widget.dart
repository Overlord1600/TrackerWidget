import 'package:flutter/material.dart';

class ProgressWidget extends StatefulWidget {
  final double? secondaryColumnWidth;
  final bool isScrollable;
  final bool? shouldIconHaveBorder;
  final int nodeCount;
  final double circleRadius;
  final Color inProgressColor;
  final Color? completedColor;
  final Color? iconBackgroundColor;
  final Color incompleteColor;
  final Icon? statusIcon;
  final List<String> titleList;
  final List<String> contentList;
  final bool isSecondaryColumnEnabled;
  final List<String>? secondaryTitleList;
  final List<String>? secondaryContentList;
  final List<bool> statusCompletedList;
  const ProgressWidget({
    super.key,
    required this.isScrollable,
    required this.circleRadius,
    required this.nodeCount,
    required this.inProgressColor,
    required this.incompleteColor,
    required this.titleList,
    required this.contentList,
    required this.isSecondaryColumnEnabled,
    required this.statusCompletedList,
    this.secondaryColumnWidth,
    this.secondaryContentList,
    this.secondaryTitleList,
    this.completedColor,
    this.statusIcon,
    this.iconBackgroundColor,
    this.shouldIconHaveBorder,
  })  : assert(isSecondaryColumnEnabled
            ? secondaryContentList != null && secondaryTitleList != null
            : true),
        assert(statusIcon != null || circleRadius > 0),
        assert(statusIcon != null ? iconBackgroundColor != null : true);

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 900),
      painter: ProgressWidgetPainter(
          secondaryColumnWidth: widget.secondaryColumnWidth,
          shouldIconHaveBorder: widget.shouldIconHaveBorder,
          nodeCount: widget.nodeCount,
          inProgressColor: widget.inProgressColor,
          completedColor: widget.completedColor,
          incompleteColor: widget.incompleteColor,
          statusIcon: widget.statusIcon,
          titleList: widget.titleList,
          contentList: widget.contentList,
          statusCompletedList: widget.statusCompletedList,
          secondaryContentList: widget.secondaryContentList,
          secondaryTitleList: widget.secondaryTitleList,
          isSecondaryColumnEnabled: widget.isSecondaryColumnEnabled,
          circleRadius: widget.circleRadius,
          iconBackgroundColor: widget.iconBackgroundColor),
    );
  }
}

void calculateSecondaryColumnWidth({required List<String> contentText}) {}

class ProgressWidgetPainter extends CustomPainter {
  final double? _secondaryColumnWidth;
  final bool _shouldIconHaveBorder;
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
  ProgressWidgetPainter({
    required nodeCount,
    required inProgressColor,
    required incompleteColor,
    required titleList,
    required contentList,
    required isSecondaryColumnEnabled,
    required statusCompletedList,
    required circleRadius,
    secondaryColumnWidth,
    secondaryContentList,
    secondaryTitleList,
    completedColor,
    statusIcon,
    iconBackgroundColor,
    shouldIconHaveBorder,
  })  : assert(isSecondaryColumnEnabled
            ? secondaryContentList != null && secondaryTitleList != null
            : true),
        assert(statusIcon != null || circleRadius > 0),
        assert(statusIcon != null ? iconBackgroundColor != null : true),
        _secondaryColumnWidth = secondaryColumnWidth,
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
  void paint(Canvas canvas, Size size) {
    double contentTitleGap = 10.0;
    double availableHeight = size.height;
    double gapCorrectionForContentText = 25.0;
    double textGapWidth = 10.0;
    double strokeWidth = 2.0;
    double gapWidth = 5.0;
    double nodeWidth = size.width / 4;
    double primaryContentWidth = _isSecondaryColumnEnabled
        ? (size.width - nodeWidth) / 2
        : size.width - nodeWidth;
    double lineLength = size.height / _nodeCount;
    double circleRadius = _circleRadius;
    double iconCircleRadius =
        _statusIcon != null ? _statusIcon!.size! / 2 + gapWidth : 0;
    Offset iconCircleOffset = Offset(
        _isSecondaryColumnEnabled
            ? _secondaryColumnWidth != null
                ? _secondaryColumnWidth!.toDouble()
                : size.width / 2
            : iconCircleRadius + strokeWidth,
        iconCircleRadius + strokeWidth);

    Offset circleOffset = Offset(
        _isSecondaryColumnEnabled
            ? _secondaryColumnWidth != null
                ? _secondaryColumnWidth!.toDouble()
                : size.width / 2
            : circleRadius,
        circleRadius);

    Offset lineOffset =
        Offset(_statusIcon != null ? iconCircleOffset.dx : circleOffset.dx, 0);

    Offset iconOffset = Offset(
        _isSecondaryColumnEnabled && _statusIcon != null
            ? circleOffset.dx - _statusIcon!.size! / 2
            : _statusIcon != null
                ? gapWidth + strokeWidth
                : 0,
        _statusIcon != null ? strokeWidth + gapWidth : 0);

    Offset titleOffset = Offset(
        _statusIcon != null
            ? iconCircleOffset.dx +
                iconCircleRadius +
                strokeWidth +
                textGapWidth
            : circleOffset.dx + circleRadius + textGapWidth,
        _statusIcon != null ? iconCircleRadius / 2 : circleRadius / 2);
    Offset secondaryTitleOffset = const Offset(0.0, 0.0);
    Offset secondaryContentOffset = const Offset(0.0, 0.0);
    Offset contentOffset;
    TextPainter titlePainter = TextPainter(
        textAlign: TextAlign.start, textDirection: TextDirection.ltr);
    TextPainter contentPainter = TextPainter(
        textAlign: TextAlign.start, textDirection: TextDirection.ltr);
    TextPainter secondaryTitlePainter = TextPainter(
        textAlign: TextAlign.start, textDirection: TextDirection.ltr);
    TextPainter secondaryContentPainter = TextPainter(
        textAlign: TextAlign.start, textDirection: TextDirection.ltr);
    TextPainter iconPainter = TextPainter(textDirection: TextDirection.ltr);

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

      titlePainter.text = TextSpan(
          text: _titleList[i],
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black));
      titlePainter.layout(maxWidth: primaryContentWidth);
      titlePainter.paint(canvas, titleOffset);

      contentPainter.text = TextSpan(
          text: _contentList[i],
          style: const TextStyle(fontSize: 15, color: Colors.black));
      contentPainter.layout(maxWidth: primaryContentWidth);
      // if (contentPainter.height >
      //     (lineLength -
      //         (_statusIcon != null
      //             ? iconCircleRadius * 2
      //             : circleRadius * 2))) {
      //   lineLength = lineLength +
      //       gapCorrectionForContentText +
      //       (contentPainter.height - lineLength) +
      //       (_statusIcon != null ? iconCircleRadius : circleRadius);
      //   availableHeight = availableHeight - lineLength;
      //
      contentOffset = Offset(titleOffset.dx,
          titleOffset.dy + titlePainter.height + contentTitleGap);
      contentPainter.paint(canvas, contentOffset);

      if (_isSecondaryColumnEnabled) {
        secondaryTitlePainter.text = TextSpan(
            text: _secondaryTitleList![i],
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black));
        secondaryContentPainter.text = TextSpan(
            text: _secondaryContentList![i],
            style: const TextStyle(fontSize: 15, color: Colors.black));
        secondaryTitlePainter.layout(
            maxWidth: _secondaryColumnWidth != null
                ? _secondaryColumnWidth!.toDouble() -
                    (_statusIcon != null
                        ? (iconCircleRadius + strokeWidth)
                        : (circleRadius + textGapWidth))
                : primaryContentWidth);
        secondaryContentPainter.layout(
            maxWidth: _secondaryColumnWidth != null
                ? _secondaryColumnWidth!.toDouble() -
                    (_statusIcon != null
                        ? (iconCircleRadius + strokeWidth)
                        : (circleRadius + textGapWidth))
                : primaryContentWidth);
        secondaryTitleOffset = Offset(
            _statusIcon != null
                ? 0
                : _secondaryColumnWidth != null
                    ? 0
                    : circleOffset.dx -
                        circleRadius -
                        textGapWidth -
                        secondaryTitlePainter.width,
            titleOffset.dy);
        secondaryContentOffset = Offset(
            _secondaryColumnWidth != null
                ? secondaryTitleOffset.dx
                : _statusIcon != null
                    ? iconOffset.dx -
                        iconCircleRadius -
                        strokeWidth -
                        textGapWidth -
                        secondaryContentPainter.width
                    : circleOffset.dx -
                        circleRadius -
                        textGapWidth -
                        secondaryContentPainter.width,
            secondaryTitleOffset.dy +
                secondaryTitlePainter.height +
                contentTitleGap);
        secondaryTitlePainter.paint(canvas, secondaryTitleOffset);
        if (secondaryContentPainter.height >
                (lineLength -
                    (_statusIcon != null
                        ? iconCircleRadius * 2
                        : circleRadius * 2)) ||
            contentPainter.height >
                (lineLength -
                    (_statusIcon != null
                        ? iconCircleRadius * 2
                        : circleRadius * 2))) {
          if (secondaryContentPainter.height > contentPainter.height) {
            lineLength = lineLength +
                gapCorrectionForContentText +
                (secondaryContentPainter.height - lineLength) +
                (_statusIcon != null ? iconCircleRadius : circleRadius);
            availableHeight = availableHeight - lineLength;
          } else {
            lineLength = lineLength +
                gapCorrectionForContentText +
                (contentPainter.height - lineLength) +
                (_statusIcon != null ? iconCircleRadius : circleRadius);
            availableHeight = availableHeight - lineLength;
          }
        }
        secondaryContentPainter.paint(canvas, secondaryContentOffset);
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
      titleOffset = Offset(titleOffset.dx, titleOffset.dy + lineLength);
      lineLength = availableHeight / _nodeCount - 1;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
    //throw UnimplementedError();
  }
}
