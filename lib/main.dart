import 'package:country_info_checker/view/country_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider/theme_provider.dart';
import 'services/country_api_service.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    return AnimatedTheme(
      data: isDarkMode ? darkTheme : lightTheme,
      duration: const Duration(milliseconds: 300),
      child: MaterialApp(
        title: 'Country Info Checker',
        theme: isDarkMode ? darkTheme : lightTheme,
        home: Scaffold(
          body: ExplorerScreen()
        ),
        
      ),
    );
  }
}
