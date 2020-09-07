import 'package:logging/logging.dart';
import 'package:flutterplate/core/exceptions/repository_exception.dart';
import 'package:flutterplate/core/models/post/post.dart';
import 'package:flutterplate/core/repositories/posts_repository/posts_repository.dart';
import 'package:flutterplate/locator.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _postsRepository = locator<PostsRepository>();
  final _log = Logger('HomeViewModel');

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Future<void> init() async {
    setBusy(true);
    try {
      _posts = await _postsRepository.fetchPosts();
    } on RepositoryException catch (e) {
      _log.shout(e.message);
    }
    setBusy(false);
  }
}
