import 'package:country_info_checker/widgets/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/country.dart';
import '../utils/responsiveness.dart';

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
          country.name!,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: Responsive.getAdaptiveFontSize(context, 24),
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flag Image Section
            CountryCarousel(imageUrls: [
              '${country.flags!['png']}',
              '${country.coatOfArms!['png']}'
            ], countryName: country.name!),
            // Padding(
            //   padding: Responsive.getScreenPadding(context),
            //   child: Card(
            //     elevation: 4,
            //     shadowColor:
            //         Theme.of(context).colorScheme.primary.withOpacity(0.3),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(16),
            //     ),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(16),
            //       child: AspectRatio(
            //         aspectRatio: 2,
            //         child: Hero(
            //           tag: 'flag-${country.name}',
            //           child: Image.network(
            //             country.flags!['png'],
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Country Details Section
            Padding(
              padding: Responsive.getScreenPadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('Population',
                              country.population.toString(), context),
                          _buildInfoRow(
                              'Region',
                              country.continents.isEmpty
                                  ? ''
                                  : country.continents.first,
                              context),
                          _buildInfoRow(
                              'Capital',
                              country.capital.isEmpty
                                  ? ''
                                  : country.capital.first,
                              context),
                          _buildInfoRow(
                              'Country code',
                              country.cca3!,
                                 
                              context),
                          const SizedBox(
                            height: 15,
                          ),
                          _buildInfoRow(
                              'Official language',
                              country.languages?.values.first?.toString() ?? '',
                              context),
                          _buildInfoRow('Area',
                              '${country.area?.toString() ?? ""} km²', context),
                          _buildInfoRow(
                              'Currency',
                              country.currencies?.values.first['name']
                                      ?.toString() ??
                                  '',
                              context),
                          const SizedBox(
                            height: 15,
                          ),
                          _buildInfoRow('Time zone',
                              country.timeZones?.first ?? '', context),
                          _buildInfoRow(
                              'Dialling code',
                              '${country.dialingCodes?['root']?.toString()}${country.dialingCodes?['suffixes']?.first}',
                             context),
                          _buildInfoRow(
                              'Driving side',
                              country.drivingSide?['side']?.toString() ?? '',
                              context),
                        ],
                      )),
                  // if (country.statesUrl != null &&
                  //     country.statesUrl!.isNotEmpty)
                  //   _buildStatesSection(context, ref),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildStatesSection(BuildContext context, WidgetRef ref) {
  //   return ref.watch(getStatesProvider(country.statesUrl!)).when(
  //     data: (data) {
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Divider(height: 32),
  //           Text(
  //             'States',
  //             style: Theme.of(context).textTheme.titleLarge?.copyWith(
  //                   fontSize: Responsive.getAdaptiveFontSize(context, 22),
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //           ),
  //           const SizedBox(height: 16),
  //           Card(
  //             elevation: 4,
  //             shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(16),
  //               child: ListView.builder(
  //                 physics: const NeverScrollableScrollPhysics(),
  //                 shrinkWrap: true,
  //                 itemCount: data.length,
  //                 itemBuilder: (context, index) {
  //                   return Container(
  //                       padding: const EdgeInsets.symmetric(vertical: 12),
  //                       decoration: BoxDecoration(
  //                         border: index != data.length - 1
  //                             ? Border(
  //                                 bottom: BorderSide(
  //                                   color: Colors.grey.withOpacity(0.2),
  //                                   width: 1,
  //                                 ),
  //                               )
  //                             : null,
  //                       ),
  //                       child: Text(
  //                         data[index].name,
  //                         style: Theme.of(context)
  //                             .textTheme
  //                             .bodyLarge
  //                             ?.copyWith(
  //                               fontSize:
  //                                   Responsive.getAdaptiveFontSize(context, 18),
  //                             ),
  //                       ));
  //                 },
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //     error: (error, __) {
  //       return Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 16),
  //           child: Center(
  //             child: Text(
  //               'Failed to load states: $error',
  //               style: TextStyle(
  //                 color: Colors.red,
  //                 fontSize: Responsive.getAdaptiveFontSize(context, 16),
  //               ),
  //             ),
  //           ));
  //     },
  //     loading: () {
  //       return const Padding(
  //         padding: EdgeInsets.symmetric(vertical: 16),
  //         child: Center(
  //           child: CircularProgressIndicator(),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: Responsive.getAdaptiveFontSize(context, 16),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: Responsive.getAdaptiveFontSize(context, 14),
                  fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
