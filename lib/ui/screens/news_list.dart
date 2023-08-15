import 'package:flutter/material.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';

import 'package:vaartha/data/models/item_model.dart';
import 'package:vaartha/ui/widgets/list_tiles.dart';
import 'package:vaartha/ui/widgets/refresh.dart';

class NewsList extends StatelessWidget {
  final List<ItemModel> newsItems;
  const NewsList({super.key, required this.newsItems});

  @override
  Widget build(BuildContext context) {
    return Refresh(
      child: ScrollWrapper(
        promptAnimationType: PromptAnimation.fade,
        promptDuration: const Duration(milliseconds: 100),
        promptAlignment: Alignment.bottomRight,
        promptTheme: const PromptButtonTheme(
            padding: EdgeInsets.all(32.0),
            color: Color.fromARGB(255, 255, 244, 212),
            icon: Icon(
              Icons.arrow_upward,
              color: Colors.black,
              size: 18.0,
            )),
        builder: (context, properties) => ListView.builder(
          itemCount: newsItems.length,
          itemBuilder: (context, index) {
            final newsItem = newsItems[index];

            return ListTiles(newsItem: newsItem);
          },
        ),
      ),
    );
  }
}
