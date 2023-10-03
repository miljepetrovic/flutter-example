import 'package:flutter_examples/core/supabase_extensions.dart';
import 'package:flutter_examples/domain/repositores/user/i_user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IUserRepository)
class UserRepository implements IUserRepository {
  final FunctionsClient functionsClient;

  UserRepository(this.functionsClient);

  @override
  Future<void> deleteAccount() async {
    await functionsClient.deleteAccount();
  }
}
