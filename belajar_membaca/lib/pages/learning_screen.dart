import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  final List<Map<String, String>> kataList = [
    {'kata': 'bicara', 'audio': 'bicara.mp3'},
    {'kata': 'angin', 'audio': 'angin.mp3'},
    {'kata': 'kenapa', 'audio': 'kenapa.mp3'},
    {'kata': 'makan', 'audio': 'makan.mp3'},
    {'kata': 'minum', 'audio': 'minum.mp3'},
    {'kata': 'sekolah', 'audio': 'sekolah.mp3'},
    {'kata': 'buku', 'audio': 'buku.mp3'},
    {'kata': 'pensil', 'audio': 'pensil.mp3'},
  ];

  int currentIndex = 0;
  final Random random = Random();
  bool isPlaying = false;

  void playAudio() async {
    if (isPlaying) return;

    setState(() {
      isPlaying = true;
    });

    try {
      // Asumsi file audio ada di folder assets/audio/
      await audioPlayer.play(
        AssetSource('audio/${kataList[currentIndex]['audio']}'),
      );
    } catch (e) {
      print("Error playing audio: $e");
    }

    setState(() {
      isPlaying = false;
    });
  }

  void nextKata() {
    setState(() {
      currentIndex = (currentIndex + 1) % kataList.length;
    });
    playAudio();
  }

  void randomKata() {
    setState(() {
      currentIndex = random.nextInt(kataList.length);
    });
    playAudio();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Membaca Kata'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: playAudio,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue, width: 3),
                ),
                child: Center(
                  child: Text(
                    kataList[currentIndex]['kata']!,
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: randomKata,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Acak',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),

                const SizedBox(width: 20),

                ElevatedButton(
                  onPressed: nextKata,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Lanjut',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
