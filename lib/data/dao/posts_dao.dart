

import 'package:floor/floor.dart';

import '../../domain/database_entities/post_entity.dart';


@dao
abstract class PostsDao {
  @Query('SELECT * FROM Post')
  Future<List<PostEntity>> findAllPosts();

  @Query('SELECT name FROM Post')
  Stream<List<String>> findAllPostsByName();

  @Query('SELECT * FROM Post WHERE id = :id')
  Stream<PostEntity?> findPostById(int id);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> insertPost(PostEntity post);
}