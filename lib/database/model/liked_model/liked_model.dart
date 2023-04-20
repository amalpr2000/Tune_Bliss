import 'package:hive_flutter/hive_flutter.dart';
part 'liked_model.g.dart';

@HiveType(typeId: 0)
class LikedSongs extends HiveObject {
  @HiveField(0)
  int? id;
  LikedSongs({required this.id});
}
