import 'package:flutter/material.dart';
import 'package:newsapp/Constants/constants.dart';

class ShimmerInterNews extends StatelessWidget {
  const ShimmerInterNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).orientation == Orientation.landscape ? 300 : 250,
        decoration: BoxDecoration(
          borderRadius: borderRadius2,
          color: greyColor,
        ),
        child: CircularProgressIndicator(
          color: cyanColor,
        ),
      ),
    );
  }
}
