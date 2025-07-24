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
    try {
      final UserResponse user = await supabaseClient.auth.getUser();
      final String username = user.user?.userMetadata?['user_name'] ?? '';
      print('username: $username');
      state = state.copyWith(
        isSignedIn: true,
        userId: user.user?.id ?? '',
        username: username,
      );
      state = state.copyWith(isSignedIn: user.user != null);
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('Supabase 초기화 실패: $e');
      }
    }
  }

  Future<void> signIn() async {
    try {
      // OAuth 로그인 요청
      await supabaseClient.auth.signInWithOAuth(
        OAuthProvider.kakao,
        redirectTo: 'kakao16d4af1d8c1fb56cf5cb8d5fedd6c612://oauth',
        authScreenLaunchMode: LaunchMode.externalApplication,
      );

      // auth state 변화를 감지하여 실제 로그인 성공 시에만 state 업데이트
      supabaseClient.auth.onAuthStateChange.listen((AuthState data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;

        if (event == AuthChangeEvent.signedIn && session != null) {
          final User user = session.user;
          final String username = user.userMetadata?['user_name'] ?? '';
          state = state.copyWith(
            isSignedIn: true,
            userId: user.id,
            username: username,
          );
        }
      });
    } on AuthException catch (e) {
      if (kDebugMode) {
        print('OAuth 로그인 실패: $e');
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('OAuth 로그인 중 예상치 못한 에러: $e');
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
