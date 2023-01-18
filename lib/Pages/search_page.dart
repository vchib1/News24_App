import 'package:flutter/material.dart';
import 'package:newsapp/Constants/constants.dart';
import 'package:newsapp/Providers/SearchedNewsProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Widgets/main_headlines.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  @override
  Widget build(BuildContext context) {

    late String searchResults;
    searchResults = Provider.of<SearchedNewsProvider>(context,listen: false).searchedQuery;

    return Scaffold(
      appBar: AppBar(
        title: Text("Search results for \"$searchResults\"",style: const TextStyle(fontSize: 18),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<SearchedNewsProvider>(
            builder: (context,searchedNewsProvider,child){
              if(searchedNewsProvider.searchedNews.isEmpty && searchedNewsProvider.isLoading == false){
                return Container(
                  height: MediaQuery.of(context).size.height * .75,
                  alignment: Alignment.center,
                  child: const Text("No results for found.",style: appBar,),
                );
              }else{
                if(searchedNewsProvider.isLoading == true){
                  return const SizedBox(
                      height: 600,
                      child: Center(child: CircularProgressIndicator())
                  );
                }else{
                  return ListView.builder(
                    itemCount: searchedNewsProvider.searchedNews.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      String currentTitle = searchedNewsProvider.searchedNews[index].title;
                      String currentUrl = searchedNewsProvider.searchedNews[index].url;
                      final Uri url = Uri.parse(currentUrl);
                      String currentImage = searchedNewsProvider.searchedNews[index].urlToImage;
                      String currentDescription = searchedNewsProvider.searchedNews[index].description;
                      return GestureDetector(
                        onTap: ()async{
                          if(await launchUrl(url)){
                            await launchUrl(url,mode: LaunchMode.inAppWebView);
                          }else{
                            throw "could not launch $url";
                          }
                        },
                        child: MainHeadlines(
                          title: currentTitle,
                          description: currentDescription,
                          urlToImage: currentImage,
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
