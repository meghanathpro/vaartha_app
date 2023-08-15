import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemList extends ChangeNotifier {
  List<String> items = [];

  bool isLoading = true; // flag to track loading state

  ItemList() {
    // Load items from SharedPreferences when the model is created
    _loadItems();
  }

  Future<void> _loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    items = prefs.getStringList('itemList') ?? ['Kerala', 'India', 'Sports'];
    isLoading = false; // Set the flag to indicate loading is complete
    notifyListeners();
  }

  void swapItems(int sourceIndex, int targetIndex) {
    final temp = items[sourceIndex];
    items[sourceIndex] = items[targetIndex];
    items[targetIndex] = temp;
    _saveItems();
    // Save the updated items
    notifyListeners();
  }

  Future<void> _saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('itemList', items);
  }
}
