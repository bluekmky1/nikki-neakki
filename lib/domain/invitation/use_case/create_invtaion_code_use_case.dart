import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/invitation/invitation_repository.dart';
import '../../../data/invitation/response_body/create_invitation_response_body.dart';
import '../../../ui/common/consts/invitation_status.dart';
import '../model/invitation_model.dart';

final AutoDisposeProvider<CreateInvitationCodeUseCase>
    createInvitationCodeUseCaseProvider =
    Provider.autoDispose<CreateInvitationCodeUseCase>(
  (Ref<CreateInvitationCodeUseCase> ref) => CreateInvitationCodeUseCase(
    invitationRepository: ref.read(invitationRepositoryProvider),
  ),
);

class CreateInvitationCodeUseCase {
  final InvitationRepository _invitationRepository;
  CreateInvitationCodeUseCase({
    required InvitationRepository invitationRepository,
  }) : _invitationRepository = invitationRepository;

  Future<UseCaseResult<InvitationModel>> call({
    required String userId,
  }) async {
    final RepositoryResult<CreateInvitationResponseBody> result =
        await _invitationRepository.createInvitationCode(
      userId: userId,
    );

    return switch (result) {
      SuccessRepositoryResult<CreateInvitationResponseBody>() =>
        SuccessUseCaseResult<InvitationModel>(
          data: InvitationModel(
            inviteCode: result.data.inviteCode,
            status: InvitationStatus.pending,
            expireAt: result.data.expiresAt,
          ),
        ),
      FailureRepositoryResult<CreateInvitationResponseBody>() =>
        FailureUseCaseResult<InvitationModel>(
          message: result.messages?[0],
        )
    };
  }
}
