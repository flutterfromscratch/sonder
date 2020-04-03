import 'package:flutter/services.dart';

class AssetLoader {
  Future<ByteData> load(String key) => rootBundle.load(key);
}
