// ignore_for_file: unnecessary_null_comparison, prefer_spread_collections
// import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:universal_platform/universal_platform.dart';
// import 'package:path_provider/path_provider.dart';
// part 'playlist.g.dart';

// @HiveType(typeId: 2)
// class Playlist {
//   @HiveField(0)
//   final String name;
//   @HiveField(1)
//   final List<String>
//       songIds; // Replace with appropriate data type for song data

//   Playlist({required this.name, required this.songIds});

//   // Method to convert playlist to a list of strings (one song per line)
//   List<String> toExportStringList() {
//     return ["Playlist Name: $name"]..addAll(songIds);
//   }
// }

// class PlaylistProvider extends ChangeNotifier {
//   final Box<Playlist> playlistBox;

//   PlaylistProvider() : playlistBox = Hive.box<Playlist>('playlists');

//   List<Playlist> get allPlaylists => playlistBox.values.toList();

//   // ... other playlist management methods (same as before)

//   Future<void> exportPlaylist(String playlistName, String chosenFormat) async {
//     final playlist = allPlaylists.firstWhere(
//       (playlist) => playlist.name == playlistName,
//       orElse: () => throw Exception('Playlist not found: $playlistName'),
//     );
//     if (playlist != null) {
//       String exportData;
//       switch (chosenFormat) {
//         case 'CSV':
//           exportData = playlist.toExportStringList().join(',');
//           break;
//         case 'Text':
//           exportData = playlist.toExportStringList().join('\n');
//           break;
//         case 'JSON':
//           exportData =
//               jsonEncode({'name': playlist.name, 'songIds': playlist.songIds});
//           break;
//         default:
//           throw Exception('Unsupported export format');
//       }

//       final platform = UniversalPlatform.isAndroid;
//       final directory = await getExternalStorageDirectory();
//       final filePath = '${directory!.path}/playlists/$playlistName.export';
//       await File(filePath).writeAsString(exportData);
//       // final platform_ios = UniversalPlatform.isIOS;
//       // Implement iOS-specific file picking or sharing mechanism
//       // Allow users to choose a location for the exported playlist file.
//       // Can use the 'flutter_file_picker' package for this.
//     } else {
//       throw Exception('Unsupported platform');
//     }
//     notifyListeners();
//   }
//   void clearPlaylist() {
//     playlistBox.delete(0);
//     notifyListeners();
//   }
// }

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final searchPlaylistProvider = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlists'),
      ),
      body: Column(
        children: [
          // Show list of recent searches
          Expanded(
            child: ListView.builder(
              itemCount: searchPlaylistProvider.length,
              itemBuilder: (context, index) {
                final playlistTerm = searchPlaylistProvider[index];
                return ListTile(
                  title: Text("playlists"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Remove individual search term
                      searchPlaylistProvider.clear();
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
              onPressed: searchPlaylistProvider.clear,
              child: const Text('Remove Playlist'),
            ),
          ),
        ],
      ),
    );
  }
}
