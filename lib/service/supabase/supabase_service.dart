import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_state.dart';

// Supabase 클라이언트 Provider
final StateNotifierProvider<SupabaseService, SupabaseState>
    supabaseServiceProvider =
    StateNotifierProvider<SupabaseService, SupabaseState>(
  (Ref<SupabaseState> ref) => SupabaseService(
    state: const SupabaseState.init(),
  ),
);

// Supabase 초기화를 위한 클래스
class SupabaseService extends StateNotifier<SupabaseState> {
  SupabaseService({required SupabaseState state}) : super(state);

  Future<void> initialize() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
      debug: true,
    );
  }

  Future<void> signIn() async {
    try {
      // OAuth 로그인 요청
      await supabaseClient.auth.signInWithOAuth(
        OAuthProvider.kakao,
        redirectTo: 'kakao16d4af1d8c1fb56cf5cb8d5fedd6c612://oauth',
      );

      // auth state 변화를 감지하여 실제 로그인 성공 시에만 state 업데이트
      supabaseClient.auth.onAuthStateChange.listen((AuthState data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;

        if (event == AuthChangeEvent.signedIn && session != null) {
          // 실제 로그인 성공 시에만 state 업데이트
          state = state.copyWith(isSignedIn: true);
        }
      });
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('OAuth 로그인 실패: $e');
      }
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    state = state.copyWith(isSignedIn: false);
  }

  SupabaseClient get supabaseClient => Supabase.instance.client;
}
