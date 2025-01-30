// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:frontend/common/widgets/buttons/custom_button.dart';
// import 'package:frontend/core/routes/routes_constant.dart';
// import 'package:frontend/core/utils/constants/colors.dart';
// import 'package:frontend/core/utils/constants/sizes.dart';
// import 'package:frontend/core/utils/popups/toast.dart';
// import 'package:frontend/features/authentication/providers/location_provider.dart';
// import 'package:go_router/go_router.dart';
// import 'package:http/http.dart' as http;

// class AddressSelectionSection extends StatefulWidget {
//   const AddressSelectionSection({
//     super.key,
//     required this.locationProvider,
//   });
//   final LocationProvider locationProvider;

//   @override
//   State<AddressSelectionSection> createState() =>
//       _AddressSelectionSectionState();
// }

// class _AddressSelectionSectionState extends State<AddressSelectionSection> {
//   late TextEditingController _addressSearchController;
//   List<dynamic> _predictions = [];
//   String? _selectedAddressId;

//   // final String apiKey = 'AIzaSyACJcraRqL3WWJwgh2gdwF64Mtpnu_VLY0';
//   //go maps api key
//   final String apiKey = 'AlzaSyV7Ms7bExqXp1qePyfjE4vZz2JfpLSmrLL';

//   @override
//   void initState() {
//     super.initState();
//     _addressSearchController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _addressSearchController.dispose();
//     super.dispose();
//   }

//   Future<void> _getAddressSuggestions(String input) async {
//     if (input.isEmpty) {
//       setState(() => _predictions = []);
//       return;
//     }

//     try {
//       final String url =
//           // 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
//           'https://maps.gomaps.pro/maps/api/place/autocomplete/json'
//           '?input=${Uri.encodeComponent(input)}'
//           '&components=country:np'
//           '&key=$apiKey'
//           '&sessiontoken=${DateTime.now().millisecondsSinceEpoch}';

//       final response = await http.get(Uri.parse(url));
//       final data = json.decode(response.body);
//       print(data);
//       if (data['status'] == 'OK') {
//         setState(() {
//           _predictions = data['predictions'];
//           _selectedAddressId = null;
//         });
//       }
//     } catch (e) {
//       print('Error fetching suggestions: $e');
//       showToast('Error fetching address suggestions');
//     }
//   }

//   Future<void> _handleAddressSelection(Map<String, dynamic> prediction) async {
//     if (!mounted) return;

//     try {
//       final String address = prediction['description'];
//       setState(() {
//         _selectedAddressId = prediction['place_id'];
//         // _addressSearchController.text = address;
//         // _predictions = []; // Clear suggestions
//       });

//       final String geocodeUrl =
//           'https://maps.googleapis.com/maps/api/geocode/json'
//           '?place_id=${prediction['place_id']}&key=$apiKey';

//       final response = await http.get(Uri.parse(geocodeUrl));
//       final data = json.decode(response.body);
//       print(data);

//       if (!mounted) return;

//       if (data['status'] == 'OK') {
//         // final result = data['results'][0];

//         widget.locationProvider.setSelectedStreet(address);
//       } else {
//         showToast('Failed to get address details');
//       }
//     } catch (e) {
//       print('Error processing address selection: $e');
//       showToast('Error processing address selection');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: KColors.white,
//       child: Padding(
//         padding:
//             EdgeInsets.symmetric(horizontal: KSizes.sm, vertical: KSizes.md),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Address",
//                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                 ),
//                 if (widget.locationProvider.selectedStreet != null &&
//                     widget.locationProvider.isMinimizedAddress)
//                   SizedBox(
//                     width: 150.w,
//                     child: Text(
//                       widget.locationProvider.selectedStreet ?? "",
//                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                             fontSize: 18.sp,
//                             color: KColors.primary,
//                             fontWeight: FontWeight.w600,
//                           ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                     ),
//                   ),
//               ],
//             ),
//             if (!widget.locationProvider.isMinimizedAddress &&
//                 widget.locationProvider.isMinimizedMunicipality) ...[
//               SizedBox(height: KSizes.md),
//               TextField(
//                 controller: _addressSearchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search address',
//                   suffixIcon: Padding(
//                     padding: EdgeInsets.all(KSizes.sm),
//                     child: GestureDetector(
//                       onTap: () async {
//                         await _getAddressSuggestions(
//                             _addressSearchController.text);
//                       },
//                       child: Container(
//                         width: 40.w,
//                         height: 40.h,
//                         decoration: BoxDecoration(
//                           color: KColors.primary,
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         child: Icon(
//                           AntDesign.search1,
//                           color: KColors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(50),
//                     borderSide:
//                         BorderSide(width: 1, color: KColors.lightBackground),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(50),
//                     borderSide:
//                         BorderSide(width: 1, color: KColors.lightBackground),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(50),
//                     borderSide: BorderSide(width: 1, color: KColors.primary),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
//                 ),
//                 onChanged: (value) {
//                   if (value.length > 5) {
//                     Future.delayed(Duration(milliseconds: 1000), () {
//                       if (_addressSearchController.text == value) {
//                         _getAddressSuggestions(value);
//                       }
//                     });
//                   } else {
//                     setState(() => _predictions = []);
//                   }
//                 },
//               ),
//               if (_predictions.isNotEmpty) ...[
//                 SizedBox(height: KSizes.md),
//                 Wrap(
//                   spacing: 10,
//                   runSpacing: 10,
//                   children: _predictions.map((prediction) {
//                     final isSelected =
//                         _selectedAddressId == prediction['place_id'];

//                     return GestureDetector(
//                       onTap: () => _handleAddressSelection(prediction),
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 16.0,
//                           vertical: 8.0,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isSelected ? KColors.secondary : Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: isSelected ? KColors.primary : KColors.grey,
//                           ),
//                         ),
//                         child: (prediction['structured_formatting']
//                                     ['secondary_text'] !=
//                                 null)
//                             ? Text(
//                                 prediction['structured_formatting']
//                                     ['secondary_text'],
//                                 style: TextStyle(
//                                   color: KColors.black,
//                                 ),
//                               )
//                             : SizedBox(),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ],
//               if (widget.locationProvider.selectedStreet != null) ...[
//                 SizedBox(height: KSizes.md),
//                 CustomButton(
//                   text: "Next",
//                   onPressed: () {
//                     context.goNamed(RoutesConstant.personalDetails);
//                   },
//                 ),
//               ],
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

//open street api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/popups/toast.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class AddressSelectionSection extends StatefulWidget {
  const AddressSelectionSection({
    super.key,
    required this.locationProvider,
  });
  final LocationProvider locationProvider;

  @override
  State<AddressSelectionSection> createState() =>
      _AddressSelectionSectionState();
}

class _AddressSelectionSectionState extends State<AddressSelectionSection> {
  late TextEditingController _addressSearchController;
  List<dynamic> _predictions = [];
  String? _selectedAddressId;

  @override
  void initState() {
    super.initState();
    _addressSearchController = TextEditingController();
  }

  @override
  void dispose() {
    _addressSearchController.dispose();
    super.dispose();
  }

  Future<void> _getAddressSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() => _predictions = []);
      return;
    }

    try {
      final String url = 'https://nominatim.openstreetmap.org/search'
          '?q=${Uri.encodeComponent(input)}'
          '&countrycodes=np'
          '&format=json'
          '&addressdetails=1'
          '&limit=10';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'YourApp/1.0',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _predictions = data;
          _selectedAddressId = null;
        });
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
      showToast('Error fetching address suggestions');
    }
  }

  Future<void> _handleAddressSelection(Map<String, dynamic> prediction) async {
    if (!mounted) return;

    try {
      final String address = _formatDetailedAddress(prediction);
      setState(() {
        _selectedAddressId = prediction['place_id'].toString();
      });

      if (!mounted) return;
      widget.locationProvider.setSelectedStreet(address);
    } catch (e) {
      print('Error processing address selection: $e');
      showToast('Error processing address selection');
    }
  }

  String _formatDetailedAddress(Map<String, dynamic> osmData) {
    final Map<String, dynamic> address = osmData['address'] ?? {};
    List<String> addressComponents = [];

    // Building a more detailed address with available components
    if (address['road'] != null) addressComponents.add(address['road']);
    if (address['neighbourhood'] != null)
      addressComponents.add(address['neighbourhood']);
    if (address['suburb'] != null) addressComponents.add(address['suburb']);
    if (address['city_district'] != null)
      addressComponents.add(address['city_district']);
    if (address['city'] != null) addressComponents.add(address['city']);
    if (address['municipality'] != null &&
        address['municipality'] != address['city']) {
      addressComponents.add(address['municipality']);
    }
    if (address['state'] != null) addressComponents.add(address['state']);
    if (address['country'] != null) addressComponents.add(address['country']);

    // If no detailed components are available, fall back to display_name
    if (addressComponents.isEmpty && osmData['display_name'] != null) {
      return osmData['display_name'];
    }

    return addressComponents.join(', ');
  }

  String _formatDisplayAddress(Map<String, dynamic> osmData) {
    final Map<String, dynamic> address = osmData['address'] ?? {};
    List<String> displayParts = [];

    // Primary location (road/place name)
    if (address['road'] != null) {
      displayParts.add(address['road']);
    } else if (address['amenity'] != null) {
      displayParts.add(address['amenity']);
    }

    // Area information
    if (address['suburb'] != null) {
      displayParts.add(address['suburb']);
    } else if (address['neighbourhood'] != null) {
      displayParts.add(address['neighbourhood']);
    }

    // City/Municipality
    if (address['city'] != null) {
      displayParts.add(address['city']);
    } else if (address['municipality'] != null) {
      displayParts.add(address['municipality']);
    }

    // State and Country
    if (address['state'] != null) {
      displayParts.add(address['state']);
    }
    if (address['country'] != null) {
      displayParts.add(address['country']);
    }

    // If no components are available, use a substring of display_name
    if (displayParts.isEmpty && osmData['display_name'] != null) {
      String displayName = osmData['display_name'];
      // Take first part of the address before the first comma
      return displayName.split(',').take(2).join(',');
    }

    return displayParts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: KColors.white,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: KSizes.sm, vertical: KSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Address",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (widget.locationProvider.selectedStreet != null &&
                    widget.locationProvider.isMinimizedAddress)
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      widget.locationProvider.selectedStreet ?? "",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 18.sp,
                            color: KColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
              ],
            ),
            if (!widget.locationProvider.isMinimizedAddress &&
                widget.locationProvider.isMinimizedMunicipality) ...[
              SizedBox(height: KSizes.md),
              TextField(
                controller: _addressSearchController,
                decoration: InputDecoration(
                  hintText: 'Search address',
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(KSizes.sm),
                    child: GestureDetector(
                      onTap: () async {
                        await _getAddressSuggestions(
                            _addressSearchController.text);
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: KColors.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          AntDesign.search1,
                          color: KColors.white,
                        ),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        BorderSide(width: 1, color: KColors.lightBackground),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        BorderSide(width: 1, color: KColors.lightBackground),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(width: 1, color: KColors.primary),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
                ),
                onChanged: (value) {
                  if (value.length > 5) {
                    Future.delayed(Duration(milliseconds: 1000), () {
                      if (_addressSearchController.text == value) {
                        _getAddressSuggestions(value);
                      }
                    });
                  } else {
                    setState(() => _predictions = []);
                  }
                },
              ),
              if (_predictions.isNotEmpty) ...[
                SizedBox(height: KSizes.md),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _predictions.map((prediction) {
                    final isSelected =
                        _selectedAddressId == prediction['place_id'].toString();
                    final displayText = _formatDisplayAddress(prediction);
                    return GestureDetector(
                      onTap: () => _handleAddressSelection(prediction),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? KColors.secondary : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? KColors.primary : KColors.grey,
                          ),
                        ),
                        child: Text(
                          displayText,
                          style: TextStyle(
                            color: KColors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              if (widget.locationProvider.selectedStreet != null) ...[
                SizedBox(height: KSizes.md),
                CustomButton(
                  text: "Next",
                  onPressed: () {
                    context.goNamed(RoutesConstant.personalDetails);
                  },
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

//  Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: widget.locationProvider.selectedMunicipality!.streets
//                     .map((street) {
//                   final isSelected =
//                       widget.locationProvider.selectedStreet == street;

//                   return GestureDetector(
//                     onTap: () {
//                       if (widget.locationProvider.selectedStreet == street) {
//                         widget.locationProvider.setSelectedStreet(null);
//                       } else {
//                         widget.locationProvider.setSelectedStreet(street);
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16.0,
//                         vertical: 8.0,
//                       ),
//                       decoration: BoxDecoration(
//                         color: isSelected ? KColors.secondary : Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: isSelected ? KColors.primary : KColors.grey,
//                         ),
//                       ),
//                       child: Text(
//                         street,
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
