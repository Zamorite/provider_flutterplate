import 'package:pedantic/pedantic.dart';
import 'package:flutterplate/core/data_sources/posts/posts_local_data_source.dart';
import 'package:flutterplate/core/data_sources/users/users_local_data_source.dart';
import 'package:flutterplate/core/services/auth/auth_service.dart';
import 'package:flutterplate/core/services/hardware_info/hardware_info_service.dart';
import 'package:flutterplate/core/services/navigation/navigation_service.dart';
import 'package:flutterplate/locator.dart';
import 'package:flutterplate/ui/router.gr.dart';
import 'package:stacked/stacked.dart';

class StartUpViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final postsLocalDataSource = locator<PostsLocalDataSource>();
  final usersLocalDataSource = locator<UsersLocalDataSource>();
  final hardwareInfoService = locator<HardwareInfoService>();

  Future handleStartUpLogic() async {
    final hasLoggedInUser = await _authService.isUserLoggedIn();

    await Future.wait([
      postsLocalDataSource.init(),
      usersLocalDataSource.init(),
      hardwareInfoService.init(),
    ]);

    if (hasLoggedInUser) {
      unawaited(_navigationService.pushReplacementNamed(Routes.mainView));
    } else {
      unawaited(_navigationService.pushReplacementNamed(Routes.loginView));
    }
  }
}
