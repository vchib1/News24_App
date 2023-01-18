import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Constants/constants.dart';
import 'package:newsapp/Models/api_service.dart';
import 'package:newsapp/Pages/search_page.dart';
import 'package:newsapp/Providers/IntNewsProvider.dart';
import 'package:newsapp/Providers/CategoryProvider.dart';
import 'package:newsapp/Providers/IndicatorProvider.dart';
import 'package:newsapp/Providers/SearchedNewsProvider.dart';
import 'package:newsapp/Widgets/catgeoryWidget.dart';
import 'package:newsapp/Widgets/main_headlines.dart';
import 'package:newsapp/Widgets/shimmer_effect/Int_Shimmer_fx.dart';
import 'package:newsapp/Widgets/Inter_News.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> _category = ["General","Business","Entertainment","Health","Science","Sports","Technology"];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ApiClass.deleteCache();//deletes cache files on launch
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("News24"),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5,),
              //Categories
              SizedBox(
                height: 60,
                child: ListView.builder(
                  itemCount: _category.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Provider.of<CategoryProvider>(context,listen: false).currentMethod(index);
                        Provider.of<CategoryProvider>(context,listen: false).getCategoryName(_category[index]);
                        Provider.of<CategoryProvider>(context,listen: false).isLoading = true;
                        Provider.of<CategoryProvider>(context,listen: false).fetchCategoryNews();
                      },
                      child: CategoryWidget(
                        categoryName: _category[index],
                        color: Provider.of<CategoryProvider>(context,listen: true).current == index ? cyanColor : greyColor,
                      ),
                    );
                  },
                ),
              ),

              //search bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    child: TextField(
                      onSubmitted: (value){
                        if(value.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text("Search field is empty!!"),
                                duration: Duration(seconds: 2),
                            ),
                          );
                        }else{
                          Provider.of<SearchedNewsProvider>(context,listen: false).getSearchValue(value);
                          Provider.of<SearchedNewsProvider>(context,listen: false).isLoading = true;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SearchPage()),
                          );
                          searchController.clear();
                        }
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "Search",
                          fillColor: greyColor,
                          filled: true,
                          //errorText: validateSearch(searchController.value.text),
                          prefixIcon: const Icon(Icons.search_outlined),
                          contentPadding: const EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none
                          )
                      ),
                    )
                ),
              ),

              //International News
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                child: Text("International News",style: topNews),
              ),
              Consumer<InternationalProvider>(
                builder: (context,breakingNewsProvider,child){
                  if(breakingNewsProvider.isLoading == true){
                    return const ShimmerInterNews();
                  }
                  else{
                    return Column(
                      children: [
                        CarouselSlider.builder(
                            options: CarouselOptions(
                              height: 200,
                              viewportFraction: 1,
                              enableInfiniteScroll: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              enlargeCenterPage: true,
                              autoPlayAnimationDuration: const Duration(milliseconds: 500),
                              autoPlayInterval: const Duration(seconds: 5),
                              onPageChanged: (index, reason){
                                Provider.of<IndicatorProvider>(context,listen: false).getSelectedIndex(index);
                              },
                              autoPlay: true,
                            ),
                            itemCount: breakingNewsProvider.articles.length - 10,
                            itemBuilder: (context,index,realIndex){
                              String currentTitle = breakingNewsProvider.articles[index].title;
                              String currentUrl = breakingNewsProvider.articles[index].url;
                              final Uri url = Uri.parse(currentUrl);
                              String currentImage = breakingNewsProvider.articles[index].urlToImage;
                              return GestureDetector(
                                onTap: ()async{
                                  if(await launchUrl(url)){
                                    await launchUrl(url,mode: LaunchMode.inAppWebView);
                                  }else{
                                    throw "could now launch $url";
                                  }
                                },
                                child: InternationalNews(
                                  title: currentTitle,
                                  image: currentImage,
                                ),
                              );
                            }
                        ),
                        const SizedBox(height: 10,),
                        AnimatedSmoothIndicator(
                          activeIndex: Provider.of<IndicatorProvider>(context,listen: true).activeIndex,
                          count: breakingNewsProvider.articles.length - 10,
                          effect: WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            activeDotColor: cyanColor,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 10,),
              //Top 5 News
              Consumer<CategoryProvider>(
                builder: (context,categoryProvider,child){
                  if(categoryProvider.isLoading == true){
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: cyanColor,
                        ),
                      ),
                    );
                  }else{
                    return ListView.builder(
                      itemCount: categoryProvider.categoryNews.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        String currentTitle = categoryProvider.categoryNews[index].title;
                        String currentUrl = categoryProvider.categoryNews[index].url;
                        final Uri url = Uri.parse(currentUrl);
                        String currentImage = categoryProvider.categoryNews[index].urlToImage;
                        String currentDescription = categoryProvider.categoryNews[index].description;
                        return GestureDetector(
                          onTap: ()async{
                            if(await launchUrl(url)){
                              await launchUrl(url,mode: LaunchMode.inAppWebView);
                            }else{
                              throw "could now launch $url";
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
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
