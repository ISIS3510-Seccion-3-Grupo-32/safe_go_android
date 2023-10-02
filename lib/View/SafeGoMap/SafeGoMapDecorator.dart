import 'package:flutter/cupertino.dart';

import 'SafeGoMap.dart';

abstract class SafeGoMapDecorator extends SafeGoMap {
  final SafeGoMap map;
  Widget decorate(SafeGoMap map);
  const SafeGoMapDecorator(this.map, {super.key});
}
