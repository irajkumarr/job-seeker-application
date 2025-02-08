import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final box = GetStorage();
    final String? token = box.read("token");

    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final userName = profileProvider.profile?.name ?? "";
    String getGreeting() {
      final hour = DateTime.now().hour;
      final greeting = hour >= 1 && hour < 12
          ? l10n.goodMorning
          : hour >= 12 && hour < 17
              ? l10n.goodAfternoon
              : l10n.goodEvening;

      // Get the day of the week
      final dayOfWeek = DateFormat('EEEE').format(DateTime.now());

      // Get special greeting based on day
      String specialGreeting = '';
      if (dayOfWeek == 'Monday' || dayOfWeek == 'Sunday') {
        specialGreeting = "${l10n.let_start_week_strong}";
      } else if (dayOfWeek == 'Friday') {
        specialGreeting = "${l10n.happy_friday}";
      } else if (dayOfWeek == 'Saturday') {
        specialGreeting = "${l10n.have_a_great_weekend}";
      }

      return '$greeting, ${userName.split(' ')[0]}${specialGreeting.isNotEmpty ? '\n$specialGreeting' : ''}';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md)
          .copyWith(top: KSizes.defaultSpace),
      child: token != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getGreeting(),
                  key: ValueKey<String>(getGreeting()),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                ),
                SizedBox(height: KSizes.xs),
                Text(
                  "${l10n.apply_job_without_cost}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: KColors.black,
                        height: 1.5,
                      ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${l10n.discover_and_apply_to_jobs}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  "${l10n.free}.",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: KColors.primary,
                      ),
                ),
                Text(
                  "${l10n.more_than_people_found_jobs}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: KColors.black,
                      ),
                ),
              ],
            ),
    );
  }
}
