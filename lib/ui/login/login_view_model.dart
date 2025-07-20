import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/supabase/supabase_service.dart';
import 'login_state.dart';

final AutoDisposeStateNotifierProvider<LoginViewModel, LoginState>
    loginViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<LoginState> ref) => LoginViewModel(
    state: const LoginState.init(),
    supabaseService: ref.read(supabaseServiceProvider.notifier),
  ),
);

class LoginViewModel extends StateNotifier<LoginState> {
  final SupabaseService _supabaseService;

  LoginViewModel({
    required LoginState state,
    required SupabaseService supabaseService,
  })  : _supabaseService = supabaseService,
        super(state);

  Future<void> signInWithKakao() async {
    await _supabaseService.signIn();
  }
}
