import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../service/supabase/supabase_service.dart';
import 'my_state.dart';

final AutoDisposeStateNotifierProvider<MyViewModel, MyState>
    myViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<MyState> ref) => MyViewModel(
    state: const MyState.init(),
    supabaseService: ref.read(supabaseServiceProvider.notifier),
  ),
);

class MyViewModel extends StateNotifier<MyState> {
  final SupabaseService _supabaseService;

  MyViewModel({
    required MyState state,
    required SupabaseService supabaseService,
  })  : _supabaseService = supabaseService,
        super(state);

  void signOut() {
    _supabaseService.signOut();
  }
}
