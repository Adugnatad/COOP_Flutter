import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Color Colo;
  const Background({Key key, @required this.child, @required this.Colo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colo,
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}
