import 'package:flutterplate/core/constant/api_routes.dart';
import 'package:flutterplate/core/models/post/post.dart';
import 'package:flutterplate/core/services/http/http_service.dart';
import 'package:flutterplate/locator.dart';

abstract class PostsRemoteDataSource {
  Future<List<Post>> fetchPosts();
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final httpService = locator<HttpService>();

  @override
  Future<List<Post>> fetchPosts() async {
    var postsJsonData =
        await httpService.getHttp(ApiRoutes.posts) as List<dynamic>;

    var posts =
        postsJsonData.map<Post>((postMap) => Post.fromMap(postMap)).toList();

    return posts;
  }
}
