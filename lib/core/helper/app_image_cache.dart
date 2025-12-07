
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppImageCache {
  static final instance = CacheManager(
    Config(
      "permanentImageCache",
      stalePeriod: const Duration(days: 365), // سنة كاملة
      maxNrOfCacheObjects: 500,               // عدد الصور
    ),
  );
}
