// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'playlist.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class PlaylistAdapter extends TypeAdapter<Playlist> {
//   @override
//   final int typeId = 2;

//   @override
//   Playlist read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Playlist(
//       name: fields[0] as String,
//       songIds: (fields[1] as List).cast<String>(),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, Playlist obj) {
//     writer
//       ..writeByte(2)
//       ..writeByte(0)
//       ..write(obj.name)
//       ..writeByte(1)
//       ..write(obj.songIds);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is PlaylistAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
