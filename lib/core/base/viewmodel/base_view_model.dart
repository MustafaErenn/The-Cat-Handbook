import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BuildContext? contextFromViewModel;

  void setContext(BuildContext context);
  void init();
}
