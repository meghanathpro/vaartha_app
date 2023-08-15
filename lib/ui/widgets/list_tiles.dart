import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vaartha/data/models/item_model.dart';
import 'package:vaartha/utils/relative_time.dart';

class ListTiles extends StatelessWidget {
  const ListTiles({
    super.key,
    required this.newsItem,
  });

  final ItemModel newsItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),

      //padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: newsItem.imagesLink,
                placeholder: (context, url) =>
                    loadingBox(Icons.image, const Text("loading")),
                errorWidget: (context, url, error) => loadingBox(
                    Icons.error_outline_outlined,
                    const Text("Network connection error")),
              ),
            ),
          ),
          ListTile(
            title: Text(
              newsItem.content,
              style: const TextStyle(fontSize: 14),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatRelativeTime(newsItem.datetime),
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  newsItem.source,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container loadingBox(IconData newicon, Text newtext) {
    return Container(
      height: 160.0,
      width: 350.0,
      color: Colors.grey.shade400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            newicon,
            color: Colors.grey.shade600,
            size: 40.0,
          ),
          newtext
        ],
      ),
    );
  }
}
