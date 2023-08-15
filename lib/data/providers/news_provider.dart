import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../repositories/news_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsProvider extends ChangeNotifier {
  List<ItemModel> _keralanews = [];
  List<ItemModel> _sportsnews = [];
  List<ItemModel> _indianews = [];

  List<ItemModel> get keralanews => _keralanews;
  List<ItemModel> get sportsnews => _sportsnews;
  List<ItemModel> get indianews => _indianews;

  Future<void> fetchNews(String newsType) async {
    final repository = NewsRepository();
    List<ItemModel> fetchedNews = [];

    if (newsType == 'India') {
      fetchedNews = await repository.fetchNewsIndia();
      _indianews = fetchedNews
        ..sort((a, b) => b.datetimeDart.compareTo(a.datetimeDart));
    } else if (newsType == 'Kerala') {
      fetchedNews = await repository.fetchNewsKerala();
      _keralanews = fetchedNews
        ..sort((a, b) => b.datetimeDart.compareTo(a.datetimeDart));
    } else if (newsType == 'Sports') {
      fetchedNews = await repository.fetchNewsSports();
      _sportsnews = fetchedNews
        ..sort((a, b) => b.datetimeDart.compareTo(a.datetimeDart));
    } else {
      throw Exception('Invalid news type');
    }

    notifyListeners();
  }
}

class OptionProvider extends ChangeNotifier {
  bool isLoading = true;
  int _selectedNumber = 0;

  int get selectedNumber => _selectedNumber;

  List<Map<int, String>> get buttonCategory => _buttonCategory;

  List<Map<int, String>> _buttonCategory = [
    {0: 'Kerala'},
    {1: 'India'},
    {2: 'Sports'}
  ];
  OptionProvider() {
    initialLoading();
  }

  initialOption() {
    _selectedNumber = _buttonCategory[0].keys.first;
  }

  selectOption(String newsOption) {
    if (newsOption == 'Kerala') {
      _selectedNumber = 0;
    } else if (newsOption == 'India') {
      _selectedNumber = 1;
    } else if (newsOption == 'Sports') {
      _selectedNumber = 2;
    }
    notifyListeners();
  }

  Future<void> initialLoading() async {
    await loadCategory();
    await initialOption();
    notifyListeners();
  }

  Future<void> loadCategory() async {
    List<String> items = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    items = prefs.getStringList('itemList') ?? [];
    _buttonCategory = items.isNotEmpty
        ? rearrangedButtonCategory(items, buttonCategory)
        : [
            {0: 'Kerala'},
            {1: 'India'},
            {2: 'Sports'}
          ];

    // Set the flag to indicate loading is complete

    isLoading = false;
    notifyListeners();
  }

  List<Map<int, String>> rearrangedButtonCategory(
      List<String> items, List<Map<int, String>> buttonCategoryMap) {
    List<Map<int, String>> rearrangedButtonMap = [];
    for (final item in items) {
      final map = buttonCategoryMap
          .firstWhere((element) => element.values.contains(item));
      rearrangedButtonMap.add(map);
    }

    return rearrangedButtonMap;
  }
}
