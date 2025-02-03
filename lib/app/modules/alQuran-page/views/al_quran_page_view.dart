import 'dart:convert';

import 'package:dompet_mal/color/color.dart';
import 'package:dompet_mal/component/logo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../controllers/al_quran_page_controller.dart';

class AlQuranPageView extends GetView<AlQuranPageController> {
  const AlQuranPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 140,
               decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bgbatik.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                       Logo(),
                        const SizedBox(width: 10),
                        
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Al-Quran Digital',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Baca Al-Quran dengan mudah dan dapatkan pahala',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: controller.searchSurah,
              decoration: InputDecoration(
                hintText: 'Cari Surat...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: controller.filteredSurahs.length,
                itemBuilder: (context, index) {
                  final surah = controller.filteredSurahs[index];
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: basecolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '${surah.number}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${surah.transliteration} (${surah.name})',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(surah.translation),
                    trailing: Text('${surah.totalVerses} Ayat'),
                    onTap: () => Get.to(() => SurahDetailView(surah: surah)),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

// views/surah_detail_view.dart
class SurahDetailView extends StatelessWidget {
  final Surah surah;
  
  const SurahDetailView({Key? key, required this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SurahDetailController(surah));
    
    return Scaffold(
      appBar: AppBar(
        title: Text(surah.transliteration),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.verses.length,
          itemBuilder: (context, index) {
            final verse = controller.verses[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${verse.number}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      verse.text,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'Uthmani',
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      verse.translation,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// controllers/surah_detail_controller.dart
class SurahDetailController extends GetxController {
  final Surah surah;
  var verses = <Verse>[].obs;
  var isLoading = true.obs;

  SurahDetailController(this.surah);

  @override
  void onInit() {
    super.onInit();
    fetchVerses();
  }

  Future<void> fetchVerses() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://api.quran.gading.dev/surah/${surah.number}'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        final List<dynamic> versesData = data['verses'];
        verses.value = versesData.map((json) => Verse.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error fetching verses: $e');
    } finally {
      isLoading(false);
    }
  }
}
