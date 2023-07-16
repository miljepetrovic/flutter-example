import 'package:flutter_examples/domain/repositores/authentication/i_authentication_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IAuthenticationRepository)
class AuthenticationRepository implements IAuthenticationRepository {
  final GoTrueClient _supabaseAuth;
  static const String _redirectUrl =
      'io.supabase.flutterexample://signup-callback';

  AuthenticationRepository(this._supabaseAuth);

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      await _supabaseAuth.signInWithPassword(password: password, email: email);

  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      await _supabaseAuth.signUp(
          password: password, email: email, emailRedirectTo: _redirectUrl);

  @override
  Future<void> signOut() async => await _supabaseAuth.signOut();

  @override
  Stream<User?> getCurrentUser() =>
      _supabaseAuth.onAuthStateChange.map((event) => event.session?.user);

  @override
  User? getSignedInUser() => _supabaseAuth.currentUser;
}
