import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Constants/constants.dart';

class MainHeadlines extends StatelessWidget {

  final String title;
  final String urlToImage;
  final String description;

  const MainHeadlines({super.key,
    required this.title,
    required this.description,
    required this.urlToImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            //Image.network(urlToImage,fit: BoxFit.cover),
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: urlToImage,
                  height: MediaQuery.of(context).orientation == Orientation.portrait ? 200 : 250,
                  width: MediaQuery.of(context).orientation == Orientation.portrait ? double.maxFinite : MediaQuery.of(context).size.width * .80,
                  fit: MediaQuery.of(context).orientation == Orientation.portrait ? BoxFit.cover : BoxFit.fitWidth,
                  placeholder: (context, url) => const SizedBox(
                    height: 220,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text(title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            Text(description),
            const SizedBox(height: 5,),
            Divider(
              color: cyanColor,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
