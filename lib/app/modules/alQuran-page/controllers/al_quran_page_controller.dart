import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Surah {
  final int number;
  final String name;
  final String transliteration;
  final String translation;
  final int totalVerses;

  Surah({
    required this.number,
    required this.name,
    required this.transliteration,
    required this.translation,
    required this.totalVerses,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      name: json['name']['short'],
      transliteration: json['name']['transliteration']['id'],
      translation: json['name']['translation']['id'],
      totalVerses: json['numberOfVerses'],
    );
  }
}

// models/verse.dart
class Verse {
  final int number;
  final String text;
  final String translation;

  Verse({
    required this.number,
    required this.text,
    required this.translation,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      number: json['number']['inSurah'],
      text: json['text']['arab'],
      translation: json['translation']['id'],
    );
  }
}



class AlQuranPageController extends GetxController {
  var surahs = <Surah>[].obs;
  var filteredSurahs = <Surah>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://api.quran.gading.dev/surah'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        surahs.value = data.map((json) => Surah.fromJson(json)).toList();
        filteredSurahs.value = surahs;
      }
    } catch (e) {
      print('Error fetching surahs: $e');
    } finally {
      isLoading(false);
    }
  }

  void searchSurah(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredSurahs.value = surahs;
    } else {
      filteredSurahs.value = surahs.where((surah) {
        return surah.name.toLowerCase().contains(query.toLowerCase()) ||
            surah.transliteration.toLowerCase().contains(query.toLowerCase()) ||
            surah.translation.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  
}