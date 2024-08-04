import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_viewer/feature/common/di/app_module.dart';
import 'package:json_viewer/feature/json_viewer/presentation/manager/json_viewer_cubit.dart';
import 'package:json_viewer/feature/json_viewer/presentation/pages/json_viewer_screen.dart';
import 'package:json_viewer/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    FutureBuilder(
        future: appModuleSetup(),
        builder: (context, snapshot) {
          return FutureBuilder(
              future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              ),
              builder: (context, snapshot) {
                return MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider<JsonViewerCubit>(
                      create: (_) => JsonViewerCubit(),
                    )
                  ],
                  child: const MyApp(),
                );
              });
        }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Validator & Formatter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JsonViewerScreen(),
    );
  }
}
