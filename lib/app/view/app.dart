import 'package:flutter/material.dart';
import 'package:rtm/l10n/l10n.dart';
import 'package:rtm/utils/color_palette.dart';
import 'package:rtm/utils/rtm_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          color: AppTheme.kBackgroundColor,
          foregroundColor: AppTheme.kBlackColor,
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: RtmRouter.router,
    );
  }
}
