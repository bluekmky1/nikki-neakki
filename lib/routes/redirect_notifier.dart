import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/supabase/supabase_service.dart';
import '../service/supabase/supabase_state.dart';

final ChangeNotifierProvider<RedirectNotifier> redirectNotifierProvider =
    ChangeNotifierProvider<RedirectNotifier>(
  (Ref<RedirectNotifier> ref) => RedirectNotifier(ref: ref),
);

// app router 에게 refresh 하라고 알려주는 notifier입니다.
class RedirectNotifier extends ChangeNotifier {
  final Ref _ref;

  RedirectNotifier({
    required Ref<Object?> ref,
  }) : _ref = ref {
    _ref.listen(
        supabaseServiceProvider
            .select((SupabaseState value) => value.isSignedIn),
        (bool? previous, bool next) {
      notifyListeners();
    });
  }
}
