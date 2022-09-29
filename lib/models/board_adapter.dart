import 'package:hive_flutter/hive_flutter.dart';

import 'board.dart';

class BoardAdapter extends TypeAdapter<Board> {
  @override
  final typeId = 0;

  @override
  Board read(BinaryReader reader) {
    return Board.fromJson(Map<String, dynamic>.from(reader.read()));
  }

  @override
  void write(BinaryWriter writer, Board obj) {
    writer.write(obj.toJson());
  }
}
