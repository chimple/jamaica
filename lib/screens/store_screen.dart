import 'package:flutter/material.dart';
import 'package:jamaica/models/accessories_data.dart';
import 'package:jamaica/widgets/bubble_tab_indicator.dart';
import 'package:jamaica/widgets/chimp_character.dart';
import 'package:tuple/tuple.dart';

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Store'),
        ),
        body: Store());
  }
}

class Store extends StatefulWidget {
  Store({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new StoreWidget(items: list);
  }
}

class StoreWidget extends State<Store> with SingleTickerProviderStateMixin {
  final Map<Accessories, List<AccessoriesData>> items;
  final int itemCrossAxisCount;
  TabController _tabController;
  List<Tab> tabs;
  List<int> _colorStatus = [];
  String itemName;
  int coin = 1000;
  int _itemCount = 0;
  List<Tuple4<String, String, int, int>> itemRange =
      List<Tuple4<String, String, int, int>>();
  StoreWidget({this.items, this.itemCrossAxisCount = 4});

  @override
  void initState() {
    super.initState();
    items.forEach((e, l) {
      itemRange.add(Tuple4(e.imageName, e.categoryName, _itemCount,
          _itemCount + (l.length / itemCrossAxisCount).ceil()));
      _itemCount += (l.length / itemCrossAxisCount).ceil();
    });
    for (int i = 0; i < _itemCount; i++) _colorStatus.add(0);
    _tabController = new TabController(vsync: this, length: itemRange.length)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _tab(String text) {
    return new Tab(
      child: SizedBox(
        child: Image.asset(
          text,
          color: Colors.white,
        ),
        width: 40.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return new Scaffold(
        body: Container(
            color: Colors.indigo[900],
            child: mediaQuery.orientation == Orientation.portrait
                // For Portrait mode
                ? Column(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.indigo[50].withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0))),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Text('Coins is $coin',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Chimp(
                                  itemName: itemName,
                                  key: new GlobalObjectKey(itemName),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: new TabBar(
                                  isScrollable: true,
                                  indicator: new BubbleTabIndicator(
                                    indicatorHeight: 50.0,
                                    indicatorColor: Colors.red,
                                    tabBarIndicatorSize:
                                        TabBarIndicatorSize.tab,
                                  ),
                                  tabs: itemRange.map((s) {
                                    return _tab(s.item1);
                                  }).toList(growable: false),
                                  controller: _tabController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(flex: 5, child: displayAccessories()),
                    ],
                  )
                //For LandScape Mode
                : Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.indigo[50].withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Text('Coins is $coin',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    )),
                              ),
                              Expanded(
                                flex: 1,
                                child: Chimp(
                                  itemName: itemName,
                                  key: new GlobalObjectKey(itemName),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: new TabBar(
                                  isScrollable: true,
                                  unselectedLabelColor: Colors.grey,
                                  labelColor: Colors.black,
                                  indicator: new BubbleTabIndicator(
                                    indicatorHeight: 65.0,
                                    indicatorColor: Colors.red,
                                    tabBarIndicatorSize:
                                        TabBarIndicatorSize.tab,
                                  ),
                                  tabs: itemRange.map((s) {
                                    return _tab(s.item1);
                                  }).toList(growable: false),
                                  controller: _tabController,
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: displayAccessories(),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )));
  }

  Widget displayAccessories() {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      child: new TabBarView(
        controller: _tabController,
        children: items.keys
            .map((r) => CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        child: Text(
                          r.categoryName,
                          style: TextStyle(
                              fontSize: mediaQuery.size.height * 0.03,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(top: 0.0),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:
                                mediaQuery.orientation == Orientation.portrait
                                    ? 0.70
                                    : 0.82,
                            crossAxisCount: 5),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: _colorStatus[index] == 0
                                        ? Colors.indigo[300]
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  height: mediaQuery.orientation ==
                                          Orientation.portrait
                                      ? mediaQuery.size.height * 0.07
                                      : mediaQuery.size.height * 0.10,
                                  width: mediaQuery.orientation ==
                                          Orientation.portrait
                                      ? mediaQuery.size.width * 0.14
                                      : mediaQuery.size.width * 0.06,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        itemName = items[r]
                                            .elementAt(index)
                                            .categoryName;
                                        if (_colorStatus[index] ==
                                            0) if (coin <= 0)
                                          coin = 0;
                                        else
                                          coin = coin - 100;

                                        _colorStatus[index] = 1;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        items[r].elementAt(index).imageName,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                ),
                                Text(
                                  items[r].elementAt(index).categoryName,
                                  style: TextStyle(
                                    fontSize: mediaQuery.orientation ==
                                            Orientation.portrait
                                        ? mediaQuery.size.height * 0.018
                                        : mediaQuery.size.height * 0.03,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Icon(
                                      Icons.add_circle,
                                      color: Colors.yellow[700],
                                    ),
                                    Text(
                                      items[r].elementAt(index).coin.toString(),
                                      style: TextStyle(
                                        fontSize: mediaQuery.orientation ==
                                                Orientation.portrait
                                            ? mediaQuery.size.height * 0.018
                                            : mediaQuery.size.height * 0.03,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            );
                          },
                          childCount: items[r].length,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 2.0,
                      ),
                    )
                  ],
                ))
            .toList(growable: false),
      ),
    );
  }
}
