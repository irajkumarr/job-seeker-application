import 'package:flutter/material.dart';
import 'package:frontend/features/dashboard/widgets/login_redirect.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:get_storage/get_storage.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final box = GetStorage();
    final String? token = box.read("token");
    if (token == null) {
      return LoginRedirect(isMatchedJobs: false,);
    }
    return SizedBox();
  }
}
