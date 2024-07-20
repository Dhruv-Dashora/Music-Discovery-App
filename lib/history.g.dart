// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'history.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class SearchHistoryAdapter extends TypeAdapter<SearchHistory> {
//   @override
//   final int typeId = 1;

//   @override
//   SearchHistory read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return SearchHistory(
//       searchTerms: (fields[0] as List).cast<String>(),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, SearchHistory obj) {
//     writer
//       ..writeByte(1)
//       ..writeByte(0)
//       ..write(obj.searchTerms);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is SearchHistoryAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
