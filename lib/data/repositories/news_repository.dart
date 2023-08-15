import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';

class NewsRepository {
  Future<List<ItemModel>> fetchNewsIndia() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/indianews'));
    //await http.get(Uri.parse('http://10.0.2.2:8000/indianews'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(utf8.decode(response.bodyBytes));
      return jsonData.map((json) => ItemModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<ItemModel>> fetchNewsKerala() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/keralanews'));
    //await http.get(Uri.parse('http://10.0.2.2:8000/keralanews'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(utf8.decode(response.bodyBytes));
      return jsonData.map((json) => ItemModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<ItemModel>> fetchNewsSports() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/sportsnews'));
    //await http.get(Uri.parse('http://10.0.2.2:8000/sportsnews'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(utf8.decode(response.bodyBytes));
      return jsonData.map((json) => ItemModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
