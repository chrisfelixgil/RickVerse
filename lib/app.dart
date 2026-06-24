import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/presentation/main_shell.dart';

class RickVerseApp extends StatelessWidget {
  const RickVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RickVerse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainShell(),
    );
  }
}