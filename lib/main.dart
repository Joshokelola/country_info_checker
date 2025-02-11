import 'package:country_info_checker/view/country_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/theme_provider.dart';

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
        debugShowCheckedModeBanner: false,
        theme: isDarkMode ? darkTheme : lightTheme,
        home: const Scaffold(body: CountryListScreen()),
      ),
    );
  }
}
