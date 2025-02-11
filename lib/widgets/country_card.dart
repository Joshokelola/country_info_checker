import 'package:country_info_checker/model/country.dart';
import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({super.key, required this.country});
  final Country country;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.04),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(country.flagImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          country.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          country.capital,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
