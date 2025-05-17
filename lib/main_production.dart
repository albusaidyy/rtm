import 'package:rtm/app/app.dart';
import 'package:rtm/bootstrap.dart';
import 'package:rtm/utils/rtm_config.dart';

Future<void> main() async {
  // change the values to the correct values for the development environment
  RtmConfig(
    values: RtmValues(
      urlScheme: 'https',
      baseDomain: 'ilepmczykpyzxpuqgtxa.supabase.co',
      supabaseAnonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.'
          'eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlsZXBtY3p5a3B5enhwdXFndHhhIiwicm9s'
          'ZSI6ImFub24iLCJpYXQiOjE3NDc0Nzk5OTAsImV4cCI6MjA2MzA1NTk5MH0.'
          '-WeFVY8Wwg0_9X1bkvQwnktGLc99qkEfnMevDtbZA8Q',
      hiveDBKey: 'rtm_2050',
      primaryHiveDBKey: 'rtm_pr2050',
    ),
  );
  await bootstrap(() => const App());
}
