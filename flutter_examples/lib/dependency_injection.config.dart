// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_examples/core/app_module.dart' as _i11;
import 'package:flutter_examples/data/repositories/authentication_repository.dart'
    as _i5;
import 'package:flutter_examples/data/repositories/user_repository.dart' as _i7;
import 'package:flutter_examples/domain/repositores/authentication/i_authentication_repository.dart'
    as _i4;
import 'package:flutter_examples/domain/repositores/user/i_user_repository.dart'
    as _i6;
import 'package:flutter_examples/presentation/auth/bloc/auth_bloc.dart' as _i10;
import 'package:flutter_examples/presentation/login/bloc/login_bloc.dart'
    as _i8;
import 'package:flutter_examples/presentation/registration/bloc/registration_bloc.dart'
    as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:supabase_flutter/supabase_flutter.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.FunctionsClient>(() => appModule.functionsClient);
    gh.factory<_i3.GoTrueClient>(() => appModule.supabaseAuth);
    gh.factory<_i4.IAuthenticationRepository>(
        () => _i5.AuthenticationRepository(gh<_i3.GoTrueClient>()));
    gh.factory<_i6.IUserRepository>(
        () => _i7.UserRepository(gh<_i3.FunctionsClient>()));
    gh.factory<_i8.LoginBloc>(
        () => _i8.LoginBloc(gh<_i4.IAuthenticationRepository>()));
    gh.factory<_i9.RegistrationBloc>(
        () => _i9.RegistrationBloc(gh<_i4.IAuthenticationRepository>()));
    gh.factory<_i10.AuthBloc>(() => _i10.AuthBloc(
          gh<_i4.IAuthenticationRepository>(),
          gh<_i6.IUserRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i11.AppModule {}
