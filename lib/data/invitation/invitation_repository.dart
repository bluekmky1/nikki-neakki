import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'entity/invitation_entity.dart';
import 'invitation_remote_data_source.dart';
import 'response_body/create_invitation_response_body.dart';

final Provider<InvitationRepository> invitationRepositoryProvider =
    Provider<InvitationRepository>(
  (Ref<InvitationRepository> ref) =>
      InvitationRepository(ref.watch(invitationRemoteDataSourceProvider)),
);

class InvitationRepository extends Repository {
  const InvitationRepository(this._invitationRemoteDataSource);

  final InvitationRemoteDataSource _invitationRemoteDataSource;

  Future<RepositoryResult<CreateInvitationResponseBody>> createInvitationCode({
    required String userId,
  }) async {
    try {
      final CreateInvitationResponseBody response =
          await _invitationRemoteDataSource.createInvitationCode(
        userId: userId,
      );

      return SuccessRepositoryResult<CreateInvitationResponseBody>(
        data: response,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<CreateInvitationResponseBody>(
        error: e,
        messages: <String>['식사 메이트 정보를 조회하는 과정에 오류가 발생했습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<CreateInvitationResponseBody>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<CreateInvitationResponseBody>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  Future<RepositoryResult<InvitationEntity>> getInvitation({
    required String userId,
  }) async {
    try {
      final InvitationEntity response =
          await _invitationRemoteDataSource.getInvitation(
        userId: userId,
      );

      return SuccessRepositoryResult<InvitationEntity>(
        data: response,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<InvitationEntity>(
        error: e,
        messages: <String>['초대 정보를 조회하는 과정에 오류가 발생했습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<InvitationEntity>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<InvitationEntity>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }
}
