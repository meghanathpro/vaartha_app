import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/providers/news_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  const Refresh({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return RefreshIndicator(
        onRefresh: () async {
          await provider.fetchNews('kerala');
          await provider.fetchNews('india');
          await provider.fetchNews('sports');
        },
        child: child);
  }
}
