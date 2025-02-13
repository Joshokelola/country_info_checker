import 'package:country_info_checker/view/country_details_page.dart';
import 'package:country_info_checker/widgets/custom_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/country_controller.dart';
import '../providers/search_query_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/responsiveness.dart';
import '../widgets/country_card.dart';

class CountryListScreen extends ConsumerWidget {
  const CountryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryState = ref.watch(countryNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 8),
                Image.asset(
                  ref.watch(themeProvider)
                      ? 'assets/light_logo.png'
                      : 'assets/ex_logo.png',
                  width: 110,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  ref.watch(themeProvider)
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                ),
                onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: Responsive.getScreenPadding(context),
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
                      ref
                          .read(countryNotifierProvider.notifier)
                          .searchCountries(value);
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.language),
                          label: Text(
                            'En',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: Responsive.getAdaptiveFontSize(
                                      context, 12),
                                ),
                          ),
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                elevation: const WidgetStatePropertyAll(0),
                                minimumSize:
                                    const WidgetStatePropertyAll(Size(80, 48)),
                                padding: const WidgetStatePropertyAll(
                                    EdgeInsets.zero),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                              )),
                      ElevatedButton.icon(
                          onPressed: () {
                            _showFilterBottomSheet(context, ref);
                          },
                          icon: const Icon(Icons.filter_list),
                          label: Text(
                            'Filter',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: Responsive.getAdaptiveFontSize(
                                      context, 12),
                                ),
                          ),
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                elevation: const WidgetStatePropertyAll(0),
                                minimumSize:
                                    const WidgetStatePropertyAll(Size(80, 48)),
                                padding: const WidgetStatePropertyAll(
                                    EdgeInsets.all(5)),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                              )),
                    ],
                  )
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

              countries.sort((a, b) => a.name!.compareTo(b.name!));
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
                          padding: Responsive.getScreenPadding(context)
                              .subtract(
                                  const EdgeInsets.symmetric(vertical: 15)),
                          child: Text(
                            letter,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  fontSize: Responsive.getAdaptiveFontSize(
                                      context, 20),
                                ),
                          ),
                        ),
                        ...countriesInGroup.map((country) => GestureDetector(
                              onTap: () {
                                if (country != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CountryDetailScreen(country: country),
                                    ),
                                  );
                                }
                              },
                              child: CountryCard(
                                country: country,
                              ),
                            )),
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
          )
        ]),
      ),
    );
  }

  Map<String, List<dynamic>> _groupCountriesByLetter(List<dynamic> countries) {
    final grouped = <String, List<dynamic>>{};
    for (var country in countries) {
      final letter = country.name[0];
      grouped.putIfAbsent(letter, () => []).add(country);
    }
    return Map.fromEntries(
        grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  }

  void _showFilterBottomSheet(BuildContext context, WidgetRef ref) {
    final List<String> continents = [
      'Africa',
      'Antarctica',
      'Asia',
      'Australia',
      'Europe',
      'North America',
      'South America'
    ];

    final List<String> timeZones = [
      'UTC+01:00',
      'UTC+02:00',
      'UTC+03:00',
      'UTC+04:00',
      'UTC+05:00',
      'UTC+06:00'
    ];

    final selectedContinents = <String>[];
    final selectedTimeZones = <String>[];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      constraints: BoxConstraints(
        maxHeight: Responsive.screenHeight(context) * 0.8,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.minHeight),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Filter',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                          CustomExpansionTile(
                            title: Text(
                              'Continent',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: Responsive.getAdaptiveFontSize(
                                        context, 16),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            children: continents.map((continent) {
                              return CheckboxListTile(
                                title: Text(continent),
                                value: selectedContinents.contains(continent),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedContinents.add(continent);
                                    } else {
                                      selectedContinents.remove(continent);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          CustomExpansionTile(
                            title: Text(
                              'Time Zone',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: Responsive.getAdaptiveFontSize(
                                        context, 16),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            children: timeZones.map((timeZone) {
                              return CheckboxListTile(
                                title: Text(timeZone),
                                value: selectedTimeZones.contains(timeZone),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedTimeZones.add(timeZone);
                                    } else {
                                      selectedTimeZones.remove(timeZone);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedContinents.clear();
                                    selectedTimeZones.clear();
                                  });
                                  ref
                                      .read(countryNotifierProvider.notifier)
                                      .applyFilters(
                                        selectedContinents,
                                        selectedTimeZones,
                                      );
                                },
                                style: Theme.of(context).textButtonTheme.style,
                                child: const Text(
                                  'Reset',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 16),
                              SizedBox(
                                width: Responsive.screenWidth(context) / 1.7,
                                child: ElevatedButton(
                                  onPressed: () {
                                    ref
                                        .read(countryNotifierProvider.notifier)
                                        .applyFilters(
                                          selectedContinents,
                                          selectedTimeZones,
                                        );
                                    Navigator.of(context).pop();
                                  },
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .copyWith(
                                        padding: const WidgetStatePropertyAll(
                                            EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8)),
                                        backgroundColor:
                                            const WidgetStatePropertyAll(
                                                Colors.orange),
                                        foregroundColor:
                                            const WidgetStatePropertyAll(
                                                Colors.white),
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          side: BorderSide.none,
                                        )),
                                      ),
                                  child: const Text(
                                    'Show Results',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
