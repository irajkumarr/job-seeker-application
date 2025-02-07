import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/providers/app_providers.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/utils/theme/theme.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/l10n/language_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (_, child) {
          return MultiProvider(
            providers: AppProviders.providers,
            child: Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) {
              return MaterialApp.router(
                title: "Rojgari",
                debugShowCheckedModeBanner: false,
                locale: languageProvider.locale,
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('ne', ''),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: KAppTheme.lightTheme,
                routerConfig: AppRoutes().router,
              );
            }),
          );
        });
  }
}


