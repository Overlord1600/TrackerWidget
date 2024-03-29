import 'package:flutter/material.dart';

enum TrackerStatus { inProgress, completed, incomplete }

enum TrackerAlignment { top, center, bottom }

enum TrackerBehaviour { regular, nodeOnly, reverse }

class Tracker extends StatefulWidget {
  final BuildContext context;

  ///Width of the line that connects nodes
  final double lineWidth;

  /// Size of each status icon used in the tracker
  final double iconSize;

  ///  A list of TrackerStatus indicating the completion status of each node in the progress tracker
  final List<TrackerStatus> statusCompletedList;

  /// A boolean indicating whether icons in the progress tracker should have a background
  final bool shouldIconHaveBackground;

  /// Total height of the entire widget. Choose a height that will be big enough to fit all the contents of the widget
  final double height;
  final double width;

  ///  A boolean indicating whether icons in the progress tracker should have a border
  final bool shouldIconHaveBorder;

  /// The total number of nodes in the progress tracker
  final int nodeCount;

  /// The radius of the circular nodes in the progress tracker
  final double circleRadius;

  /// The color representing nodes that are in progress
  final Color inProgressColor;

  /// The color representing nodes that are completed
  final Color completedColor;

  /// The color representing nodes that are incomplete
  final Color incompleteColor;

  /// A list of strings containing titles for each node in the progress tracker
  final List<String> titleList;

  ///A list of strings containing content for each node in the progress tracker
  final List<String> contentList;

  /// A boolean indicating whether a secondary column is enabled for additional content in each node
  final bool isSecondaryColumnEnabled;

  /// A list of Icon widgets representing custom icons for each node in the progress tracker
  final List<Icon>? statusIcons;

  ///A list of strings containing secondary titles for each node, to be displayed in the secondary column if enabled
  final List<String>? secondaryTitleList;

  ///A list of strings containing secondary content for each node, to be displayed in the secondary column if enabled
  final List<String>? secondaryContentList;

  ///The text style for titles in the progress tracker
  final TextStyle titleStyle;

  ///The text style for content in the progress tracker
  final TextStyle contentStyle;

  ///The color of the border around icons in the progress tracker.
  final Color iconBorderColor;

  ///The vertical alignment of text within nodes (top, center, or bottom).
  final TrackerAlignment verticalTextAlign;

  ///The width of the secondary column for additional content, if enabled.
  final double? secondaryColumnWidth;

  final TrackerBehaviour behaviour;

  /// The tracker widget is a highly customizable component designed to visually represent progress in a step-by-step process Users can define the number of nodes and their associated titles, content, and completion status, allowing for precise tracking of progress. The widget supports the inclusion of custom icons for each node, enhancing visual appeal and providing additional context or visual cues for different stages of the process. Additionally, developers can enable a secondary content column to display supplementary information alongside the main progress tracker. The tracker widget dynamically adjusts its layout based on the content provided, ensuring optimal display of titles, content, and icons within each node.
  const Tracker({
    super.key,
    required this.shouldIconHaveBackground,
    required this.context,
    required this.height,
    required this.width,
    required this.circleRadius,
    required this.nodeCount,
    required this.inProgressColor,
    required this.incompleteColor,
    required this.titleList,
    required this.contentList,
    required this.isSecondaryColumnEnabled,
    required this.statusCompletedList,
    required this.completedColor,
    required this.shouldIconHaveBorder,
    this.iconSize = 20.0,
    this.lineWidth = 3.0,
    this.verticalTextAlign = TrackerAlignment.top,
    this.titleStyle = const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    this.contentStyle = const TextStyle(fontSize: 15, color: Colors.black),
    this.iconBorderColor = const Color.fromARGB(255, 255, 255, 255),
    this.behaviour = TrackerBehaviour.regular,
    this.secondaryColumnWidth,
    this.secondaryContentList,
    this.secondaryTitleList,
    this.statusIcons,
  });

  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.width, widget.height),
      painter: ProgressWidgetPainter(
          behaviour: widget.behaviour,
          iconSize: widget.iconSize,
          verticalTextAlgin: widget.verticalTextAlign,
          titleStyle: widget.titleStyle,
          contentStyle: widget.contentStyle,
          iconBorderColor: widget.iconBorderColor,
          context: widget.context,
          shouldIconHaveBackground: widget.shouldIconHaveBackground,
          secondaryColumnWidth: widget.secondaryColumnWidth,
          shouldIconHaveBorder: widget.shouldIconHaveBorder,
          nodeCount: widget.nodeCount,
          inProgressColor: widget.inProgressColor,
          completedColor: widget.completedColor,
          incompleteColor: widget.incompleteColor,
          statusIcons: widget.statusIcons,
          titleList: widget.titleList,
          contentList: widget.contentList,
          statusCompletedList: widget.statusCompletedList,
          secondaryContentList: widget.secondaryContentList,
          secondaryTitleList: widget.secondaryTitleList,
          isSecondaryColumnEnabled: widget.isSecondaryColumnEnabled,
          circleRadius: widget.circleRadius,
          lineWidth: widget.lineWidth),
    );
  }
}

class ProgressWidgetPainter extends CustomPainter {
  final BuildContext _context;
  final bool _shouldIconHaveBackground;
  final List<TrackerStatus> _statusCompletedList;
  final bool _shouldIconHaveBorder;
  final int _nodeCount;
  final Color _inProgressColor;
  final double _circleRadius;
  final Color _completedColor;
  final Color _incompleteColor;
  final List<String> _titleList;
  final List<String> _contentList;
  final bool _isSecondaryColumnEnabled;
  final List<String>? _secondaryTitleList;
  final List<String>? _secondaryContentList;
  final TrackerAlignment _verticalTextAlign;
  final TextStyle _titleStyle;
  final TextStyle _contentStyle;
  final Color _iconBorderColor;
  final double? _secondaryColumnWidth;
  final double _lineWidth;
  final List<Icon>? _statusIcons;
  final double _iconSize;
  final TrackerBehaviour _behaviour;

  ProgressWidgetPainter({
    required behaviour,
    required iconSize,
    required context,
    required nodeCount,
    required inProgressColor,
    required incompleteColor,
    required titleList,
    required contentList,
    required isSecondaryColumnEnabled,
    required statusCompletedList,
    required circleRadius,
    required completedColor,
    required shouldIconHaveBorder,
    required lineWidth,
    required verticalTextAlgin,
    required titleStyle,
    required contentStyle,
    required iconBorderColor,
    required shouldIconHaveBackground,
    required secondaryColumnWidth,
    required secondaryContentList,
    required secondaryTitleList,
    required statusIcons,
  })  : assert(isSecondaryColumnEnabled
            ? secondaryContentList != null && secondaryTitleList != null
            : true),
        assert(statusIcons != null || circleRadius > 0),
        assert(
            titleList.length == nodeCount && contentList.length == nodeCount),
        assert(isSecondaryColumnEnabled
            ? secondaryTitleList.length == nodeCount &&
                secondaryContentList.length == nodeCount
            : true),
        assert(statusCompletedList.length == nodeCount),
        assert(statusIcons != null ? statusIcons.length == nodeCount : true),
        _behaviour = behaviour,
        _iconSize = iconSize,
        _verticalTextAlign = verticalTextAlgin,
        _titleStyle = titleStyle,
        _contentStyle = contentStyle,
        _completedColor = completedColor,
        _iconBorderColor = iconBorderColor,
        _context = context,
        _secondaryColumnWidth = secondaryColumnWidth,
        _nodeCount = nodeCount,
        _inProgressColor = inProgressColor,
        _incompleteColor = incompleteColor,
        _titleList = titleList,
        _contentList = contentList,
        _isSecondaryColumnEnabled = isSecondaryColumnEnabled,
        _secondaryContentList = secondaryContentList,
        _secondaryTitleList = secondaryTitleList,
        _statusCompletedList = statusCompletedList,
        _statusIcons = statusIcons,
        _circleRadius = circleRadius,
        _shouldIconHaveBorder = shouldIconHaveBorder,
        _lineWidth = lineWidth,
        _shouldIconHaveBackground = shouldIconHaveBackground;

  @override
  void paint(Canvas canvas, Size size) {
    //Initialize all variables to be used for painting
    bool shouldCompare = true;
    double contentTitleGap = 10.0;
    double availableHeight = size.height;
    double gapCorrectionForContentText = 35.0;
    double textGapWidth = 10.0;
    double strokeWidth = 4.0;
    double gapWidth = 15.0;
    double nodeWidth = size.width / 4;

    double primaryContentWidth = _isSecondaryColumnEnabled
        ? _secondaryColumnWidth == null
            ? ((size.width - nodeWidth) / 2)
            : (size.width - nodeWidth - _secondaryColumnWidth!.toDouble())
        : (size.width - nodeWidth);

    double lineLength = size.height / _nodeCount;

    double circleRadius = _circleRadius;
    double iconCircleRadius =
        _statusIcons != null ? _iconSize / 2 + gapWidth : 0;
    Offset iconCircleOffset = Offset(
        _isSecondaryColumnEnabled
            ? _secondaryColumnWidth != null
                ? _secondaryColumnWidth!.toDouble() +
                    circleRadius +
                    textGapWidth
                : size.width / 2
            : iconCircleRadius + strokeWidth,
        _shouldIconHaveBorder
            ? iconCircleRadius + strokeWidth
            : iconCircleRadius);
    Offset circleOffset = Offset(
        _isSecondaryColumnEnabled
            ? _secondaryColumnWidth != null
                ? _secondaryColumnWidth!.toDouble() +
                    circleRadius +
                    textGapWidth
                : size.width / 2
            : circleRadius,
        circleRadius);

    Offset lineOffset =
        Offset(_statusIcons != null ? iconCircleOffset.dx : circleOffset.dx, 0);

    Offset iconOffset = Offset(
        _isSecondaryColumnEnabled && _statusIcons != null
            ? circleOffset.dx - _iconSize / 2
            : _statusIcons != null
                ? gapWidth + strokeWidth
                : 0,
        _shouldIconHaveBorder ? strokeWidth + gapWidth : gapWidth);

    Offset titleOffset = Offset(
        _statusIcons != null
            ? iconCircleOffset.dx +
                iconCircleRadius +
                strokeWidth +
                textGapWidth
            : circleOffset.dx + circleRadius + textGapWidth,
        _verticalTextAlign == TrackerAlignment.top
            ? 0
            : _verticalTextAlign == TrackerAlignment.center
                ? _statusIcons != null
                    ? iconCircleRadius / 2
                    : circleRadius / 2
                : _statusIcons != null
                    ? iconCircleRadius / 2 + gapWidth
                    : circleRadius);

    double secondaryContentMaxWidth = _secondaryColumnWidth != null
        ? _secondaryColumnWidth!.toDouble() -
            (_statusIcons != null
                ? (iconCircleRadius + strokeWidth)
                : (circleRadius + textGapWidth))
        : primaryContentWidth;

    Offset secondaryTitleOffset = const Offset(0.0, 0.0);
    Offset secondaryContentOffset = const Offset(0.0, 0.0);

    Offset contentOffset;

    TextPainter titlePainter = TextPainter(
        textAlign: TextAlign.start, textDirection: TextDirection.ltr);
    TextPainter contentPainter = TextPainter(
        textAlign: TextAlign.start, textDirection: TextDirection.ltr);
    TextPainter secondaryTitlePainter =
        TextPainter(textAlign: TextAlign.end, textDirection: TextDirection.ltr);
    TextPainter secondaryContentPainter =
        TextPainter(textAlign: TextAlign.end, textDirection: TextDirection.ltr);
    TextPainter iconPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i < _nodeCount; i++) {
      // Get text for painting primary title
      titlePainter.text = TextSpan(text: _titleList[i], style: _titleStyle);

      // Get text for painting primary content
      contentPainter.text =
          TextSpan(text: _contentList[i], style: _contentStyle);

      //Layout primary title and content
      titlePainter.layout(maxWidth: primaryContentWidth);
      contentPainter.layout(maxWidth: primaryContentWidth);

      if (_isSecondaryColumnEnabled) {
        shouldCompare = true;

        // Get text for painting secondary title
        secondaryTitlePainter.text =
            TextSpan(text: _secondaryTitleList![i], style: _titleStyle);

        // Get text for painting secondary content
        secondaryContentPainter.text =
            TextSpan(text: _secondaryContentList![i], style: _contentStyle);

        // Layout secondary title and content
        secondaryTitlePainter.layout(maxWidth: secondaryContentMaxWidth);
        secondaryContentPainter.layout(maxWidth: secondaryContentMaxWidth);
      } else {
        shouldCompare = false;
      }

      if (shouldCompare) {
        if (secondaryContentPainter.height + secondaryTitlePainter.height >
                lineLength ||
            contentPainter.height + titlePainter.height > lineLength) {
          if (secondaryContentPainter.height + secondaryTitlePainter.height >
              contentPainter.height + titlePainter.height) {
            lineLength = lineLength +
                gapCorrectionForContentText +
                ((secondaryContentPainter.height +
                        secondaryTitlePainter.height) -
                    lineLength);

            availableHeight = availableHeight - lineLength;
          } else {
            lineLength = lineLength +
                gapCorrectionForContentText +
                ((contentPainter.height + titlePainter.height) - lineLength);

            availableHeight = availableHeight - lineLength;
          }
        }
      } else {
        if (contentPainter.height + titlePainter.height > lineLength) {
          lineLength = lineLength +
              gapCorrectionForContentText +
              ((contentPainter.height + titlePainter.height) - lineLength);

          availableHeight = availableHeight - lineLength;
        }
      }

      //Set all offsets and paint text
      titlePainter.paint(canvas, titleOffset);
      contentOffset = Offset(titleOffset.dx,
          titleOffset.dy + titlePainter.height + contentTitleGap);
      contentPainter.paint(canvas, contentOffset);
      if (_isSecondaryColumnEnabled) {
        secondaryTitleOffset = Offset(
            (lineOffset.dx -
                    (_statusIcons != null ? iconCircleRadius : circleRadius) -
                    gapWidth) -
                secondaryTitlePainter.width,
            titleOffset.dy);
        secondaryTitlePainter.paint(canvas, secondaryTitleOffset);
        secondaryContentOffset = Offset(
            (lineOffset.dx -
                    (_statusIcons != null ? iconCircleRadius : circleRadius) -
                    gapWidth) -
                secondaryContentPainter.width,
            secondaryTitleOffset.dy +
                secondaryTitlePainter.height +
                contentTitleGap);
        secondaryContentPainter.paint(canvas, secondaryContentOffset);
      }

      //Draw line emerging from node only if the node is not last node
      if (i != _nodeCount - 1) {
        canvas.drawLine(
            lineOffset,
            Offset(lineOffset.dx, lineOffset.dy + lineLength),
            Paint()
              ..color = _behaviour == TrackerBehaviour.nodeOnly &&
                      _statusCompletedList[i] == TrackerStatus.inProgress
                  ? _incompleteColor
                  : _statusCompletedList[i] == TrackerStatus.completed
                      ? _completedColor
                      : _statusCompletedList[i] == TrackerStatus.inProgress
                          ? _inProgressColor
                          : _incompleteColor
              ..style = PaintingStyle.fill
              ..strokeWidth = _lineWidth);
      }

      //Draw an empty circular node if no icon is provided else draw a circular node with an icon
      if (_statusIcons == null) {
        if (_shouldIconHaveBackground == false) {
          canvas.drawCircle(
              circleOffset,
              circleRadius,
              Paint()
                ..color = Theme.of(_context).colorScheme.surface
                ..style = PaintingStyle.fill);
        }
        canvas.drawCircle(
            circleOffset,
            circleRadius,
            Paint()
              ..color = _statusCompletedList[i] == TrackerStatus.completed
                  ? _completedColor
                  : _statusCompletedList[i] == TrackerStatus.inProgress
                      ? _inProgressColor
                      : _incompleteColor
              ..style = _shouldIconHaveBackground
                  ? PaintingStyle.fill
                  : PaintingStyle.stroke);
        if (_statusCompletedList[i] == TrackerStatus.inProgress) {
          canvas.drawCircle(
              circleOffset,
              circleRadius - 10,
              Paint()
                ..color = _incompleteColor
                ..style = PaintingStyle.fill);
        }
      } else {
        //Create icon by storing it in textpainter after converting icon to string using codePoint
        iconPainter.text = TextSpan(
            text: String.fromCharCode(_statusIcons![i].icon!.codePoint),
            style: TextStyle(
                fontSize: _iconSize,
                fontFamily: _statusIcons![i].icon!.fontFamily,
                color: _statusIcons![i].color));
        iconPainter.layout();

        //Draw the circular node which will contain the icon
        if (_shouldIconHaveBackground == true) {
          canvas.drawCircle(
              iconCircleOffset,
              iconCircleRadius,
              Paint()
                ..style = PaintingStyle.fill
                ..color = _statusCompletedList[i] == TrackerStatus.completed
                    ? _completedColor
                    : _statusCompletedList[i] == TrackerStatus.inProgress
                        ? _inProgressColor
                        : _incompleteColor);
        } else {
          canvas.drawCircle(
              iconCircleOffset,
              iconCircleRadius,
              Paint()
                ..style = PaintingStyle.fill
                ..color = Theme.of(_context).colorScheme.surface);
        }

        //Paint icon after laying out node
        iconPainter.paint(canvas, iconOffset);

        //Draw a circle for providing an outlining border to icon node if property is true
        if (_shouldIconHaveBorder == true) {
          canvas.drawCircle(
              iconCircleOffset,
              iconCircleRadius,
              Paint()
                ..style = PaintingStyle.stroke
                ..color = _iconBorderColor
                ..strokeWidth = strokeWidth);
        }
      }

      //Update all offsets for next iteration after painting is complete
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
