// import 'package:frontend/core/utils/circular_progress_indicator/circlular_indicator.dart';
// import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
// import 'package:frontend/core/utils/constants/image_strings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';

// class FullScreenOverlay extends StatelessWidget {
//   final bool isLoading;
//   final Widget child;

//   const FullScreenOverlay({
//     super.key,
//     required this.isLoading,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         child,
//         if (isLoading)
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Positioned(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   color: Colors.black.withOpacity(0.6),
//                   child: Center(
//                     child: CustomLoading(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';

class FullScreenOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const FullScreenOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            // Ensures full-screen overlay
            child: Container(
              color: KColors.black.withAlpha(60),
              child: const Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CustomLoading(),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
