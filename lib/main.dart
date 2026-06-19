import 'package:flutter/material.dart';

import 'app.dart';
import 'core/dependency_injection/injection_container.dart';

void main() {
  final di = InjectionContainer();
  runApp(PetShopApp(di: di));
}
