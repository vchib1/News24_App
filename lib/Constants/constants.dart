import 'package:flutter/material.dart';

Color greyColor = Colors.grey.shade200;
Color cyanColor = Colors.cyan.shade200;

const TextStyle breakingNewsBanner = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 16,
);

const TextStyle categoryStyle = TextStyle(
  fontSize: 16,
);

const TextStyle topNews = TextStyle(fontSize: 20,fontWeight: FontWeight.bold);
const TextStyle appBar = TextStyle(fontSize: 20,fontWeight: FontWeight.bold);

const BorderRadius borderRadius = BorderRadius.only(
topLeft: Radius.circular(15),bottomRight: Radius.circular(15),
topRight: Radius.circular(5),bottomLeft: Radius.circular(5),
);

const BorderRadius borderRadius2 = BorderRadius.only(
  topLeft: Radius.circular(15),bottomRight: Radius.circular(15),
  topRight: Radius.circular(5),bottomLeft: Radius.circular(15),
);