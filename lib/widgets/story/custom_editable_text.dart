import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomEditableText extends EditableText {
  CustomEditableText(
      {@required TextEditingController controller,
      @required TextStyle style,
      @required Color cursorColor,
      FocusNode focusNode,
      bool autofocus = false,
      Color selectionColor})
      : super(
          controller: controller,
          focusNode: CustomEditableTextFocusNode(),
          style: style,
          maxLines: null,
          cursorColor: cursorColor,
          autofocus: autofocus,
          selectionColor: selectionColor,
        );

  @override
  EditableTextState createState() {
    return EditableTextState();
  }
}

class CustomEditableTextState extends EditableTextState {
  @override
  void requestKeyboard() {
    super.requestKeyboard();

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class CustomEditableTextFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
