enum FlavorType {
  dev,
  prod,
  free,
  paid,
}

/// Universal Flavor Configuration Singleton
class FlavorConfig {
  final FlavorType flavor;
  final String appTitle;
  final String baseUrl;

  static FlavorConfig? _instance;

  FlavorConfig({
    required this.flavor,
    required this.appTitle,
    required this.baseUrl,
  }) {
    _instance = this;
  }

  static FlavorConfig get instance {
    return _instance ??
        FlavorConfig(
          flavor: FlavorType.dev,
          appTitle: 'App (Dev)',
          baseUrl: 'https://dev-api.example.com',
        );
  }

  static bool get isDev => instance.flavor == FlavorType.dev;
  static bool get isProd => instance.flavor == FlavorType.prod;
  static bool get isFree => instance.flavor == FlavorType.free;
  static bool get isPaid => instance.flavor == FlavorType.paid;
}

