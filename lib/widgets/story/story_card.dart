import 'package:flutter/material.dart';
import 'package:data/data.dart';
import 'package:jamaica/widgets/story/story_page.dart';

class StoryCard extends StatelessWidget {
  final index;
  final StoryConfig storyConfig;
  StoryCard({this.index, @required this.storyConfig});
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        margin: EdgeInsets.only(
            top: constraint.maxHeight * .07,
            left: constraint.maxHeight * .07,
            right: constraint.maxHeight * .07),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(constraint.maxHeight * .16),
            border: Border.all(
              width: 1.0,
              color: Colors.white,
            )),
        child: InkWell(
          enableFeedback: true,
          excludeFromSemantics: true,
          splashColor: Colors.grey,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StoryPage(
                    pages: storyConfig.pages, title: storyConfig.title)));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(constraint.maxHeight * .16),
                          topRight:
                              Radius.circular(constraint.maxHeight * .16)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/stories/images/${storyConfig.coverImagePath}'))),
                  child: Container(),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    storyConfig.title,
                    style: TextStyle(fontSize: constraint.maxHeight * .1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class _InteractiveInkFeatureFactory extends InteractiveInkFeatureFactory {
  InteractiveInkFeature _interactiveInkFeature;
  @override
  InteractiveInkFeature create(
      {MaterialInkController controller,
      RenderBox referenceBox,
      Offset position,
      Color color,
      TextDirection textDirection,
      bool containedInkWell = false,
      rectCallback,
      BorderRadius borderRadius,
      ShapeBorder customBorder,
      double radius,
      onRemoved}) {
    return _interactiveInkFeature..color = Colors.red;
  }
}
