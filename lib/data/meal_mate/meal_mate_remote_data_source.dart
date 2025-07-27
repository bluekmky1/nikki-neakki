import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/supabase/supabase_service.dart';
import 'entity/meal_mate_entity.dart';

final Provider<MealMateRemoteDataSource> mealMateRemoteDataSourceProvider =
    Provider<MealMateRemoteDataSource>(
  (Ref<MealMateRemoteDataSource> ref) =>
      MealMateRemoteDataSource(ref.watch(supabaseServiceProvider.notifier)),
);

class MealMateRemoteDataSource {
  const MealMateRemoteDataSource(this._supabaseService);

  final SupabaseService _supabaseService;

  Future<MealMateEntity?> getMealMate({
    required String userId,
  }) async {
    final List<Map<String, dynamic>> response = await _supabaseService
        .supabaseClient
        .from('meal_mate')
        .select()
        .eq('user1_id', userId)
        .limit(1);

    if (response.isEmpty) {
      return null;
    }

    return MealMateEntity.fromJson(response.first);
  }

  Future<String> getMateUserName({
    required String userId,
  }) async {
    final Map<String, dynamic> response = await _supabaseService.supabaseClient
        .rpc('get_mate_user_name', params: <String, String>{'user_id': userId});

    return response['user2_name'];
  }
}
