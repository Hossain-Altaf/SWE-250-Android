import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../screens/home.dart';
import '../models/trip_plan.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_webservice/places.dart';

// ----------------------------- Trip Planner Screen -----------------------------

class TripPlannerScreen extends StatefulWidget {
  const TripPlannerScreen({super.key});

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
  State<TripPlannerScreen> createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  final List<TripPlan> _savedTrips = [];

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  void _saveTripPlan() {
    if (_destinationController.text.isEmpty || _startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    final trip = TripPlan(
      destination: _destinationController.text,
      startDate: _startDate!,
      endDate: _endDate!,
      notes: _notesController.text,
    );

    setState(() {
      _savedTrips.add(trip);
      _destinationController.clear();
      _notesController.clear();
      _startDate = null;
      _endDate = null;
    });
  }

  void _generateTripPlan() {
    if (_destinationController.text.trim().isEmpty || _startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter location and dates first")),
      );
      return;
    }

    final days = _endDate!.difference(_startDate!).inDays + 1;

    // Split input by whitespace (space, tabs, newlines)
    final places = _destinationController.text.trim().split(RegExp(r'\s+'));

    final suggestions = List.generate(days, (index) {
      final date = _startDate!.add(Duration(days: index));
      final place = places[index % places.length]; // rotate through places
      return "Day ${index + 1} (${_formatDate(date)}): Visit $place";
    });

    setState(() {
      _notesController.text = suggestions.join('\n');
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Plan generated! You can save it now.")),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  Widget _buildSavedTripCard(TripPlan trip) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Colors.blue),
        title: Text(trip.destination),
        subtitle: Text(
          "From ${_formatDate(trip.startDate)} to ${_formatDate(trip.endDate)}\n${trip.notes}",
        ),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trip Planner")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Destination (Separate multiple places with space)", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(hintText: "e.g.Kaptai Sajek"),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Start Date", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () => _selectDate(context, true),
                        child: Text(
                          _startDate == null
                              ? "Select Start Date"
                              : _formatDate(_startDate!),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("End Date", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () => _selectDate(context, false),
                        child: Text(
                          _endDate == null
                              ? "Select End Date"
                              : _formatDate(_endDate!),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Text("Notes", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(hintText: "Auto-generated or manual notes..."),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.auto_fix_high),
                  label: const Text("Auto Generate Plan"),
                  onPressed: _generateTripPlan,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text("Save Trip"),
                  onPressed: _saveTripPlan,
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(),
            const Text("Saved Trips", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (_savedTrips.isEmpty)
              const Text("No saved trips yet.")
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _savedTrips.length,
                itemBuilder: (context, index) => _buildSavedTripCard(_savedTrips[index]),
              ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------- Location Screen -----------------------------

class NearbyAttractionsScreen extends StatefulWidget {
  const NearbyAttractionsScreen({super.key});

  @override
  State<NearbyAttractionsScreen> createState() => _NearbyAttractionsScreenState();
}

class _NearbyAttractionsScreenState extends State<NearbyAttractionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'YOUR_GOOGLE_API_KEY');
  Position? _currentPosition;
  String _locationMessage = "Getting your location...";
  bool _isLoading = true;
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    setState(() => _isLoading = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _locationMessage = "Please enable location services");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _locationMessage = "Location permissions denied");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _locationMessage = "Location permissions permanently denied");
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      _updateLocation(position);
    } catch (e) {
      setState(() => _locationMessage = "Error getting location: ${e.toString()}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _updateLocation(Position position) {
    setState(() {
      _currentPosition = position;
      _locationMessage = "Latitude: ${position.latitude.toStringAsFixed(4)}\n"
          "Longitude: ${position.longitude.toStringAsFixed(4)}";

      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: 'Your Location'),
        ),
      );

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          15,
        ),
      );
    });
  }

  Future<void> _searchPlace(String query) async {
    if (query.isEmpty) return;

    final response = await _places.searchByText(query);
    if (response.status == 'OK' && response.results.isNotEmpty) {
      final result = response.results.first;
      final lat = result.geometry!.location.lat;
      final lng = result.geometry!.location.lng;

      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('searchedPlace'),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: result.name),
          ),
        );
        _locationMessage = "${result.name}\nLat: ${lat.toStringAsFixed(4)}, Lng: ${lng.toStringAsFixed(4)}";
      });

      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No results found.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _determinePosition,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: _searchPlace,
              decoration: InputDecoration(
                hintText: "Search for a place",
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _locationMessage = "Search cleared.");
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _currentPosition == null
                ? Center(child: Text(_locationMessage))
                : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                ),
                zoom: 15,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  _locationMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.location_on),
                  label: const Text("Get Current Location"),
                  onPressed: _determinePosition,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ----------------------------- Weather Screen -----------------------------
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? _weatherInfo;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print("User location: ${position.latitude}, ${position.longitude}");

      final snapshot = await FirebaseFirestore.instance
          .collection('weather') // <- make sure this matches your Firestore collection
          .get();

      final nearby = snapshot.docs.where((doc) {
        final data = doc.data();
        final lat = data['lat'];
        final lon = data['lon'];

        if (lat == null || lon == null) return false;

        final distance = Geolocator.distanceBetween(
          position.latitude, position.longitude,
          lat, lon,
        );
        return distance < 10000; // 10 km
      }).toList();


      if (nearby.isNotEmpty) {
        final weather = nearby.first.data();
        setState(() {
          _weatherInfo = weather['report'];
          _loading = false;
        });
      } else {
        setState(() {
          _weatherInfo = "No nearby weather data found.";
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _weatherInfo = "Failed to get weather: $e";
        _loading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Updates")),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : Text(
          _weatherInfo ?? "No data available.",
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ----------------------------- Settings Screen -----------------------------
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

// ----------------------------- Bottom Navigation Bar -----------------------------
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    TripPlannerScreen(),
    NearbyAttractionsScreen(),
    WeatherScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
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
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
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
            label: "Location",
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
