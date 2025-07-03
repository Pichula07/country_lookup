import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/country.dart';

class CountryService {
  static const API = 'https://restcountries.com/v3.1/';

  Future<List<String>> loadAllNames() async {
    final url = Uri.parse('${API}all?fields=name');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final List data = json.decode(resp.body);
      return data.map((e) => e['name']['common'].toString()).toList();
    }
    return [];
  }

  Future<Country?> fetchByName(String name) async {
    final url = Uri.parse('${API}name/$name?fullText=true');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final List data = json.decode(resp.body);
      return Country.fromJson(data.first);
    }
    return null;
  }
}