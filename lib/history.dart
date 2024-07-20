import 'package:flutter/material.dart';

// ** Hive imports and SearchHistory class commented out **

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // ** Removed searchHistoryProvider declaration (no Hive) **

  final List<String> recentSearches = []; // Assuming initial empty list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search History'),
      ),
      body: Column(
        children: [
          // Show list of recent searches
          Expanded(
            child: ListView.builder(
              itemCount: recentSearches.length,
              itemBuilder: (context, index) {
                final searchTerm = recentSearches[index];
                return ListTile(
                  title: Text(searchTerm),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // ** Handle individual search term deletion (no Hive) **
                      setState(() {
                        recentSearches.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Button to clear entire history
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // ** Clear entire history (no Hive) **
                setState(() {
                  recentSearches.clear();
                });
              },
              child: const Text('Clear History'),
            ),
          ),
        ],
      ),
    );
  }
}
