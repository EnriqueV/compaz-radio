import 'package:launchdarkly_flutter_client_sdk/launchdarkly_flutter_client_sdk.dart';
import 'package:uuid/uuid.dart';

class LaunchDarklyService {
  static final LaunchDarklyService _instance = LaunchDarklyService._internal();
  LDClient? _client;

  factory LaunchDarklyService() {
    return _instance;
  }

  LaunchDarklyService._internal();

  Future<void> initialize() async {
    var uuid = Uuid();
    final config = LDConfig(
      'mob-92963541-3a9d-4079-b9ef-c193a0e55c6b',
      AutoEnvAttributes.enabled,
    );
    final context = LDContextBuilder().kind('user', uuid.v4()).build();

    _client = LDClient(config, context);

    await _client?.start().timeout(Duration(seconds: 5));
  }

  LDClient get client {
    if (_client == null) {
      throw Exception('LaunchDarkly client not initialized');
    }
    return _client!;
  }
}
