// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_api_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BooksApiResponseAdapter extends TypeAdapter<BooksApiResponse> {
  @override
  final int typeId = 1;

  @override
  BooksApiResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BooksApiResponse(
      books: (fields[0] as List?)?.cast<Books>(),
    );
  }

  @override
  void write(BinaryWriter writer, BooksApiResponse obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.books);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksApiResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
