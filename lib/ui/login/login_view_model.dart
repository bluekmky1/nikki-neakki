import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/loading_status.dart';
import 'login_state.dart';

final AutoDisposeStateNotifierProvider<LoginViewModel, LoginState>
    loginViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<LoginState> ref) => LoginViewModel(
    state: const LoginState.init(),
  ),
);

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel({
    required LoginState state,
  }) : super(state);

  void onLogin() {
    state = state.copyWith(loadingStatus: LoadingStatus.loading);
  }
}
