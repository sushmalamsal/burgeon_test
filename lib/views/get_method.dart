import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:burgeon/viewmodels/get_viewmodel.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExampleViewModel>.reactive(
      viewModelBuilder: () => ExampleViewModel(),
      onViewModelReady: (model) => model.loadData(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return const Center(child: CircularProgressIndicator());
        }

        if (model.errorMessage.isNotEmpty) {
          return Center(child: Text("Error: ${model.errorMessage}"));
        }

        if (model.data == null || model.data!.data == null) {
          return const Center(child: Text("No data available"));
        }

        final schools = model.data!.data!.schools;

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                model.data!.data!.image ?? "",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: model.data!.data!.image ?? "",
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          model.data!.data!.name ?? "N/A",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          model.data!.data!.address ?? "N/A",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (schools != null && schools.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: schools.length,
                      itemBuilder: (context, index) {
                        final school = schools[index];
                        // final locationParts = school.location?.split(",") ?? [];
                        // final latitude =
                        //     double.tryParse(locationParts.first) ?? 0.0;
                        // final longitude =
                        //     double.tryParse(locationParts.last) ?? 0.0;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "School Details:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Name: ${school.name ?? "N/A"}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Code: ${school.code ?? "N/A"}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Address: ${school.address ?? "N/A"}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Contact: ${school.contactNumber ?? "N/A"}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Email: ${school.email ?? "N/A"}",
                                  style: const TextStyle(fontSize: 14),
                                ),

                                //map view
                                // const SizedBox(height: 10),
                                // const Text(
                                //   "Location:",
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 200,
                                //   child: GoogleMap(
                                //     initialCameraPosition: CameraPosition(
                                //       target: LatLng(latitude, longitude),
                                //       zoom: 14,
                                //     ),
                                //     markers: {
                                //       Marker(
                                //         markerId: MarkerId("schoolLocation"),
                                //         position: LatLng(latitude, longitude),
                                //       )
                                //     },
                                //     onTap: (position) async {
                                //       final googleMapsUrl =
                                //           "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
                                //       if (await canLaunchUrl(
                                //           Uri.parse(googleMapsUrl))) {
                                //         await launchUrl(
                                //           Uri.parse(googleMapsUrl),
                                //           mode: LaunchMode.externalApplication,
                                //         );
                                //       }
                                //     },
                                //   ),
                                // ),

                                //social links
                                const SizedBox(height: 10),
                                const Text(
                                  "Social Links:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    if (school.socialLinks?.facebook != null &&
                                        school
                                            .socialLinks!.facebook!.isNotEmpty)
                                      IconButton(
                                        icon: const Icon(Icons.facebook,
                                            color: Colors.blue),
                                        onPressed: () async {
                                          final facebookUrl =
                                              school.socialLinks!.facebook!;
                                          if (await canLaunchUrl(
                                              Uri.parse(facebookUrl))) {
                                            await launchUrl(
                                              Uri.parse(facebookUrl),
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          }
                                        },
                                      ),
                                    if (school.socialLinks?.website != null &&
                                        school.socialLinks!.website!.isNotEmpty)
                                      IconButton(
                                        icon: const Icon(Icons.language,
                                            color: Colors.green),
                                        onPressed: () async {
                                          final websiteUrl =
                                              school.socialLinks!.website!;
                                          if (await canLaunchUrl(
                                              Uri.parse(websiteUrl))) {
                                            await launchUrl(
                                              Uri.parse(websiteUrl),
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          }
                                        },
                                      ),
                                  ],
                                ),
                                if (school.socialLinks?.others != null &&
                                    school.socialLinks!.others!.isNotEmpty)
                                  Text(
                                    "Others: ${school.socialLinks!.others}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  else
                    const Text("No school details"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
