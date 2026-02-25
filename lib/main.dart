import 'package:flutter/material.dart';
import 'package:hrms_yb/core/router/app_router.dart';
import 'package:hrms_yb/core/theme/app_theme_provider.dart';
import 'package:hrms_yb/core/theme/app_theme_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = AppThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: themeProvider)],
      child: const HRMSApp(),
    ),
  );
}

class HRMSApp extends StatelessWidget {
  const HRMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AppView();
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<AppThemeProvider>();

    return RepaintBoundary(
      key: themeProvider.repaintKey,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'HRMS',
        theme: AppThemeScreen.lightTheme,
        darkTheme: AppThemeScreen.darkTheme,
        themeMode: themeProvider.themeMode,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
