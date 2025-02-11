import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/country.dart';
import '../utils/responsiveness.dart'; // Import the Responsive class

class CountryDetailScreen extends ConsumerWidget {
  final Country country;

  const CountryDetailScreen({
    super.key,
    required this.country,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          country.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: Responsive.getAdaptiveFontSize(context, 22),
              ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2,
              child: Container(
                margin: Responsive.getScreenPadding(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    '${country.flagImage}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: Responsive.getScreenPadding(context),
              child: Column(
                children: [
                  _buildInfoRow('Population', country.population, context),
                  _buildInfoRow('Capital', country.capital, context),
                  _buildInfoRow('President', country.president, context),
                  _buildInfoRow('Country code', country.countryCode, context),
                  _buildInfoRow('Continent', country.continent, context),
                  if (country.states != null && country.states!.isNotEmpty)
                    _buildStatesSection(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 32),
        Text(
          'States',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: Responsive.getAdaptiveFontSize(context, 20),
              ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: country.states!.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                country.states![index].name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: Responsive.getAdaptiveFontSize(context, 16),
                    ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            );
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: Responsive.getAdaptiveFontSize(context, 16),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Responsive.getAdaptiveFontSize(context, 16),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
