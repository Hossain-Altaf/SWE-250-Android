import 'package:flutter/material.dart';
import '../screens/home.dart';


// Trip Planner Screen
class TripPlannerScreen extends StatelessWidget {
  const TripPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trip Planner")),
      body: const Center(child: Text("Plan your trip here!")),
    );
  }
}

// Nearby Attractions Screen
class NearbyAttractionsScreen extends StatelessWidget {
  const NearbyAttractionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Attractions")),
      body: const Center(child: Text("Find nearby attractions here!")),
    );
  }
}

// Weather Screen
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Updates")),
      body: const Center(child: Text("Check the weather here!")),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: const Center(child: Text("Manage app settings here!")),
    );
  }
}

// Bottom Navigation Bar
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const TripPlannerScreen(),
    const NearbyAttractionsScreen(),
    const WeatherScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueAccent),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black54),
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("lib/assets/images/nav/home.webp", width: 24, height: 24),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("lib/assets/images/nav/plan_trip.webp", width: 24, height: 24),
            label: "Plan Trip",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("lib/assets/images/nav/location.webp", width: 24, height: 24),
            label: "NearbyLoc",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("lib/assets/images/nav/weather.jpg", width: 24, height: 24),
            label: "Weather",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("lib/assets/images/nav/settings.jpg", width: 24, height: 24),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
