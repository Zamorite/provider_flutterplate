import 'package:logging/logging.dart';
import 'package:pedantic/pedantic.dart';
import 'package:flutterplate/core/exceptions/auth_exception.dart';
import 'package:flutterplate/core/mixins/validators.dart';
import 'package:flutterplate/core/services/auth/auth_service.dart';
import 'package:flutterplate/core/services/navigation/navigation_service.dart';
import 'package:flutterplate/locator.dart';
import 'package:flutterplate/ui/router.gr.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel with Validators {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _log = Logger('HomeViewModel');

  Future<void> login(String email, String password) async {
    setBusy(true);
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      unawaited(_navigationService.popAllAndPushNamed(Routes.mainView));
    } on AuthException catch (e) {
      _log.shout(e.message);
      setBusy(false);
    }
  }
}
