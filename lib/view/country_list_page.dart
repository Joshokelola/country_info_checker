import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/country_controller.dart';
import '../provider/search_query_provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/country_card.dart';

class ExplorerScreen extends ConsumerWidget {
  const ExplorerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryState = ref.watch(countryNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              pinned: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              title: Text(
                'Explore.',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    ref.watch(themeProvider) ? Icons.light_mode : Icons.dark_mode,
                  ),
                  onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
                ),
                const SizedBox(width: 8),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search for a country...',
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                      ),
                        onChanged: (value) {
    ref.read(searchQueryProvider.notifier).state = value;
    ref.read(countryNotifierProvider.notifier).searchCountries(value);
  },
                    ),
                
                  ],
                ),
              ),
            ),
            countryState.when(
              data: (countries) {
                if (countries == null || countries.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No countries found.')),
                  );
                }

                countries.sort((a, b) => a.name.compareTo(b.name));
                final groupedCountries = _groupCountriesByLetter(countries);

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final letter = groupedCountries.keys.elementAt(index);
                      final countriesInGroup = groupedCountries[letter]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                            child: Text(
                              letter,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                          ...countriesInGroup.map((country) => CountryCard(country: country,)),
                        ],
                      );
                    },
                    childCount: groupedCountries.length,
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => SliverFillRemaining(
                child: Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }

 
  Map<String, List<dynamic>> _groupCountriesByLetter(List<dynamic> countries) {
    final grouped = <String, List<dynamic>>{};
    for (var country in countries) {
      final letter = country.name[0];
      grouped.putIfAbsent(letter, () => []).add(country);
    }
    return Map.fromEntries(grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  }
}