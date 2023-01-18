import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Constants/constants.dart';

class InternationalNews extends StatelessWidget {

  final String title;
  final String image;

  const InternationalNews({Key? key,required this.title,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: CachedNetworkImageProvider(image,),
                fit: BoxFit.cover,
              )
            ),
          ),
          Container(
            height: 85,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.4),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),bottomRight: Radius.circular(15),
                topRight: Radius.circular(5),bottomLeft: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
              child: Text(title,style: breakingNewsBanner),
            ),
          ),
        ],
      ),
    );
  }
}
