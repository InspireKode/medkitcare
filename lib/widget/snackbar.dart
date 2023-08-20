import 'package:fluttertoast/fluttertoast.dart';

class MyMessageHandler {
  static void showToast(bColor, msg, tColor) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: bColor,
        textColor: tColor);
  }
}
