import 'package:floor/floor.dart';

@entity
class PostEntity {
  @PrimaryKey()
  String id;
  String image;
  int likes;
  String text;
  String publishDate;
  String ownerFirstName;
  String ownerLastName;
  String ownerImageUrl;

  PostEntity(this.id, this.image, this.likes, this.text, this.publishDate,
      this.ownerFirstName, this.ownerLastName, this.ownerImageUrl);
}
