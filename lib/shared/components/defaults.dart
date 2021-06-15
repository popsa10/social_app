import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../styles/constants.dart';

Widget buildDivider({@required Color color}) => Container(
      height: 1,
      width: double.infinity,
      color: color,
    );

Widget defaultAppbar(
        {String title, @required BuildContext context, List<Widget> actions}) =>
    AppBar(
      title: Text(title),
      titleSpacing: 5,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(IconBroken.Arrow___Left_2),
      ),
      actions: actions,
    );

Widget defaultFormField({
  @required TextEditingController controller,
  bool isPassword = false,
  @required String label,
  @required Function validate,
  @required IconData prefix,
  @required TextInputType type,
  IconData suffix,
  Function onChange,
  Function onTap,
  Function onSubmit,
  Function suffixFunction,
}) =>
    TextFormField(
      controller: controller,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      keyboardType: type,
      validator: validate,
      onChanged: onChange,
      obscureText: isPassword,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          suffixIcon: InkWell(
            child: Icon(suffix),
            onTap: suffixFunction,
          ),
          prefixIcon: Icon(prefix)),
    );

Future<dynamic> navigateTo({@required context, @required Widget page}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));

Future<dynamic> navigateToAndFinish({
  @required context,
  @required Widget page,
}) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
        (route) => false);

Future<bool> showToast({
  @required String text,
  @required Color color,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);

Widget defaultButton({
  @required String text,
  @required Function function,
  double width = double.infinity,
  double height = 40,
}) =>
    MaterialButton(
      color: appColor,
      height: height,
      minWidth: width,
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
Widget defaultTextButton(
        {@required Function function, @required String text}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));
