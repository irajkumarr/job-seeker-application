import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/authentication/providers/details_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final detailProvider = Provider.of<DetailsProvider>(context);
    final TextEditingController _educationController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return CustomScreen(
      onPressed: () {
        if (_formKey.currentState!.validate()) {}
      },
      buttonText: l10n.submit,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: KSizes.md, vertical: KSizes.defaultSpace),
        child: Column(
          children: [
            Text(
              "Education",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: KSizes.defaultSpace),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name

                  Text(
                    "Add Education",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 18.sp,
                        ),
                  ),
                  SizedBox(
                    height: KSizes.sm,
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: detailProvider.educationQualification
                        .map((educationQualification) {
                      final isSelected =
                          detailProvider.selectedEducationQualification ==
                              educationQualification;

                      return GestureDetector(
                        onTap: () {
                          if (detailProvider.selectedEducationQualification ==
                              educationQualification) {
                            detailProvider
                                .setSelectedEducationQualification(null);
                          } else {
                            detailProvider.setSelectedEducationQualification(
                                educationQualification);
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
                            educationQualification,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: KSizes.md,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
   
  }
}
