import 'package:flutterplate/core/models/post/post.dart';

abstract class PostsRepository {
  Future<List<Post>> fetchPosts();
}
