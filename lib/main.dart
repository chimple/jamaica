import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jamaica/loca.dart';
import 'package:jamaica/screens/games_screen.dart';
import 'package:jamaica/screens/map_screen.dart';
import 'package:jamaica/screens/profile_screen.dart';
import 'package:jamaica/screens/home_screen.dart';
import 'package:jamaica/screens/store_screen.dart';
import 'package:jamaica/state/state_container.dart';

void main() => runApp(StateContainer(child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const LocaDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        const FallbackMaterialLocalisationsDelegate()
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('hi', ''),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePageWrapper(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        '/profile': (BuildContext context) => ProfileScreen(),
        '/map': (BuildContext context) => MapScreen(),
        '/games': (BuildContext context) => GamesScreen(),
        '/store': (BuildContext context) => StoreScreen(),
      },
    );
  }
}

class HomePageWrapper extends StatelessWidget {
  final String title;

  const HomePageWrapper({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
//
//class StackBox extends StatefulWidget {
//  @override
//  _StackBoxState createState() => _StackBoxState();
//}
//
//class _StackBoxState extends State<StackBox> {
//  double left = 10.0;
//  double top = 10.0;
//
//  @override
//  Widget build(BuildContext context) {
//    print('StackBoxState:build: $left $top');
//    return LayoutBuilder(
//      builder: (context, constraints) => DragTarget<String>(
//            builder:
//                (BuildContext context, List<String> accepted, List rejected) =>
//                    Stack(
//                      children: <Widget>[
//                        Container(
//                          color: Colors.blueAccent,
//                        ),
//                        AnimatedPositioned(
//                          child: Draggable(
//                            child: RaisedButton(
//                              onPressed: () => setState(() {
//                                    left = left + 10.0;
//                                    top = top + 10.0;
//                                  }),
//                              child: Text('Hi'),
//                            ),
//                            feedback: RaisedButton(
//                              child: Text('Hi'),
//                              onPressed: () {},
//                            ),
//                            data: 'Hi',
//                            onDragEnd: (DraggableDetails d) {
//                              if (!d.wasAccepted) {
//                                print('not accepted: ${d.offset}');
//                                setState(() {
//                                  left = d.offset.dx;
//                                  top = d.offset.dy;
//                                });
//                              }
//                            },
//                          ),
//                          duration: Duration.zero,
//                          top: top,
//                          left: left,
//                        ),
//                      ],
//                    ),
//            onWillAccept: (String data) => false,
//          ),
//    );
//  }
//}
//
//class Chimp extends StatefulWidget {
//  @override
//  _ChimpState createState() => _ChimpState();
//}
//
//class _ChimpState extends State<Chimp> implements FlareController {
//  ActorNode shape;
//  double xScale;
//  double yScale;
//  AABB aabb;
//
//  @override
//  Widget build(BuildContext context) {
//    final media = MediaQuery.of(context);
//    print('build');
//    return Container(
//      color: Colors.blueAccent,
//      child: GestureDetector(
//        onTapDown: (TapDownDetails t) {
//          print(t.globalPosition.toString());
//          RenderBox getBox = context.findRenderObject();
//          var local = getBox.globalToLocal(t.globalPosition);
//          print('${local.dx * xScale}, ${local.dy * yScale}');
//        },
//        child: new FlareActor(
//          "assets/chimp.flr",
//          alignment: Alignment.topLeft,
//          fit: BoxFit.contain,
//          animation: "Untitled",
//          controller: this,
//        ),
//      ),
//    );
//  }
//
//  @override
//  bool advance(FlutterActorArtboard artboard, double elapsed) {
////    print('advance');
////    shape.collapsedVisibility = false;
//    return false;
//  }
//
//  @override
//  void initialize(FlutterActorArtboard artboard) {
////    print('initialize');
//    final hat1 = artboard.getNode("hat2");
//    hat1.collapsedVisibility = true;
//    final glasses1 = artboard.getNode("glasses2");
//    glasses1.collapsedVisibility = true;
//
////    final shape = artboard.getNode("hat2Shape1") as FlutterActorShape;
////    print(shape.computeAABB());
////    print((artboard.getNode("r1") as FlutterActorShape).computeAABB());
////    print((artboard.getNode("r2") as FlutterActorShape).computeAABB());
////    print((artboard.getNode("r3") as FlutterActorShape).computeAABB());
////    print((artboard.getNode("r4") as FlutterActorShape).computeAABB());
////    print(artboard.artboardAABB());
////    print(artboard.computeAABB());
////    aabb = artboard.computeAABB();
//  }
//
//  @override
//  void setViewTransform(Mat2D viewTransform) {
////    print('setViewTransform');
//    // TODO: implement setViewTransform
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  List<Vector2> positions;
//  List<Widget> widgets;
//  ValueNotifier<DateTime> valueNotifier;
//  FlowDelegate flowDelegate;
//
//  @override
//  void initState() {
//    super.initState();
//    widgets = [
//      MoveableWidget(
//        key: ValueKey(0),
//        child: Container(
//          color: Colors.blue,
//          child: Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Text('Hi'),
//          ),
//        ),
//        onMove: _onMove,
//      ),
//      MoveableWidget(
//        key: ValueKey(1),
//        child: Container(
//          color: Colors.red,
//          child: Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Text('Hello'),
//          ),
//        ),
//        onMove: _onMove,
//      )
//    ];
//    int i = 0;
//    positions = widgets.map((w) => Vector2(0.0, 0.0)).toList(growable: false);
//    valueNotifier = ValueNotifier<DateTime>(DateTime.now());
//    flowDelegate = MyFlowDelegate(
//        repaint: valueNotifier, children: widgets, positions: positions);
//  }
//
//  void _onMove(Key key, Offset offset) {
//    int i = (key as ValueKey<int>).value;
////    print("_onMove: ${positions[i]} $offset");
//    positions[i] = Vector2(offset.dx, offset.dy);
//    valueNotifier.value = DateTime.now();
//  }
//
//  Widget build(BuildContext context) {
//    print("_MyHomePageState:build");
//    return Flow(
//      delegate: flowDelegate,
//      children: widgets,
//    );
//  }
//}
//
//class MyFlowDelegate extends FlowDelegate {
//  final List<Widget> children;
//  final List<Vector2> positions;
//
//  MyFlowDelegate({this.children, this.positions, Listenable repaint})
//      : super(repaint: repaint);
//
//  @override
//  void paintChildren(FlowPaintingContext context) {
////    print("MyFlowDelegate:paint");
//    for (var i = 0; i < children.length; i++) {
//      context.paintChild(i,
//          transform:
//              Matrix4.translationValues(positions[i].x, positions[i].y, 0));
//    }
//  }
//
//  @override
//  bool shouldRepaint(FlowDelegate oldDelegate) {
//    // TODO: implement shouldRepaint
//    print('shouldRepaint');
//    return true;
//  }
//}
//
//class MoveableWidget extends StatelessWidget {
//  final Widget child;
//  final Function onMove;
//  final Key key;
//
//  const MoveableWidget({this.key, this.child, this.onMove}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    print("MoveableWidget:build");
//    return GestureDetector(
//      child: child,
//      onPanStart: (DragStartDetails d) => onMove(this.key, d.globalPosition),
//      onPanUpdate: (DragUpdateDetails d) => onMove(this.key, d.globalPosition),
//    );
//  }
//}
//
//class MyMultiChildLayout extends StatefulWidget {
//  @override
//  _MyMultiChildLayoutState createState() => _MyMultiChildLayoutState();
//}
//
//class _MyMultiChildLayoutState extends State<MyMultiChildLayout> {
//  @override
//  Widget build(BuildContext context) {
//    List<Widget> children = [
//      LayoutId(
//        id: 0,
//        child: Container(
//          color: Colors.red,
//          child: Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Text('Hi'),
//          ),
//        ),
//      ),
//      LayoutId(
//        id: 1,
//        child: Container(
//          color: Colors.blue,
//          child: Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Text('Hello'),
//          ),
//        ),
//      )
//    ];
//    return CustomMultiChildLayout(
//      delegate: MyMultiChildLayoutDelegate(count: 2),
//      children: children,
//    );
//  }
//}
//
//class MyMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
//  final int count;
//
//  MyMultiChildLayoutDelegate({this.count});
//  @override
//  void performLayout(Size size) {
//    for (int i = 0; i < count; i++) {
//      layoutChild(i, BoxConstraints.tight(size / 2));
//      positionChild(i, Offset(size.width / 2 * i, size.height / 2 * i));
//    }
//  }
//
//  @override
//  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
//    return false;
//  }
//}
//
//class UnitBox extends StatefulWidget {
//  @override
//  _UnitBoxState createState() => _UnitBoxState();
//}
//
//class _UnitBoxState extends State<UnitBox> {
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}
//
//class TransformBox extends AnimatedWidget {
//  final Widget child;
//  final Animation<Matrix4> listenable;
//
//  TransformBox({Key key, this.child, this.listenable})
//      : super(key: key, listenable: listenable);
//
//  @override
//  Widget build(BuildContext context) {
//    return Transform(
//      transform: listenable.value,
//      child: child,
//    );
//  }
//}
