import 'package:rtm/app/app.dart';
import 'package:rtm/bootstrap.dart';
import 'package:rtm/utils/rtm_config.dart';

Future<void> main() async {
  // change the values to the correct values for the development environment
  RtmConfig(
    values: RtmValues(
      urlScheme: 'https',
      baseDomain: 'kqgbftwsodpttpqgqnbh.supabase.co',
      supabaseAnonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYm'
          'FzZSIsInJlZiI6ImtxZ2JmdHdzb2RwdHRwcWdxbmJoIiwicm9sZSI6ImFub24'
          'iLCJpYXQiOjE3NDU5ODk5OTksImV4cCI6MjA2MTU2NTk5OX0.rwJSY4bJaNdB'
          '8jDn3YJJu_gKtznzm-dUKQb4OvRtP6c',
      hiveDBKey: 'rtm_staging_2051',
      primaryHiveDBKey: 'rtm_staging_pr2051',
    ),
  );
  await bootstrap(() => const App());
}
