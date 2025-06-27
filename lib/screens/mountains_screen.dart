import 'package:flutter/material.dart';

class MountainsScreen extends StatelessWidget {
  const MountainsScreen({super.key});

  Widget customBackButton(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'lib/assets/images/icon/back2.png',
        width: 24,  // Adjust size as needed
        height: 24,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    // List of top mountains with their information
    final List<Map<String, String>> mountains = [
      {
        "name": "Mount Everest",
        "image": "lib/assets/images/mountains/everest.webp",
        "description": "Mount Everest is the Earth's highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point.",
        "height": "8,848 meters",
      },
      {
        "name": "K2",
        "image": "lib/assets/images/mountains/k2.webp",
        "description": "K2 is the second-highest mountain on Earth, after Mount Everest. It is located on the China–Pakistan border between Baltistan in the Gilgit-Baltistan region of northern Pakistan, and Dafdar Township in Taxkorgan Tajik Autonomous County of Xinjiang, China.",
        "height": "8,611 meters",
      },
      {
        "name": "Kangchenjunga",
        "image": "lib/assets/images/mountains/Kangchenjunga.webp",
        "description": "Kangchenjunga is the third highest mountain in the world. It lies between Nepal and Sikkim, India, with three of the five peaks (Main, Central, and South) directly on the border, and the remaining two (West and Kangbachen) in Nepal's Taplejung District.",
        "height": "8,586 meters",
      },
      {
        "name": "Lhotse",
        "image": "lib/assets/images/mountains/lhotse.jpg",
        "description": "Lhotse is the fourth highest mountain in the world at 8,516 metres, after Mount Everest, K2, and Kangchenjunga. It is located on the border between Tibet and Nepal.",
        "height": "8,516 meters",
      },
      {
        "name": "Makalu",
        "image": "lib/assets/images/mountains/makalu.webp",
        "description": "Makalu is the fifth highest mountain in the world at 8,485 metres. It is located in the Mahalangur Himalayas 19 km southeast of Mount Everest, on the border between Nepal and China.",
        "height": "8,485 meters",
      },
      {
        "name": "Annapurna",
        "image": "lib/assets/images/mountains/annapurna.jpg",
        "description": "Annapurna is a mountain situated in the Annapurna mountain range of Gandaki Province, north-central Nepal. It is the 10th highest mountain in the world at 8,091 metres above sea level and is well known for the difficulty and danger involved in its ascent",
         "height":"8,091 metres",
      },
      {
        "name": "Kilimanjaro",
        "image": "lib/assets/images/mountains/kilimanjaro.jpg",
        "description": "Mount Kilimanjaro is a dormant volcano in Tanzania. It is the highest mountain in Africa and the highest free-standing mountain above sea level in the world, at 5,895 m above sea level and 4,900 m above its plateau base",
        "height": "5895 meters",
      },
      {
        "name": "Mt. Fuji",
        "image": "lib/assets/images/mountains/fuji.jpg",
        "description": " Japan’s Mt. Fuji is an active volcano about 100 kilometers southwest of Tokyo. Commonly called “Fuji-san,” it’s the country’s tallest peak, at 3,776 meters. A pilgrimage site for centuries, it’s considered one of Japan’s 3 sacred mountains, and summit hikes remain a popular activity. Its iconic profile is the subject of numerous works of art, notably Edo Period prints by Hokusai and Hiroshige. ",
        "height": " 3776 meters",
      },

    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Mountains of the World"),
        leading: customBackButton(context),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: mountains.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.asset(
                mountains[index]["image"]!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                mountains[index]["name"]!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mountains[index]["description"]!),
                  const SizedBox(height: 4),
                  Text(
                    "Height: ${mountains[index]["height"]!}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                // You can add navigation to a detailed mountain page here
              },
            ),
          );
        },
      ),
    );
  }
}