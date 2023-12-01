import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';

Future<void> saveDistanceToCache(String key, double value) async
{
  final file = await DefaultCacheManager().getSingleFile(key);
  await file.writeAsString(json.encode(value));
}

Future<double> getDistanceFromCache(String key) async {
  final file = await DefaultCacheManager().getSingleFile(key);
  if (await file.exists())
  {
    final jsonStr = await file.readAsString();
    final double value = json.decode(jsonStr);
    return value;
  } else
  {
    return 0.0;
  }
}