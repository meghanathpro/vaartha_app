import 'package:vaartha/data/providers/news_provider.dart';
import 'package:vaartha/ui/screens/news_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final optionProvider = Provider.of<OptionProvider>(context);

    if (newsProvider.keralanews.isEmpty) {
      // Fetch kerala news data when the news list is empty.
      newsProvider.fetchNews('Kerala');
    }

    if (newsProvider.indianews.isEmpty) {
      // Fetch indian news data when the news list is empty.
      newsProvider.fetchNews('India');
    }

    if (newsProvider.sportsnews.isEmpty) {
      // Fetch world news data when the news list is empty.
      newsProvider.fetchNews('Sports');
    }
    List<Widget> widgetOptions = <Widget>[
      NewsList(newsItems: newsProvider.keralanews),
      NewsList(newsItems: newsProvider.indianews),
      NewsList(newsItems: newsProvider.sportsnews),
    ];
    List<Map<int, String>> buttonCategory;
    buttonCategory = optionProvider.buttonCategory;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 65.0,
        flexibleSpace: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                stops: [0.7, 0],
                colors: [
                  Color.fromARGB(255, 255, 244, 212),
                  Color.fromARGB(255, 253, 249, 240)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, top: 5.0),
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/homelogo.png',
                    width: 30,
                    height: 35,
                  ),
                ),
                const Spacer(),
                CategoryButton(
                    optionProvider: optionProvider,
                    optionNumber: buttonCategory[0].keys.first,
                    categoryName: buttonCategory[0].values.first),
                const SizedBox(width: 10.0),
                CategoryButton(
                    optionProvider: optionProvider,
                    optionNumber: buttonCategory[1].keys.first,
                    categoryName: buttonCategory[1].values.first),
                const SizedBox(width: 10.0),
                CategoryButton(
                    optionProvider: optionProvider,
                    optionNumber: buttonCategory[2].keys.first,
                    categoryName: buttonCategory[2].values.first),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Navigate to the new screen.
                    Navigator.pushNamed(context, '/dialog');
                  },
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 212),
      ),
      backgroundColor: const Color.fromARGB(255, 253, 249, 240),
      body: widgetOptions.elementAt(optionProvider.selectedNumber),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton(
      {super.key,
      required this.optionProvider,
      required this.optionNumber,
      required this.categoryName});

  final OptionProvider optionProvider;
  final int optionNumber;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ElevatedButton(
        onPressed: () {
          optionProvider.selectOption(categoryName);
          // Add your search action logic here
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: optionProvider.selectedNumber == optionNumber
              ? Colors.grey[700]
              : Colors.grey[100],
          foregroundColor: optionProvider.selectedNumber == optionNumber
              ? Colors.grey[100]
              : Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(categoryName),
      ),
    );
  }
}
