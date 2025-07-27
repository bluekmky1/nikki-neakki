import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/invitation/entity/invitation_entity.dart';
import '../../../data/invitation/invitation_repository.dart';
import '../../../ui/common/consts/invitation_status.dart';
import '../model/invitation_model.dart';

final AutoDisposeProvider<GetInvitationUseCase> getInvitationUseCaseProvider =
    Provider.autoDispose<GetInvitationUseCase>(
  (Ref<GetInvitationUseCase> ref) => GetInvitationUseCase(
    invitationRepository: ref.read(invitationRepositoryProvider),
  ),
);

class GetInvitationUseCase {
  final InvitationRepository _invitationRepository;
  GetInvitationUseCase({
    required InvitationRepository invitationRepository,
  }) : _invitationRepository = invitationRepository;

  Future<UseCaseResult<InvitationModel>> call({
    required String userId,
  }) async {
    final RepositoryResult<InvitationEntity> result =
        await _invitationRepository.getInvitation(
      userId: userId,
    );

    return switch (result) {
      SuccessRepositoryResult<InvitationEntity>() =>
        SuccessUseCaseResult<InvitationModel>(
          data: InvitationModel(
            inviteCode: result.data.inviteCode,
            status: InvitationStatus.fromString(result.data.inviteStatus),
            expireAt: result.data.expireAt,
          ),
        ),
      FailureRepositoryResult<InvitationEntity>() =>
        FailureUseCaseResult<InvitationModel>(
          message: result.messages?[0],
        )
    };
  }
}
