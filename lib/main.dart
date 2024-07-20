// ignore_for_file:no_leading_underscores_for_local_identifiers, unused_local_variable, unused_element
import 'package:devsoc_core_review_project/LoginScreen.dart';
import 'package:devsoc_core_review_project/history.dart';
import 'package:devsoc_core_review_project/playlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:devsoc_core_review_project/firebase_options.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}

// Define a SearchResult data model
class Artist {
  final String idArtist;
  final String strArtist;
  final Null strArtistStripped;
  final String strArtistAlternate;
  final String strLabel;
  final String idLabel;
  final String intFormedYear;
  final String strStyle;
  final String strGenre;
  final String strMood;

  const Artist({
    required this.idArtist,
    required this.strArtist,
    required this.strArtistStripped,
    required this.strArtistAlternate,
    required this.strLabel,
    required this.idLabel,
    required this.intFormedYear,
    required this.strStyle,
    required this.strGenre,
    required this.strMood,
  });

  // Factory constructor to parse JSON data (assuming 'json' is the decoded JSON object)
  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        idArtist: json['idArtist'] as String,
        strArtist: json['strArtist'] as String,
        strArtistStripped: json['strArtistStripped'] as Null,
        strArtistAlternate: json['strArtistAlternate'] as String,
        strLabel: json['strLabel'] as String,
        idLabel: json['idLabel'] as String,
        intFormedYear: json['intFormedYear'] as String,
        strStyle: json['strStyle'] as String,
        strGenre: json['strGenre'] as String,
        strMood: json['strMood'] as String,
      );
  Artist.fromMap(Map<String, dynamic> map)
      : idArtist = map['idArtist'],
        strArtist = map['strArtist'],
        strArtistStripped = map['strArtistStripped'],
        strArtistAlternate = map['strArtistAlternate'],
        strLabel = map['strLabel'],
        idLabel = map['idLabel'],
        intFormedYear = map['intFormedYear'],
        strStyle = map['strStyle'],
        strGenre = map['strGenre'],
        strMood = map['strMood'];
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Artist> _searchResults = [];
  String _errorMessage = ''; // To store error messages

  Future<List<Artist>> fetchArtists(String query) async {
    final url = Uri.parse(
        'https://www.theaudiodb.com/api/v1/json/2/search.php?s=$query');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<Artist> artists = [];
      Artist artist = Artist(
          idArtist: data['artists'][0]['idArtist'],
          strArtist: data['artists'][0]['strArtist'],
          strArtistStripped: data['artists'][0]['strArtistStripped'],
          strArtistAlternate: data['artists'][0]['strArtistAlternate'],
          strLabel: data['artists'][0]['strLabel'],
          idLabel: data['artists'][0]['idLabel'],
          intFormedYear: data['artists'][0]['intFormedYear'],
          strStyle: data['artists'][0]['strStyle'],
          strGenre: data['artists'][0]['strGenre'],
          strMood: data['artists'][0]['strMood']);

      artists.add(artist);
      artists.add(artist);
      artists.add(artist);
      artists.add(Artist(
          idArtist: "12345",
          strArtist: "Coldplay",
          strArtistStripped: null,
          strArtistAlternate: "strArtistAlternate",
          strLabel: "strLabel",
          idLabel: "idLabel",
          intFormedYear: "intFormedYear",
          strStyle: "strStyle",
          strGenre: "Happy",
          strMood: "strMood"));
      artists.add(artist);

      // Check if artists exist before processing

      if (artists.isNotEmpty) {
        return artists;
      } else {
        return []; // Return empty list if no artists found
      }
    } else {
      throw Exception('Failed to fetch artists');
    }
  }

  Future<void> _getArtists() async {
    try {
      // Get user input from search controller
      final query = _searchController.text.trim();
      // Fetch artists using user input
      final artists = await fetchArtists(query);

      // Update UI with results
      setState(() {
        _searchResults = artists;
        _errorMessage = 'error'; // Clear any previous error message
      });
    } on Exception {
      // Handle error
      setState(() {
        var _searchResults = []; // Clear previous results
        var _errorMessage = 'Error fetching artists';
      });
    }
  }

  Future<void> saveSearchHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('searchHistory') ?? [];
    history.add(query);
    if (history.length > 10) {
      history.removeRange(
          0, history.length - 10); // Keep only the last 10 searches
    }
    await prefs.setStringList('searchHistory', history);
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('searchHistory') ?? [];
  }

  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Discovery App 🎵'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for Artists or Songs',
                prefixIcon: const Icon(Icons.search),
                errorText: _errorMessage.isEmpty
                    ? null
                    : _errorMessage, // Display error message if any
              ),
              onSubmitted: (query) async {
                setState(() {
                  _searchResults = []; // Clear previous results
                  _errorMessage = ''; // Clear previous error message
                });
                try {
                  final results = await fetchArtists(query);
                  setState(() {
                    _searchResults = results;
                  });
                  saveSearchHistory(query); // Save search term to history
                } catch (error) {
                  setState(() {
                    _errorMessage = 'Error fetching results';
                  });
                }
              },
            ),
          ),
          if (_searchResults.isEmpty && _errorMessage.isEmpty)
            const Center(
                child:
                    CircularProgressIndicator()), // Show loading indicator while fetching results
          if (_errorMessage.isNotEmpty)
            Text(_errorMessage,
                style: const TextStyle(
                    color: Colors.red)), // Display error message
          if (_searchResults.isNotEmpty)
            _buildSearchResults(), // Display search results if any
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: 'Playlists',
                icon: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 24.0,
                )),
            BottomNavigationBarItem(
                label: 'History', icon: Icon(Icons.history_rounded))
          ],
          currentIndex: currentindex,
          onTap: (int index) {
            setState(() {
              currentindex = index;
            });
            // Navigate to the corresponding screen based on the selected index
            switch (index) {
              case 1:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PlaylistScreen())); // Push playlist screen
                break;
              case 2:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        HistoryScreen())); // Push history screen
                break;
            }
          }),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final artist = _searchResults[index];
        return ListTile(
          leading: Text('${index + 1}'),
          title: Text(artist.strArtist),
          subtitle: Text(artist.strGenre),
        );
      },
    );
  }
}
