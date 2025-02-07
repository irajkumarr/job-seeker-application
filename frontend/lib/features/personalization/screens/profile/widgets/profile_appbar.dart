import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/widgets/employer_bottom_sheet.dart';
import 'package:frontend/l10n/l10n.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      elevation: 0.2,
      child: AppBar(
        title: Text(
          "${l10n.profile}",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 22,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              
                    showEmployerBottomSheet(context);
            },
            icon: Icon(
              Icons.business_outlined,
            ),
          ),
          SizedBox(width: KSizes.xs),
        ],
      ),
    );
  }
}
