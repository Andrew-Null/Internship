// ignore_for_file: non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'dart:math';

typedef float = double; //to reduce errors and frustration 

abstract class Angle
{
  static const AR = pi / 360; //to radian
  static const AD = 360 / pi; // to degrees
}

class Radian extends Angle
{
  late double value;

  Radian(double v, bool HasPi)
  {
    value = v * (HasPi ? 1 : pi);
  }

  Degree get Convert
  {
    return Degree(value * Angle.AD);
  }
}

class Degree extends Angle
{
  late double value;

  Degree(double v)
  {
    value = v;
  }

  Radian get Convert
  {
    return Radian(value * Angle.AR, true);
  }

}