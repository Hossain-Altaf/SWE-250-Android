// country_destinations_screen.dart
import 'package:flutter/material.dart';
import 'destinations_details.dart';

class CountryDestinationsScreen extends StatelessWidget {
  final String country;

  CountryDestinationsScreen({required this.country});

  final Map<String, List<Map<String, String>>> countryDestinations = {
    'Bangladesh': [
      {
        'name': 'Cox’s Bazar',
        'image': 'lib/assets/images/country_plc/cox.jpg',
        'description': 'Cox’s Bazar is a town on the southeast coast of Bangladesh. It’s known for its very long, sandy beachfront, stretching from Sea Beach in the north to Kolatoli Beach in the south. Aggameda Khyang monastery is home to bronze statues and centuries-old Buddhist manuscripts. South of town, the tropical rainforest of Himchari National Park has waterfalls and many birds. North, sea turtles breed on nearby Sonadia Island.'
      },
      {
        'name': 'Sundarbans',
        'image': 'lib/assets/images/country_plc/sundarban.jpg',
        'description': 'Sundarbans is a mangrove forest area in the Ganges Delta formed by the confluence of the Ganges, Brahmaputra and Meghna Rivers in the Bay of Bengal. It spans the area from the Hooghly River in Indias state of West Bengal to the Baleswar River in Bangladesh Khulna Division'
      },
      {
        'name': 'Kaptai-Lake',
        'image': 'lib/assets/images/country_plc/kaptai.jpg',
        'description':"Kaptai Lake is the largest man-made lake in Bangladesh. It is located in the Kaptai Upazila under Rangamati District of Chittagong Division. The lake was created as a result of building the Kaptai Dam on the Karnaphuli River, as part of the Karnafuli Hydropower Station. "
      },
      {
        'name': 'Sree-Mongol',
        'image': 'lib/assets/images/country_plc/sreemongol.jpg',
        'description':"Sreemangal (Bengali: শ্রীমঙ্গল, romanized: Srimongol) is an upazila of Moulvibazar District in Sylhet Division, Bangladesh.[4] It is located at the southwest of the district, and borders the Habiganj District to the west and the Indian state of Tripura to the south. Sreemangal is often referred to as the 'tea capital' of Bangladesh, and is most famous for its tea fields. Other than tea, the rubber, pineapple, wood, betel, and lemon industries also exist in the upazila"
      },
      {
        'name': 'Tanguar Haor',
        'image': 'lib/assets/images/country_plc/tanguar.webp',
        'description':"Tanguar Haor is a wetland ecosystem located in the Dharmapasha and Tahirpur upazilas of Sunamganj District in Bangladesh. The area of Tanguar Haor including 46 villages within the haor is about 100 square kilometres of which 2,802.36 ha² is wetland. It is the source of livelihood for more than 40,000 people."
      },
    ],
    'France': [
      {
        'name': 'Eiffel Tower',
        'image': 'lib/assets/images/paris.webp',
        'description': 'Iconic iron tower in Paris.'
      },
    ],
    'Japan': [
      {
        'name': 'Tokyo',
        'image': 'lib/assets/images/tokyo.jpg',
        'description': 'Vibrant capital city of Japan.'
      },
    ],

    'Norway': [
      {
        'name': 'Oslo',
        'image': 'lib/assets/images/country_plc/norway.jpg',
        'description': "Combining fjord and forest landscapes with high-end architecture and landmarks that bear witness to Norway's history – Oslo has it all. Nicknamed as The Tiger City (or Tigerstaden), Norway's capital offers its visitors a taste of Scandinavian traditions and modern life."
      },
    ],

    'Sweden': [
      {
        'name': 'Stockholm',
        'image': 'lib/assets/images/country_plc/sweden.jpg',
        'description': "Stockholm, the capital of Sweden, encompasses 14 islands and more than 50 bridges on an extensive Baltic Sea archipelago. The cobblestone streets and ochre-colored buildings of Gamla Stan (the old town) are home to the 13th-century Storkyrkan Cathedral, the Kungliga Slottet Royal Palace and the Nobel Museum, which focuses on the Nobel Prize. Ferries and sightseeing boats shuttle passengers between the islands. "
      },
    ],

    'Bhutan': [
      {
        'name': 'Thimphu',
        'image': 'lib/assets/images/country_plc/bhutan.jpg',
        'description': "Thimphu, Bhutan’s capital, occupies a valley in the country’s western interior. In addition to being the government seat, the city is known for its Buddhist sites. The massive Tashichho Dzong is a fortified monastery and government palace with gold-leaf roofs. The Memorial Chorten, a whitewashed structure with a gold spire, is a revered Buddhist shrine dedicated to Bhutan’s third king, Jigme Dorji Wangchuck"
      },
    ],

    'Nepal': [
      {
        'name': 'Kathmundu',
        'image': 'lib/assets/images/country_plc/nepal.jpg',
        'description': "Today, Kathmandu is not only the capital of the Federal Democratic Republic of Nepal, but also the headquarters of the Central Development Region of Nepal. The Central Region comprises three zones: Bagmati, Narayani, and Janakpur. Kathmandu is located in the Bagmati Zone."
      },
      {
        'name': 'Himalaya',
        'image': 'lib/assets/images/mountains/everest.webp',
        'description': "The Himalayas, or Himalaya, is a mountain range in Asia, separating the plains of the Indian subcontinent from the Tibetan Plateau. The range has some of the Earth's highest peaks, including the highest, Mount Everest. More than 100 peaks exceeding elevations of 7,200 m above sea level lie in the Himalayas"
      },
    ],

    'India': [
      {
        'name': 'Kashmir',
        'image': 'lib/assets/images/country_plc/kashmir.jpg',
        'description': 'Kashmir (/ˈkæʃmɪər/ KASH-meer or /kæʃˈmɪər/ kash-MEER) is the northernmost geographical region of the Indian subcontinent. Until the mid-19th century, the term Kashmir denoted only the Kashmir Valley between the Great Himalayas and the Pir Panjal Range. The term has since also come to encompass a larger area that includes the Indian-administered territories of Jammu and Kashmir and Ladakh, the Pakistani-administered territories of Azad Kashmir and Gilgit-Baltistan, and the Chinese-administered territories of Aksai Chin and the Trans-Karakoram Tract'
      },
      {
        'name': 'Darjeeling',
        'image': 'lib/assets/images/country_plc/darjeeling.jpg',
        'description': 'Darjeeling is a town in Indias West Bengal state, in the Himalayan foothills. Once a summer resort for the British Raj elite, it remains the terminus of the narrow-gauge Darjeeling Himalayan Railway, or “Toy Train,” completed in 1881. Its famed for the distinctive black tea grown on plantations that dot its surrounding slopes. Its backdrop is Mt. Kanchenjunga, among the world’s highest peaks.'
      },
      {
        'name': 'Meghalaya',
        'image': 'lib/assets/images/country_plc/meghalaya.jpg',
        'description': "Meghalaya is a state in northeast India. Its capital is Shillong. Meghalaya was formed on 21 January 1972 by carving out two districts from the Assam: the United Khasi Hills and Jaintia Hills and the Garo Hills. The estimated population of Meghalaya in 2014 was 3,211,474."
      },
      {
        'name': 'Bombey',
        'image': 'lib/assets/images/country_plc/bombey.jpg',
        'description': "Mumbai (formerly called Bombay) is a densely populated city on India’s west coast. A financial center, it's India's largest city. On the Mumbai Harbour waterfront stands the iconic Gateway of India stone arch, built by the British Raj in 1924. Offshore, nearby Elephanta Island holds ancient cave temples dedicated to the Hindu god Shiva. The city's also famous as the heart of the Bollywood film industry."
      },
      {
        'name': 'Delhi',
        'image': 'lib/assets/images/country_plc/delhi.jpg',
        'description': "Delhi, India’s capital territory, is a massive metropolitan area in the country’s north. In Old Delhi, a neighborhood dating to the 1600s, stands the imposing Mughal-era Red Fort, a symbol of India, and the sprawling Jama Masjid mosque, whose courtyard accommodates 25,000 people. Nearby is Chandni Chowk, a vibrant bazaar filled with food carts, sweets shops and spice stalls."
      },

    ],

    'Russia': [
      {
        'name': 'moscow',
        'image': 'lib/assets/images/country_plc/moscow.jpg',
        'description': "Moscow, on the Moskva River in western Russia, is the nation’s cosmopolitan capital. In its historic core is the Kremlin, a complex that’s home to the president and tsarist treasures in the Armoury. Outside its walls is Red Square, Russia's symbolic center. It's home to Lenin’s Mausoleum, the State Historical Museum's comprehensive collection and St. Basil’s Cathedral, known for its colorful, onion-shaped domes"
      },
    ],

    'Germany': [
      {
        'name': 'berlin',
        'image': 'lib/assets/images/country_plc/berlin.jpg',
        'description': "Berlin, Germany’s capital, dates to the 13th century. Reminders of the city's turbulent 20th-century history include its Holocaust memorial and the Berlin Wall's graffitied remains. Divided during the Cold War, its 18th-century Brandenburg Gate has become a symbol of reunification. The city's also known for its art scene and modern landmarks like the gold-colored, swoop-roofed Berliner Philharmonie, built in 1963"
      },
    ],

    'Italy': [
      {
        'name': 'Napoli',
        'image': 'lib/assets/images/country_plc/napoli.jpg',
        'description': "Naples is the regional capital of Campania and the third-largest city of Italy, after Rome and Milan, with a population of 908,082 within the city's administrative limits as of 2025, while its province-level "
      },
    ],

    'Brazil': [
      {
        'name': 'Rio de jenerio',
        'image': 'lib/assets/images/country_plc/rio.jpg',
        'description': "Rio de Janeiro is a huge seaside city in Brazil, famed for its Copacabana and Ipanema beaches, 38m Christ the Redeemer statue atop Mount Corcovado and for Sugarloaf Mountain, a granite peak with cable cars to its summit. The city is also known for its sprawling favelas (shanty towns). Its raucous Carnaval festival, featuring parade floats, flamboyant costumes and samba dancers, is considered the world’s largest."
      },
    ],

    'Spain': [
      {
        'name': 'Barcelona',
        'image': 'lib/assets/images/country_plc/barca.jpg',
        'description': "Barcelona, the cosmopolitan capital of Spain’s Catalonia region, is known for its art and architecture. The fantastical Sagrada Família church and other modernist landmarks designed by Antoni Gaudí dot the city. Museu Picasso and Fundació Joan Miró feature modern art by their namesakes. City history museum MUHBA, includes several Roman archaeological sites."
      },
    ],

    'Switzerland': [
      {
        'name': 'Geneva',
        'image': 'lib/assets/images/country_plc/geneva.jpg',
        'description': "Geneva is a city in Switzerland that lies at the southern tip of expansive Lac Léman (Lake Geneva). Surrounded by the Alps and Jura mountains, the city has views of dramatic Mont Blanc. Headquarters of Europe’s United Nations and the Red Cross, it’s a global hub for diplomacy and banking. French influence is widespread, from the language to gastronomy and bohemian districts like Carouge"
      },
    ],

    'Finland': [
      {
        'name': 'Helsinki',
        'image': 'lib/assets/images/country_plc/hels.jpg',
        'description':"Helsinki, Finland’s southern capital, sits on a peninsula in the Gulf of Finland. Its central avenue, Mannerheimintie, is flanked by institutions including the National Museum, tracing Finnish history from the Stone Age to the present. Also on Mannerheimintie are the imposing Parliament House and Kiasma, a contemporary art museum. Ornate red-brick Uspenski Cathedral overlooks a harbor."
      },
    ],


  };

  @override
  Widget build(BuildContext context) {
    final destinations = countryDestinations[country] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('$country Destinations')),
      body: ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final dest = destinations[index];
          return ListTile(
            leading: Image.asset(dest['image']!, width: 60, height: 60, fit: BoxFit.cover),
            title: Text(dest['name']!),
            subtitle: Text(dest['description']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DestinationDetailScreen(
                    name: dest['name']!,
                    imagePath: dest['image']!,
                    description: dest['description']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
