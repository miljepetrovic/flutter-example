import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_examples/domain/repositores/authentication/i_authentication_repository.dart';
import 'package:flutter_examples/domain/repositores/user/i_user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _authenticationRepository;
  final IUserRepository _userRepository;
  StreamSubscription<User?>? _userSubscription;

  AuthBloc(
    this._authenticationRepository,
    this._userRepository,
  ) : super(AuthInitial()) {
    on<AuthInitialCheckRequested>(_onInitialAuthChecked);
    on<AuthLogoutButtonPressed>(_onLogoutButtonPressed);
    on<AuthOnCurrentUserChanged>(_onCurrentUserChanged);
    on<AuthDeleteAccountButtonPressed>(_onDeleteAccountButtonPressed);

    _startUserSubscription();
  }

  Future<void> _onInitialAuthChecked(
      AuthInitialCheckRequested event, Emitter<AuthState> emit) async {
    User? signedInUser = _authenticationRepository.getSignedInUser();

    signedInUser != null
        ? emit(AuthUserAuthenticated(signedInUser))
        : emit(AuthUserUnauthenticated());
  }

  Future<void> _onLogoutButtonPressed(
      AuthLogoutButtonPressed event, Emitter<AuthState> emit) async {
    await _authenticationRepository.signOut();
  }

  Future<void> _onCurrentUserChanged(
          AuthOnCurrentUserChanged event, Emitter<AuthState> emit) async =>
      event.user != null
          ? emit(AuthUserAuthenticated(event.user!))
          : emit(AuthUserUnauthenticated());

  Future<void> _onDeleteAccountButtonPressed(
      AuthDeleteAccountButtonPressed event, Emitter<AuthState> emit) async {
    await _userRepository.deleteAccount();
  }

  void _startUserSubscription() => _userSubscription = _authenticationRepository
      .getCurrentUser()
      .listen((user) => add(AuthOnCurrentUserChanged(user)));

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
