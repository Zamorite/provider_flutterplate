import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutterplate/ui/views/login/login_view.dart';
import 'package:flutterplate/ui/views/main/main_view.dart';
import 'package:flutterplate/ui/views/startup/start_up_view.dart';
import 'package:flutterplate/ui/widgets/stateful/post_details/post_details_view.dart';

@AdaptiveAutoRouter(routes: [
  AdaptiveRoute(page: MainView),
  AdaptiveRoute(page: LoginView),
  AdaptiveRoute(page: StartUpView, initial: true),
  AdaptiveRoute(page: PostDetailsView)
])
class $Router {}
