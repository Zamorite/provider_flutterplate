import 'package:flutterplate/core/models/post/post.dart';
import 'package:flutterplate/core/services/navigation/navigation_service.dart';
import 'package:flutterplate/locator.dart';
import 'package:flutterplate/ui/router.gr.dart';
import 'package:stacked/stacked.dart';

class PostTileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Post _post;
  Post get post => _post;

  void init(Post post) {
    _post = post;
  }

  void showPostDetails() {
    _navigationService.pushNamed(Routes.postDetailsView,
        arguments: PostDetailsViewArguments(post: _post));
  }
}
