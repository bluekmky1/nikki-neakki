import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/invitation/entity/invitation_entity.dart';
import '../../service/supabase/supabase_service.dart';
import 'response_body/create_invitation_response_body.dart';

final Provider<InvitationRemoteDataSource> invitationRemoteDataSourceProvider =
    Provider<InvitationRemoteDataSource>(
  (Ref<InvitationRemoteDataSource> ref) =>
      InvitationRemoteDataSource(ref.watch(supabaseServiceProvider.notifier)),
);

class InvitationRemoteDataSource {
  const InvitationRemoteDataSource(this._supabaseService);

  final SupabaseService _supabaseService;

  Future<CreateInvitationResponseBody> createInvitationCode({
    required String userId,
  }) async {
    final Map<String, dynamic> response = await _supabaseService.supabaseClient
        .rpc('create_invitation_code',
            params: <String, String>{'user_id': userId});

    return CreateInvitationResponseBody.fromJson(response);
  }

  Future<InvitationEntity> getInvitation({
    required String userId,
  }) async {
    final PostgrestList response = await _supabaseService.supabaseClient
        .from('invitation')
        .select()
        .eq('inviter_id', userId)
        .limit(1);

    if (response.isEmpty) {
      return InvitationEntity.empty();
    }

    return InvitationEntity.fromJson(response.first);
  }
}
