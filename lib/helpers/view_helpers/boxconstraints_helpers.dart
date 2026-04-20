import 'package:flutter/material.dart';

extension AppBoxConstraint on BoxConstraints {
  static const BoxConstraints fullScreen = BoxConstraints(
    minWidth: double.infinity,
    minHeight: double.infinity
  );
}