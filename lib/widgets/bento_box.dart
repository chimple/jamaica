import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jamaica/widgets/cute_button.dart';

enum DragConfig {
  fixed,
  draggableBounceBack,
  draggableNoBounceBack,
  draggableMultiPack
}

typedef CalculateLayout = void Function({
  int cols,
  int rows,
  List<Widget> children,
  int qCols,
  int qRows,
  List<Widget> qChildren,
  Map<Key, _ChildDetail> childrenMap,
  Size size,
});

class BentoBox extends StatefulWidget {
  final List<Widget> children;
  final List<Widget> qChildren;
  final List<Widget> frontChildren;
  final int cols;
  final int rows;
  final int qCols;
  final int qRows;
  final CalculateLayout calculateLayout;
  final Axis axis;
  final DragConfig dragConfig;

  const BentoBox({
    Key key,
    this.cols,
    this.rows,
    this.children,
    this.calculateLayout = calculateVerticalLayout,
    this.axis,
    this.dragConfig = DragConfig.fixed,
    this.frontChildren,
    this.qChildren,
    this.qCols = 0,
    this.qRows = 0,
  }) : super(key: key);

  @override
  _BentoBoxState createState() => _BentoBoxState();

  static calculateVerticalLayout(
      {int cols,
      int rows,
      List<Widget> children,
      int qCols,
      int qRows,
      List<Widget> qChildren,
      Map<Key, _ChildDetail> childrenMap,
      Size size}) {
    final allRows = rows + qRows;
    final allCols = max(cols, qCols);
    final childWidth = size.width / allCols;
    final childHeight = size.height / allRows;
    print(
        " this my new width ${size.width} and new height ${size.height} and child width is $childWidth and $childHeight");
    int i = 0;
    (qChildren ?? []).forEach((c) => childrenMap[c.key] = _ChildDetail(
          child: c,
          offset: Offset(((allCols - qCols) / 2 + (i % qCols)) * childWidth,
              (i++ ~/ qCols) * childHeight),
        ));
    i = 0;
    children.forEach((c) => childrenMap[c.key] = _ChildDetail(
          child: c,
          offset: Offset(((allCols - cols) / 2 + (i % cols)) * childWidth,
              (qRows + (i++ ~/ cols)) * childHeight),
        ));
  }

  static calculateHorizontalLayout(
      {int cols,
      int rows,
      List<Widget> children,
      int qCols,
      int qRows,
      List<Widget> qChildren,
      Map<Key, _ChildDetail> childrenMap,
      Size size}) {
    // final allRows = rows + qRows;
    // final allCols = max(cols, qCols);
    final allRows = max(rows, qRows);
    final allCols = cols + qCols;
    final childWidth = size.width / allCols;
    final childHeight = size.height / allRows;
    int i = 0;

    (qChildren ?? []).forEach((c) => childrenMap[c.key] = _ChildDetail(
          child: c,
          offset: Offset((i ~/ qRows) * childWidth,
              ((allRows - qRows) / 2 + (i++ % qRows)) * childHeight),
        ));
    i = 0;
    (qChildren ?? []).forEach((c) => print('$c, <>'));
    children.forEach((c) => childrenMap[c.key] = _ChildDetail(
          child: c,
          offset: Offset((qCols + (i ~/ qRows)) * childWidth,
              ((allRows - qRows) / 2 + (i++ % qRows)) * childHeight),
        ));
    (children ?? []).forEach((c) => print('$c, <<>>'));
  }

  static calculateCustomizedLayout(
      {int cols,
      int rows,
      List<Widget> children,
      int qCols,
      int qRows,
      List<Widget> qChildren,
      Map<Key, _ChildDetail> childrenMap,
      Size size}) {
    final allRows = rows + qRows;
    final allCols = max(cols, qCols);
    final childWidth = size.width / allCols;
    final childHeight = size.height / allRows;
    print(
        "this my new width ${size.width} and new height ${size.height} and child width is $childWidth and $childHeight and rows $allRows colmun $allCols");
    int i = 0;

    Offset center = Offset((qCols + (i ~/ qRows)) * (childWidth) * 1.5,
        ((allRows - qRows) / 2 + (i++ % qRows)) * childHeight);
    i = 0;
    (qChildren ?? []).forEach((c) => childrenMap[c.key] = _ChildDetail(
          child: c,
          offset: center,
        ));

    double j = 0;
    double k = 2 * pi / children.length;
    children.forEach((f) {
      childrenMap[f.key] = _ChildDetail(
        child: f,
        offset: Offset((center.dx + childWidth * 1.2 * (cos(j).toInt())),
            (center.dy + childHeight * .5 * (sin(j).toInt()))),
      );
      j = j + k;
    });
  }

  static calculateRandomizedLayout(
      {int cols,
      int rows,
      List<Widget> children,
      int qCols,
      int qRows,
      List<Widget> qChildren,
      Map<Key, _ChildDetail> childrenMap,
      Size size}) {
    final childWidth = size.width / cols;
    final childHeight = size.height / rows;

    Random random = Random();
    (qChildren ?? []).forEach((c) => childrenMap[c.key] = _ChildDetail(
        child: c,
        offset: Offset(random.nextDouble() * size.width,
            random.nextDouble() * size.height)));
    children.forEach((c) => childrenMap[c.key] = _ChildDetail(
        child: c,
        offset: Offset(max(0, random.nextDouble() * size.width - childWidth),
            max(0, random.nextDouble() * size.height - childHeight))));
  }
}

class _ChildDetail {
  final Widget child;
  Offset offset;
  bool moveImmediately;

  _ChildDetail({this.child, this.offset, this.moveImmediately = false});

  @override
  String toString() =>
      '_ChildDetail(child: $child, offset: $offset, moveImmediately: $moveImmediately)';
}

class _BentoBoxState extends State<BentoBox> {
  Map<Key, _ChildDetail> _children;
  Size size;
  int rows;
  int cols;

  @override
  void initState() {
    super.initState();
    _children = {};
    size = Size(1024.0, 1024.0); //Nominal size
    calculateLayout(true);
  }

  void calculateLayout(bool reCalculate) {
    int k = 0;
    if (widget.calculateLayout == BentoBox.calculateHorizontalLayout) {
      rows = max(widget.rows, widget.qRows);
      cols = widget.cols + widget.qCols;
    } else {
      rows = widget.rows + widget.qRows;
      cols = max(widget.cols, widget.qCols);
    }
    final childWidth = size.width / cols;
    final childHeight = size.height / rows;

    (widget.frontChildren ?? []).forEach((c) => _children[c.key] = _ChildDetail(
        child: c,
        offset: Offset(
            ((cols - widget.frontChildren.length) / 2 + k++) * childWidth,
            (rows - 1) / 2 * childHeight)));
    if (reCalculate ||
        widget.calculateLayout != BentoBox.calculateRandomizedLayout) {
      widget.calculateLayout(
          cols: widget.cols,
          rows: widget.rows,
          children: widget.children,
          qCols: widget.qCols,
          qRows: widget.qRows,
          qChildren: widget.qChildren,
          childrenMap: _children,
          size: size);
    } else {
      print("this is false reload");
    }
  }

  @override
  void didUpdateWidget(BentoBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.frontChildren != widget.frontChildren ||
        oldWidget.qChildren != widget.qChildren ||
        oldWidget.children != widget.children) {
      calculateLayout(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('BentoBox:build');
    return LayoutBuilder(builder: (context, constraints) {
      var i = 0;
      final biggest = constraints.biggest;
      print("this is my biggest $biggest");
      List<Widget> widgets = [Container()];
      Size childSize = Size(biggest.width / cols, biggest.height / rows);

      widgets.addAll((widget.qChildren ?? []).map((child) {
        final c = _children[child.key];
        if (size != biggest) {
          c.offset = c.offset
              .scale(biggest.width / size.width, biggest.height / size.height);
        }
        return c.child.key == null
            ? Positioned(
                child: buildChild(childSize, c.child),
                left: c.offset.dx,
                top: c.offset.dy)
            : AnimatedPositioned(
                key: ValueKey(c.child.key),
                child: buildChild(childSize, c.child),
                duration: c.moveImmediately
                    ? Duration.zero
                    : Duration(milliseconds: 500),
                left: c.offset.dx,
                top: c.offset.dy);
      }));

      widgets.addAll(widget.children.map((child) {
        final c = _children[child.key];
        if (c == null) {
          print('null ${child.key}');
          return Positioned(
            child: Container(),
          );
        }
        if (size != biggest) {
          c.offset = c.offset
              .scale(biggest.width / size.width, biggest.height / size.height);
        }
        return c.child.key == null
            ? Positioned(
                child: buildChild(childSize, c.child),
                left: c.offset.dx,
                top: c.offset.dy)
            : AnimatedPositioned(
                key: ValueKey(c.child.key),
                child: wrapWithDraggable(childSize, c),
                duration: c.moveImmediately
                    ? Duration.zero
                    : Duration(milliseconds: 500),
                left: c.offset.dx,
                top: c.offset.dy);
      }));

      widgets.addAll((widget.frontChildren ?? []).map((child) {
        final c = _children[child.key];
        if (size != biggest) {
          c.offset = c.offset
              .scale(biggest.width / size.width, biggest.height / size.height);
        }
        return AnimatedPositioned(
          key: ValueKey(c.child.key),
          child: wrapWithDraggable(childSize, c),
          duration: Duration(milliseconds: 500),
          left: c.offset.dx,
          top: c.offset.dy,
        );
      }));
      size = constraints.biggest;
      return Stack(
        overflow: Overflow.visible,
        children: widgets,
      );
    });
  }

  Widget wrapWithDraggable(Size childSize, _ChildDetail c) {
    return widget.dragConfig == DragConfig.fixed
        ? buildChild(childSize, c.child)
        : Draggable(
            axis: widget.axis,
            child: buildChild(childSize, c.child),
            childWhenDragging:
                widget.dragConfig == DragConfig.draggableMultiPack
                    ? null
                    : Container(),
            feedback: buildChild(childSize, c.child),
            data: (c.child.key as ValueKey<String>).value,
            onDragEnd: (d) {
              print("c was accepted: ${d.wasAccepted}");
              setState(() {
                if (!d.wasAccepted &&
                    widget.dragConfig == DragConfig.draggableBounceBack) {
                  final currentOffset = Offset(c.offset.dx, c.offset.dy);
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => setState(() {
                            c.offset = currentOffset;
                            c.moveImmediately = false;
                          }));
                }
                if (widget.dragConfig != DragConfig.draggableMultiPack) {
                  c.offset = (context.findRenderObject() as RenderBox)
                      .globalToLocal(d.offset);
                  c.moveImmediately = true;
                }
              });
            },
          );
  }

  Widget buildChild(Size size, Widget child) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
