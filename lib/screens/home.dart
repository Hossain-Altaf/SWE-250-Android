import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Screens
import 'CountryListScreen.dart';
import 'NearbySearchMap.dart';
import 'adventures_screen.dart';
import 'beaches_screen.dart';
import 'cities_screen.dart';
import 'country_screen.dart';
import 'destinations_details.dart';
import 'food_screen.dart';
import 'hospital_screen.dart';
import 'hotel_screen.dart';
import 'local_vehicle.dart';
import 'mountains_screen.dart';
import 'police.dart';

// Drawer option screens
import 'about.dart';
import 'insurance.dart';
import 'local_guide.dart';
import 'local_language.dart';
import 'packing_checklist.dart';
import 'profile.dart';
import 'saved_destinations.dart';
import 'sos.dart';
import 'login_screen.dart';

// New screen
import 'notification_screen.dart';

Future<void> _logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Travel Assistant"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "lib/assets/images/drawer/d2.png",
                  width: 30,
                  height: 30,
                ),
              ),
            );
          },
        ),
        actions: [

          IconButton(
            icon: Image.asset(
              'lib/assets/images/notification_icon.png', // Your image path
              width: 26, // Adjust size as needed
              height: 26,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blueAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("lib/assets/images/drawer/profile.png"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome, Traveler!",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(context, "My Profile", "profile_logo.webp", const ProfileScreen()),
            _buildDrawerItem(context, "Saved Destinations", "saved2.jpg", const SavedDestinationsScreen()),
            _buildDrawerItem(context, "Packing Checklist", "pack.jpg", const PackingChecklistScreen()),
            _buildDrawerItem(context, "Local Language", "lang.jpg", const LocalLanguageScreen()),
            _buildDrawerItem(context, "Local guide", "guide.jpg", const LocalGuideScreen()),
            _buildDrawerItem(context, "SOS", "sos.jpg", const SosScreen()),
            _buildDrawerItem(context, "Travel Insurance Info", "ins.jpg", const TravelInsuranceScreen()),
            _buildDrawerItem(context, "About", "abt.png", const AboutScreen()),
            ListTile(
              leading: Image.asset("lib/assets/images/drawer/logout.jpg", width: 30, height: 30),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.asset("lib/assets/images/travel_banner.webp", fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Explore by Category", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),

            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryIcon(context, "lib/assets/images/mountains_logo.webp", "Mountains", const MountainsScreen()),
                  _buildCategoryIcon(context, "lib/assets/images/beaches_logo.webp", "Beaches", const BeachesScreen()),
                  _buildCategoryIcon(context, "lib/assets/images/cities_logo.jpg", "Cities", const CitiesScreen()),
                  _buildCategoryIcon(context, "lib/assets/images/adventures_logo.jpg", "Adventures", const AdventuresScreen()),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Popular Destinations", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),

            ),
            const SizedBox(height: 10),
            _buildDestinationList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, String asset, Widget screen) {
    return ListTile(
      leading: Image.asset("lib/assets/images/drawer/$asset", width: 30, height: 30),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
    );
  }

  Widget _buildCategoryIcon(BuildContext context, String imagePath, String label, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildDestinationList(BuildContext context) {
    final List<Map<String, String>> destinations = [
      {
        "name": "Bali, Indonesia",
        "image": "lib/assets/images/bali.webp",
        "description": "Bali is an Indonesian island known for its forested volcanic mountains, iconic rice paddies, beaches, and coral reefs.",

      },
      {
        "name": "Paris, France",
        "image": "lib/assets/images/paris.webp",
        "description": "Paris, the capital of France, is known for its art, gastronomy, and culture.",
      },
      {
        "name": "Tokyo, Japan",
        "image": "lib/assets/images/tokyo.jpg",
        "description": "Tokyo blends ultramodern and traditional architecture, nightlife, and rich culture.",
      },
      {
        "name": "Amazon, Brazil",
        "image": "lib/assets/images/amazon.webp",
        "description": "The Amazon Rainforest, known as 'the lungs of the Earth,' is home to diverse wildlife, breathtaking landscapes, and indigenous cultures.",
      },
      {
        "name": "Istanbul, Turkey",
        "image": "lib/assets/images/places/istanbul.jpg",
        "description": "Istanbul is a great place to visit, mix culture of Asia and Europe. Very rich culture and heritage.",
      },
      {
        "name": "Helsinki, Finland",
        "image": "lib/assets/images/places/helsinki.webp",
        "description": "Helsinki is a great place to visit, mix culture. Very rich culture and heritage.",
      },
      {
        "name": "Maldives",
        "image": "lib/assets/images/places/maldives.jpg",
        "description": "Sea beaches, coconut and many more.",
      },
      {
        "name": "Pompeii, Italy",
        "image": "lib/assets/images/places/pompei.jpg",
        "description": "Pompeii is a great place to visit, mix culture. Very rich culture and heritage.",
      },
      {
        "name": "Tajmahal, India",
        "image": "lib/assets/images/places/tajmahal.jpg",
        "description": "Taj Mahal is a great place to visit, mix culture. Very rich culture and heritage.",
      },
      {
        "name": "Venice, Italy",
        "image": "lib/assets/images/places/venice.jpg",
        "description": "Venice is a great place to visit, mix culture. Very rich culture and heritage.",
      },
    ];

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DestinationDetailScreen(
                      name: destination["name"]!,
                      imagePath: destination["image"]!,
                      description: destination["description"]!,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(destination["image"]!, width: 150, height: 120, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 8),
                      Text(destination["name"]!, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("More Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildOptionCard(context, "Destinations by Country", "lib/assets/images/options/country.webp", CountryListScreen()),
              _buildOptionCard(context, "Famous Foods", "lib/assets/images/options/food.webp", const FoodsScreen()),
              _buildOptionCard(context, "Nearest Hospital", "lib/assets/images/options/hospital.webp", NearbySearchMap(placeType: 'hospital')),
              _buildOptionCard(context, "Nearest Hotels", "lib/assets/images/options/hotel.jpg", NearbySearchMap(placeType: 'lodging')),
              _buildOptionCard(context, "Local Transport", "lib/assets/images/options/transport.webp", NearbySearchMap(placeType: 'transit_station')),
              _buildOptionCard(context, "Local Police", "lib/assets/images/options/police.webp", NearbySearchMap(placeType: 'police')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard(BuildContext context, String title, String imagePath, Widget screen) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
