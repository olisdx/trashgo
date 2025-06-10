import 'package:flutter/material.dart';

abstract class MQ {
  /// width
  static double w(BuildContext context) => MediaQuery.sizeOf(context).width;

  /// height
  static double h(BuildContext context) => MediaQuery.sizeOf(context).height;

  /// bottom padding
  static double bp(BuildContext context) =>
      MediaQuery.of(context).viewPadding.bottom;

  /// orientation potrait
  static bool isPortait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  /// orientation check
  static Orientation orientation(BuildContext context) =>
      MediaQuery.of(context).orientation;
}
