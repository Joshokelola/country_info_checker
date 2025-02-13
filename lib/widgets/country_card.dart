import 'package:country_info_checker/model/country.dart';
import 'package:flutter/material.dart';
import '../utils/responsiveness.dart'; 
class CountryCard extends StatelessWidget {
  const CountryCard({super.key, required this.country});
  final Country country;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: Responsive.getScreenPadding(context).subtract(const EdgeInsets.symmetric(vertical: 15)),
      leading: Hero(
        tag: 'flag-${country.name}',
        child: Container(
          width: 48,
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(country.flags!['png']),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(
        country.name!,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: Responsive.getAdaptiveFontSize(context, 18),
            ),
      ),
      subtitle: Text(
       country.capital.isEmpty ? '' : country.capital.first,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: Responsive.getAdaptiveFontSize(context, 14),
            ),
      ),
    );
  }
}