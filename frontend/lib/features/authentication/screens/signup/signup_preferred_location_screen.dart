import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
import 'package:provider/provider.dart';

// class SignupPreferredLocationScreen extends StatelessWidget {
//   const SignupPreferredLocationScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight() + 5.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Appbar(isActionRequired: false),
//             Row(
//               children: [
//                 Container(
//                   color: KColors.primary,
//                   height: 5.h,
//                   width: 150.w,
//                 ),
//                 Expanded(
//                   child: Container(
//                     color: KColors.grey,
//                     height: 5.h,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: Consumer<LocationProvider>(
//         builder: (context, locationProvider, _) {
//           return Column(
//             children: [
//               // Province
//               Column(
//                 children: [
//                   Column(
//                     children: [
//                       SizedBox(height: KSizes.defaultSpace),
//                       Text(
//                         "Where are you looking for work?",
//                         style: Theme.of(context)
//                             .textTheme
//                             .headlineMedium
//                             ?.copyWith(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                       ),
//                       SizedBox(height: KSizes.xs),
//                       Text(
//                         "Select a location by priority",
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                               color: KColors.darkerGrey,
//                               fontSize: 17.sp,
//                             ),
//                       ),
//                       SizedBox(height: KSizes.defaultSpace),
//                     ],
//                   ),

//                   // skill and Counter
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
//                     child: SizedBox(
//                       height: locationProvider.selectedProvince != null
//                           ? null
//                           : 430.h,
//                       child: GestureDetector(
//                         onTap: locationProvider.selectedProvince == null
//                             ? () {
//                                 // categoryProvider.toggleMinimizedSkill();
//                               }
//                             : null,
//                         child: Card(
//                           color: KColors.white,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: KSizes.sm, vertical: KSizes.md),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Counter
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Province",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .titleLarge!
//                                           .copyWith(
//                                             fontSize: 18.sp,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                     ),
//                                   ],
//                                 ),

//                                 if (locationProvider.selectedProvince ==
//                                     null) ...[
//                                   SizedBox(height: KSizes.md),

//                                   // Province
//                                   Expanded(
//                                     child: Wrap(
//                                       spacing: 10,
//                                       runSpacing: 10,
//                                       children: locationProvider.provinces
//                                           .map((province) {
//                                         final isSelected =
//                                             locationProvider.selectedProvince ==
//                                                 null;

//                                         return GestureDetector(
//                                           onTap: () {
//                                             if (locationProvider
//                                                     .selectedProvince !=
//                                                 null) {
//                                               ScaffoldMessenger.of(context)
//                                                   .showSnackBar(
//                                                 SnackBar(
//                                                   elevation: 0,
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             KSizes.md),
//                                                   ),
//                                                   behavior:
//                                                       SnackBarBehavior.floating,
//                                                   backgroundColor:
//                                                       KColors.error,
//                                                   content:
//                                                       Text("Max limit reached"),
//                                                   duration:
//                                                       Duration(seconds: 2),
//                                                 ),
//                                               );
//                                             } else {
//                                               // locationProvider.toggleSkill(skill);
//                                             }
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                               horizontal: 16.0,
//                                               vertical: 8.0,
//                                             ),
//                                             decoration: BoxDecoration(
//                                               color: isSelected
//                                                   ? KColors.secondary
//                                                   : Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                               border: Border.all(
//                                                 color: isSelected
//                                                     ? KColors.primary
//                                                     : KColors.grey,
//                                               ),
//                                             ),
//                                             child: Text(
//                                               province.name,
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ),
//                                   ),
//                                   SizedBox(height: KSizes.md),
//                                   // Next Button
//                                   locationProvider.selectedProvince == Null
//                                       ? CustomButton(
//                                           text: "Next",
//                                           onPressed: () {
//                                             // categoryProvider.toggleMinimizedSkill();
//                                           },
//                                         )
//                                       : SizedBox(),
//                                 ],
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class SignupPreferredLocationScreen extends StatelessWidget {
//   const SignupPreferredLocationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight() + 5.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Appbar(isActionRequired: false),
//             Row(
//               children: [
//                 Container(
//                   color: KColors.primary,
//                   height: 5.h,
//                   width: 150.w,
//                 ),
//                 Expanded(
//                   child: Container(
//                     color: KColors.grey,
//                     height: 5.h,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: Consumer<LocationProvider>(
//         builder: (context, locationProvider, _) {
//           return Column(
//             children: [
//               // Header Section
//               Column(
//                 children: [
//                   SizedBox(height: KSizes.defaultSpace),
//                   Text(
//                     "Where are you looking for work?",
//                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                   ),
//                   SizedBox(height: KSizes.xs),
//                   Text(
//                     "Select a location by priority",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                           color: KColors.darkerGrey,
//                           fontSize: 17.sp,
//                         ),
//                   ),
//                   SizedBox(height: KSizes.defaultSpace),
//                 ],
//               ),

//               // Location Selection Section
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
//                 child: SizedBox(
//                   height:
//                       locationProvider.selectedProvince != null ? null : 430.h,
//                   child: GestureDetector(
//                     onTap: locationProvider.selectedProvince == null
//                         ? () {}
//                         : null,
//                     child: Card(
//                       color: KColors.white,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: KSizes.sm, vertical: KSizes.md),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Province Section
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Province",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleLarge!
//                                       .copyWith(
//                                         fontSize: 18.sp,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: KSizes.md),
//                             // Province Selection Wrap
//                             if (locationProvider.selectedProvince == null) ...[
//                               Wrap(
//                                 spacing: 10,
//                                 runSpacing: 10,
//                                 children:
//                                     locationProvider.provinces.map((province) {
//                                   final isSelected =
//                                       locationProvider.selectedProvince ==
//                                           province;

//                                   return GestureDetector(
//                                     onTap: () {
//                                       if (locationProvider.selectedProvince ==
//                                           null) {
//                                         locationProvider
//                                             .setSelectedProvince(province);
//                                       }
//                                     },
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 16.0, vertical: 8.0),
//                                       decoration: BoxDecoration(
//                                         color: isSelected
//                                             ? KColors.secondary
//                                             : Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                           color: isSelected
//                                               ? KColors.primary
//                                               : KColors.grey,
//                                         ),
//                                       ),
//                                       child: Text(
//                                         province.name,
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                               SizedBox(height: KSizes.md),
//                             ],

//                             // District Section
//                             if (locationProvider.selectedProvince != null) ...[
//                               Text(
//                                 "District",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleLarge!
//                                     .copyWith(
//                                       fontSize: 18.sp,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                               ),
//                               SizedBox(height: KSizes.md),
//                               Wrap(
//                                 spacing: 10,
//                                 runSpacing: 10,
//                                 children: locationProvider
//                                     .selectedProvince!.districts
//                                     .map((district) {
//                                   final isSelected =
//                                       locationProvider.selectedDistrict ==
//                                           district;

//                                   return GestureDetector(
//                                     onTap: () {
//                                       if (locationProvider.selectedDistrict ==
//                                           null) {
//                                         locationProvider
//                                             .setSelectedDistrict(district);
//                                       }

//                                     },
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 16.0, vertical: 8.0),
//                                       decoration: BoxDecoration(
//                                         color: isSelected
//                                             ? KColors.secondary
//                                             : Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                           color: isSelected
//                                               ? KColors.primary
//                                               : KColors.grey,
//                                         ),
//                                       ),
//                                       child: Text(
//                                         district.name,
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ],

//                             // Municipality Section
//                             if (locationProvider.selectedDistrict != null) ...[
//                               Text(
//                                 "Municipality",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleLarge!
//                                     .copyWith(
//                                       fontSize: 18.sp,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                               ),
//                               SizedBox(height: KSizes.md),
//                               Wrap(
//                                 spacing: 10,
//                                 runSpacing: 10,
//                                 children: locationProvider
//                                     .selectedDistrict!.municipalities
//                                     .map((municipality) {
//                                   final isSelected =
//                                       locationProvider.selectedMunicipality ==
//                                           municipality;

//                                   return GestureDetector(
//                                     onTap: () {
//                                       if (locationProvider
//                                               .selectedMunicipality ==
//                                           null) {
//                                         locationProvider
//                                             .setSelectedMunicipality(
//                                                 municipality);
//                                       }
//                                     },
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 16.0, vertical: 8.0),
//                                       decoration: BoxDecoration(
//                                         color: isSelected
//                                             ? KColors.secondary
//                                             : Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                           color: isSelected
//                                               ? KColors.primary
//                                               : KColors.grey,
//                                         ),
//                                       ),
//                                       child: Text(
//                                         municipality.name,
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ],

//                             // Street Section
//                             if (locationProvider.selectedMunicipality !=
//                                 null) ...[
//                               Text(
//                                 "Street",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleLarge!
//                                     .copyWith(
//                                       fontSize: 18.sp,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                               ),
//                               SizedBox(height: KSizes.md),
//                               Wrap(
//                                 spacing: 10,
//                                 runSpacing: 10,
//                                 children: locationProvider
//                                     .selectedMunicipality!.streets
//                                     .map((street) {
//                                   final isSelected =
//                                       locationProvider.selectedStreet == street;

//                                   return GestureDetector(
//                                     onTap: () {
//                                       if (locationProvider.selectedStreet ==
//                                           null) {
//                                         locationProvider
//                                             .setSelectedStreet(street);
//                                       }
//                                     },
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 16.0, vertical: 8.0),
//                                       decoration: BoxDecoration(
//                                         color: isSelected
//                                             ? KColors.secondary
//                                             : Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                           color: isSelected
//                                               ? KColors.primary
//                                               : KColors.grey,
//                                         ),
//                                       ),
//                                       child: Text(
//                                         street,
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ],

//                             // Next Button
//                             if (locationProvider.selectedStreet != null) ...[
//                               SizedBox(height: KSizes.md),
//                               CustomButton(
//                                 text: "Next",
//                                 onPressed: () {
//                                   // Proceed to next step
//                                 },
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

class SignupPreferredLocationScreen extends StatelessWidget {
  const SignupPreferredLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight() + 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Appbar(isActionRequired: false),
            Row(
              children: [
                Container(
                  color: KColors.primary,
                  height: 5.h,
                  width: 150.w,
                ),
                Expanded(
                  child: Container(
                    color: KColors.grey,
                    height: 5.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Consumer<LocationProvider>(
        builder: (context, locationProvider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Section
                Column(
                  children: [
                    SizedBox(height: KSizes.defaultSpace),
                    Text(
                      "Where are you looking for work?",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                    ),
                    SizedBox(height: KSizes.xs),
                    Text(
                      "Select a location by priority",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: KColors.darkerGrey,
                            fontSize: 17.sp,
                          ),
                    ),
                    SizedBox(height: KSizes.defaultSpace),
                  ],
                ),

                // Location Selection Section(Province)
                SizedBox(
                  height: locationProvider.isMinimizedProvince ? null : 320.h,
                  child: GestureDetector(
                    onTap: locationProvider.selectedProvince != null
                        ? () {
                            locationProvider.toggleMinimizedProvince();
                          }
                        : null,
                    child: Card(
                      color: KColors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: KSizes.sm, vertical: KSizes.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Province Section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Province",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(height: KSizes.md),
                            // Province Selection Wrap
                            if (!locationProvider.isMinimizedProvince) ...[
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children:
                                    locationProvider.provinces.map((province) {
                                  final isSelected =
                                      locationProvider.selectedProvince ==
                                          province;

                                  return GestureDetector(
                                    onTap: () {
                                      if (locationProvider.selectedProvince ==
                                          province) {
                                        locationProvider.setSelectedProvince(
                                            null); // Deselect if the same province is tapped
                                      } else {
                                        locationProvider.setSelectedProvince(
                                            province); // Select the new province
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? KColors.secondary
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: isSelected
                                              ? KColors.primary
                                              : KColors.grey,
                                        ),
                                      ),
                                      child: Text(
                                        province.name,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: KSizes.md),
                              // Next Button
                              locationProvider.selectedProvince != null
                                  ? CustomButton(
                                      text: "Next",
                                      onPressed: () {
                                        locationProvider
                                            .toggleMinimizedProvince();
                                      },
                                    )
                                  : SizedBox(),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //District selection........................................................................
                // SizedBox(
                //   height:
                //       !locationProvider.isMinimizedDistrict ? null : 320.h,
                //   child: GestureDetector(
                //     onTap: locationProvider.selectedDistrict == null
                //         ? () {
                //             locationProvider.toggleMinimizedDistrict();
                //           }
                //         : null,
                //     child: Card(
                //       color: KColors.white,
                //       child: Padding(
                //         padding: EdgeInsets.symmetric(
                //             horizontal: KSizes.sm, vertical: KSizes.md),
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             // District Section
                //             Row(
                //               mainAxisAlignment:
                //                   MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text(
                //                   "District",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .titleLarge!
                //                       .copyWith(
                //                         fontSize: 18.sp,
                //                         fontWeight: FontWeight.w600,
                //                       ),
                //                 ),
                //               ],
                //             ),
                //             // SizedBox(height: KSizes.md),
                //             // Province Selection Wrap
                //             if (locationProvider.isMinimizedProvince) ...[
                //               Expanded(
                //                 child: Wrap(
                //                   spacing: 10,
                //                   runSpacing: 10,
                //                   children: locationProvider
                //                       .selectedProvince!.districts
                //                       .map((district) {
                //                     final isSelected =
                //                         locationProvider.selectedDistrict ==
                //                             district;

                //                     return GestureDetector(
                //                       onTap: () {
                //                         if (locationProvider
                //                                 .selectedDistrict ==
                //                             district) {
                //                           locationProvider.setSelectedDistrict(
                //                               null); // Deselect if the same province is tapped
                //                         } else {
                //                           locationProvider.setSelectedDistrict(
                //                               district); // Select the new province
                //                         }
                //                       },
                //                       child: Container(
                //                         padding: const EdgeInsets.symmetric(
                //                             horizontal: 16.0, vertical: 8.0),
                //                         decoration: BoxDecoration(
                //                           color: isSelected
                //                               ? KColors.secondary
                //                               : Colors.white,
                //                           borderRadius:
                //                               BorderRadius.circular(20),
                //                           border: Border.all(
                //                             color: isSelected
                //                                 ? KColors.primary
                //                                 : KColors.grey,
                //                           ),
                //                         ),
                //                         child: Text(
                //                           district.name,
                //                           style: TextStyle(
                //                             color: Colors.black,
                //                           ),
                //                         ),
                //                       ),
                //                     );
                //                   }).toList(),
                //                 ),
                //               ),
                //               SizedBox(height: KSizes.md),
                //             ],

                //             // Next Button
                //             locationProvider.selectedDistrict != null
                //                 ? CustomButton(
                //                     text: "Next",
                //                     onPressed: () {
                //                       // Proceed to next step
                //                     },
                //                   )
                //                 : SizedBox(),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                // District Section
                SizedBox(
                  height: locationProvider.isMinimizedDistrict ? null : 300.h,
                  child: GestureDetector(
                    onTap: locationProvider.selectedDistrict != null ||
                            !locationProvider.isMinimizedProvince
                        ? () {
                            locationProvider.toggleMinimizedDistrict();
                          }
                        : null,
                    child: Card(
                      color: KColors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: KSizes.sm, vertical: KSizes.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "District",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  "/5",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            if (!locationProvider.isMinimizedProvince &&
                                !locationProvider.isMinimizedDistrict &&
                                locationProvider.selectedProvince != null) ...[
                              SizedBox(height: KSizes.md),

                              // District
                              Expanded(
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: locationProvider
                                      .selectedProvince!.districts
                                      .map((district) {
                                    final isSelected =
                                        locationProvider.selectedDistrict ==
                                            district;

                                    return GestureDetector(
                                      onTap: () {
                                        if (locationProvider.selectedDistrict ==
                                            district) {
                                          locationProvider.setSelectedDistrict(
                                              null); // Deselect if the same province is tapped
                                        } else {
                                          locationProvider.setSelectedDistrict(
                                              district); // Select the new province
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 8.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? KColors.secondary
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: isSelected
                                                ? KColors.primary
                                                : KColors.grey,
                                          ),
                                        ),
                                        child: Text(
                                          district.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(height: KSizes.md),
                              // Next Button
                              locationProvider.selectedDistrict != null
                                  ? CustomButton(
                                      text: "Next",
                                      onPressed: () {
                                        locationProvider
                                            .toggleMinimizedDistrict();
                                      },
                                    )
                                  : SizedBox(),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                if (locationProvider.selectedProvince != null) ...[
                  Text(
                    "District",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: KSizes.md),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: locationProvider.selectedProvince!.districts
                        .map((district) {
                      final isSelected =
                          locationProvider.selectedDistrict == district;

                      return GestureDetector(
                        onTap: () {
                          if (locationProvider.selectedDistrict == district) {
                            locationProvider.setSelectedDistrict(
                                null); // Deselect if the same district is tapped
                          } else {
                            locationProvider.setSelectedDistrict(
                                district); // Select the new district
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? KColors.secondary : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:
                                  isSelected ? KColors.primary : KColors.grey,
                            ),
                          ),
                          child: Text(
                            district.name,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

  // District Section
                            // if (locationProvider.selectedProvince != null) ...[
                            //   Text(
                            //     "District",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .titleLarge!
                            //         .copyWith(
                            //           fontSize: 18.sp,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //   ),
                            //   SizedBox(height: KSizes.md),
                            //   Wrap(
                            //     spacing: 10,
                            //     runSpacing: 10,
                            //     children: locationProvider
                            //         .selectedProvince!.districts
                            //         .map((district) {
                            //       final isSelected =
                            //           locationProvider.selectedDistrict ==
                            //               district;

                            //       return GestureDetector(
                            //         onTap: () {
                            //           if (locationProvider.selectedDistrict ==
                            //               district) {
                            //             locationProvider.setSelectedDistrict(
                            //                 null); // Deselect if the same district is tapped
                            //           } else {
                            //             locationProvider.setSelectedDistrict(
                            //                 district); // Select the new district
                            //           }
                            //         },
                            //         child: Container(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 16.0, vertical: 8.0),
                            //           decoration: BoxDecoration(
                            //             color: isSelected
                            //                 ? KColors.secondary
                            //                 : Colors.white,
                            //             borderRadius: BorderRadius.circular(20),
                            //             border: Border.all(
                            //               color: isSelected
                            //                   ? KColors.primary
                            //                   : KColors.grey,
                            //             ),
                            //           ),
                            //           child: Text(
                            //             district.name,
                            //             style: TextStyle(
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     }).toList(),
                            //   ),
                            // ],

                            // // Municipality Section
                            // if (locationProvider.selectedDistrict != null) ...[
                            //   Text(
                            //     "Municipality",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .titleLarge!
                            //         .copyWith(
                            //           fontSize: 18.sp,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //   ),
                            //   SizedBox(height: KSizes.md),
                            //   Wrap(
                            //     spacing: 10,
                            //     runSpacing: 10,
                            //     children: locationProvider
                            //         .selectedDistrict!.municipalities
                            //         .map((municipality) {
                            //       final isSelected =
                            //           locationProvider.selectedMunicipality ==
                            //               municipality;

                            //       return GestureDetector(
                            //         onTap: () {
                            //           if (locationProvider
                            //                   .selectedMunicipality ==
                            //               municipality) {
                            //             locationProvider.setSelectedMunicipality(
                            //                 null); // Deselect if the same municipality is tapped
                            //           } else {
                            //             locationProvider.setSelectedMunicipality(
                            //                 municipality); // Select the new municipality
                            //           }
                            //         },
                            //         child: Container(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 16.0, vertical: 8.0),
                            //           decoration: BoxDecoration(
                            //             color: isSelected
                            //                 ? KColors.secondary
                            //                 : Colors.white,
                            //             borderRadius: BorderRadius.circular(20),
                            //             border: Border.all(
                            //               color: isSelected
                            //                   ? KColors.primary
                            //                   : KColors.grey,
                            //             ),
                            //           ),
                            //           child: Text(
                            //             municipality.name,
                            //             style: TextStyle(
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     }).toList(),
                            //   ),
                            // ],

                            // // Street Section
                            // if (locationProvider.selectedMunicipality !=
                            //     null) ...[
                            //   Text(
                            //     "Street",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .titleLarge!
                            //         .copyWith(
                            //           fontSize: 18.sp,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //   ),
                            //   SizedBox(height: KSizes.md),
                            //   Wrap(
                            //     spacing: 10,
                            //     runSpacing: 10,
                            //     children: locationProvider
                            //         .selectedMunicipality!.streets
                            //         .map((street) {
                            //       final isSelected =
                            //           locationProvider.selectedStreet == street;

                            //       return GestureDetector(
                            //         onTap: () {
                            //           if (locationProvider.selectedStreet ==
                            //               street) {
                            //             locationProvider.setSelectedStreet(
                            //                 null); // Deselect if the same street is tapped
                            //           } else {
                            //             locationProvider.setSelectedStreet(
                            //                 street); // Select the new street
                            //           }
                            //         },
                            //         child: Container(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 16.0, vertical: 8.0),
                            //           decoration: BoxDecoration(
                            //             color: isSelected
                            //                 ? KColors.secondary
                            //                 : Colors.white,
                            //             borderRadius: BorderRadius.circular(20),
                            //             border: Border.all(
                            //               color: isSelected
                            //                   ? KColors.primary
                            //                   : KColors.grey,
                            //             ),
                            //           ),
                            //           child: Text(
                            //             street,
                            //             style: TextStyle(
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     }).toList(),
                            //   ),
                            // ],

