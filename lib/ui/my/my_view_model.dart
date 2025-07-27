import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/invitation/model/invitation_model.dart';
import '../../domain/invitation/use_case/create_invtaion_code_use_case.dart';
import '../../domain/invitation/use_case/get_invitaion_use_case.dart';
import '../../service/supabase/supabase_service.dart';
import '../../service/supabase/supabase_state.dart';
import 'my_state.dart';

final AutoDisposeStateNotifierProvider<MyViewModel, MyState>
    myViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref<MyState> ref) => MyViewModel(
    state: MyState.init(),
    supabaseState: ref.read(supabaseServiceProvider),
    supabaseService: ref.read(supabaseServiceProvider.notifier),
    createInvitationCodeUseCase: ref.read(createInvitationCodeUseCaseProvider),
    getInvitationUseCase: ref.read(getInvitationUseCaseProvider),
  ),
);

class MyViewModel extends StateNotifier<MyState> {
  MyViewModel({
    required MyState state,
    required SupabaseState supabaseState,
    required SupabaseService supabaseService,
    required CreateInvitationCodeUseCase createInvitationCodeUseCase,
    required GetInvitationUseCase getInvitationUseCase,
  })  : _supabaseState = supabaseState,
        _supabaseService = supabaseService,
        _createInvitationCodeUseCase = createInvitationCodeUseCase,
        _getInvitationUseCase = getInvitationUseCase,
        super(state);

  final SupabaseState _supabaseState;
  final SupabaseService _supabaseService;
  final CreateInvitationCodeUseCase _createInvitationCodeUseCase;
  final GetInvitationUseCase _getInvitationUseCase;

  // 초대 조회
  Future<void> getInvitationCode() async {
    state = state.copyWith(getInvitationLoadingStatus: LoadingStatus.loading);

    final UseCaseResult<InvitationModel> result =
        await _getInvitationUseCase(userId: _supabaseState.userId);

    switch (result) {
      case SuccessUseCaseResult<InvitationModel>():
        state = state.copyWith(
          getInvitationLoadingStatus: LoadingStatus.success,
          invitationStatus: result.data.status,
          mealMateCode: result.data.inviteCode,
          mealMateCodeExpiryDate: result.data.expireAt,
        );

      case FailureUseCaseResult<InvitationModel>():
        state = state.copyWith(
          getInvitationLoadingStatus: LoadingStatus.error,
        );
    }
  }

  // 초대 생성
  Future<void> createInvitationCode() async {
    state =
        state.copyWith(createInvitationLoadingStatus: LoadingStatus.loading);

    final UseCaseResult<InvitationModel> result =
        await _createInvitationCodeUseCase(userId: _supabaseState.userId);

    switch (result) {
      case SuccessUseCaseResult<InvitationModel>():
        state = state.copyWith(
          createInvitationLoadingStatus: LoadingStatus.success,
          mealMateCode: result.data.inviteCode,
          mealMateCodeExpiryDate: result.data.expireAt,
        );
      case FailureUseCaseResult<InvitationModel>():
        state = state.copyWith(
          createInvitationLoadingStatus: LoadingStatus.error,
        );
    }
  }

  //초대 코드 입력
  Future<void> enterInvitationCode(String code) async {}

  void signOut() {
    _supabaseService.signOut();
  }
}
