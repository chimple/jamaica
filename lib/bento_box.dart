import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jamaica/cute_button.dart';

enum DragConfig {
  fixed,
  draggableBounceBack,
  draggableNoBounceBack,
  draggableMultiPack
}

class BentoBox extends StatefulWidget {
  final List<Widget> children;
  final List<Widget> qChildren;
  final List<Widget> frontChildren;
  final int cols;
  final int rows;
  final int qCols;
  final int qRows;
  final bool randomize;
  final DragConfig dragConfig;

  const BentoBox({
    Key key,
    this.cols,
    this.rows,
    this.children,
    this.randomize = false,
    this.dragConfig = DragConfig.fixed,
    this.frontChildren,
    this.qChildren,
    this.qCols = 0,
    this.qRows = 0,
  }) : super(key: key);

  @override
  _BentoBoxState createState() => _BentoBoxState();
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
  List<_ChildDetail> childDetails;
  List<_ChildDetail> qChildDetails;
  List<_ChildDetail> frontChildDetails;
  Size size;
  int rows;
  int cols;

  @override
  void initState() {
    super.initState();
    calculateLayout();
  }

  void calculateLayout() {
    print(widget.frontChildren);
    Random random = Random();
    size = Size(1024.0, 1024.0);
    int k = 0;
    rows = widget.rows + widget.qRows;
    cols = max(widget.cols, widget.qCols);
    final childWidth = size.width / cols;
    final childHeight = size.height / rows;

    frontChildDetails = (widget.frontChildren ?? []).map((c) {
      return _ChildDetail(
          child: c,
          offset: Offset(
              ((cols - widget.frontChildren.length) / 2 + k++) * childWidth,
              (rows - 1) / 2 * childHeight));
    }).toList(growable: false);
    int i = 0;
    qChildDetails = (widget.qChildren ?? []).map((c) {
      final childDetail = _ChildDetail(
        child: c,
        offset: widget.randomize
            ? Offset(random.nextDouble() * size.width,
                random.nextDouble() * size.height)
            : Offset((i % widget.qCols) * childWidth,
                (i++ ~/ widget.qCols) * childHeight),
      );
      return childDetail;
    }).toList(growable: false);

    i = 0;
    childDetails = widget.children.map((c) {
      final childDetail = _ChildDetail(
        child: c,
        offset: widget.randomize
            ? Offset(random.nextDouble() * size.width,
                random.nextDouble() * size.height)
            : Offset((i % widget.cols) * childWidth,
                (i++ ~/ widget.cols) * childHeight),
      );
      return childDetail;
    }).toList(growable: false);
  }

  @override
  void didUpdateWidget(BentoBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.children != widget.children ||
        oldWidget.frontChildren != widget.frontChildren ||
        oldWidget.rows != widget.rows ||
        oldWidget.cols != widget.cols) {
      calculateLayout();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('BentoBox:build');
    print(childDetails);
    print(qChildDetails);
    return LayoutBuilder(builder: (context, constraints) {
      var i = 0;
      final biggest = constraints.biggest;
      List<Widget> widgets = [Container()];
      Size childSize = Size(biggest.width / cols, biggest.height / rows);

      widgets.addAll(qChildDetails.map((c) {
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
                child: buildOuterChild(childSize, c),
                duration: c.moveImmediately
                    ? Duration.zero
                    : Duration(milliseconds: 500),
                left: c.offset.dx,
                top: c.offset.dy);
      }));

      widgets.addAll(childDetails.map((c) {
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
                child: buildOuterChild(childSize, c),
                duration: c.moveImmediately
                    ? Duration.zero
                    : Duration(milliseconds: 500),
                left: c.offset.dx,
                top: c.offset.dy);
      }));

      widgets.addAll(frontChildDetails.map((c) {
        if (size != biggest) {
          c.offset = c.offset
              .scale(biggest.width / size.width, biggest.height / size.height);
        }
        return AnimatedPositioned(
          key: ValueKey(c.child.key),
          child: buildOuterChild(childSize, c),
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

  Widget buildOuterChild(Size childSize, _ChildDetail c) {
    return widget.dragConfig == DragConfig.fixed
        ? buildChild(childSize, c.child)
        : Draggable(
            child: buildChild(childSize, c.child),
            childWhenDragging:
                widget.dragConfig == DragConfig.draggableMultiPack
                    ? null
                    : Container(),
            feedback: buildChild(childSize, c.child),
            data: (c.child.key as ValueKey<String>).value,
            onDragEnd: (d) {
              if (!d.wasAccepted) {
                setState(() {
                  if (widget.dragConfig == DragConfig.draggableBounceBack) {
                    final currentOffset = Offset(c.offset.dx, c.offset.dy);
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => setState(() {
                              c.offset = currentOffset;
                              c.moveImmediately = false;
                            }));
                  }
                  c.offset = (context.findRenderObject() as RenderBox)
                      .globalToLocal(d.offset);
                  c.moveImmediately = true;
                });
              }
            },
          );
  }

  Widget buildChild(Size size, Widget child) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
