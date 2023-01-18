import 'package:flutter/material.dart';
import 'package:newsapp/Constants/constants.dart';

class CategoryWidget extends StatelessWidget {

  final String categoryName;
  final Color color;

  const CategoryWidget({Key? key,required this.categoryName,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,top: 5.0,bottom: 5.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),bottomRight: Radius.circular(5),
            topRight: Radius.circular(15),bottomLeft: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(categoryName,style: categoryStyle),
        ),
      ),
    );
  }
}
