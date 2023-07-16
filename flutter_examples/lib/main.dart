import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_examples/dependency_injection.dart';
import 'package:flutter_examples/presentation/app.dart';
import 'package:flutter_examples/presentation/auth/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://nlsdfkbpnqazxfebugzw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5sc2Rma2JwbnFhenhmZWJ1Z3p3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODg2NjgyNzksImV4cCI6MjAwNDI0NDI3OX0.QpbchYFmxTgwyHCLR1DlJkNmNzGs2moLIFIbIj04hTM',
  );
  configureDependencies();

  runApp(BlocProvider(
    create: (_) => getIt<AuthBloc>()..add(AuthInitialCheckRequested()),
    child: const FlutterExampleApp(),
  ));
}
