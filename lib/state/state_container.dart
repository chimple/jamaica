import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:jamaica/models/app_state.dart';
import 'package:jamaica/models/user_profile.dart';

class StateContainer extends StatefulWidget {
  final AppState state;
  final Widget child;

  const StateContainer({Key key, this.state, this.child}) : super(key: key);

  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  AppState state;

  @override
  void initState() {
    super.initState();
    state = widget.state ?? AppState.loading();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  void setAccessories(BuiltMap<String, String> accessories) {
    setState(() {
      state = AppState((s) => s
        ..userProfile.accessories = accessories
        ..isLoading = state.isLoading);
    });
  }

  void setCurrentTheme(String t) {
    state = AppState((s) => s
      ..userProfile.currentTheme = t
      ..isLoading = state.isLoading);
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // Note: we could get fancy here and compare whether the old AppState is
  // different than the current AppState. However, since we know this is the
  // root Widget, when we make changes we also know we want to rebuild Widgets
  // that depend on the StateContainer.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
