class RtmValues {
  RtmValues({
    required this.urlScheme,
    required this.baseDomain,
    required this.supabaseAnonKey,
    required this.hiveDBKey,
    required this.primaryHiveDBKey,
  });

  final String urlScheme;
  final String supabaseAnonKey;
  final String hiveDBKey;
  final String primaryHiveDBKey;
  final String baseDomain;
}

class RtmConfig {
  factory RtmConfig({required RtmValues values}) {
    return _instance ??= RtmConfig._internal(values);
  }

  RtmConfig._internal(this.values);

  final RtmValues values;
  static RtmConfig? _instance;

  static RtmConfig? get instance => _instance;
}
