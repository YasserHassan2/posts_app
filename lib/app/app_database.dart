// database.dart

// required package imports
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../data/dao/posts_dao.dart';
import '../domain/database_entities/post_entity.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [PostEntity])
abstract class AppDatabase extends FloorDatabase {
  PostsDao get postsDao;
}
