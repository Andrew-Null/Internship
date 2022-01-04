// ignore_for_file: non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'dart:math';

typedef float = double; //to reduce errors and frustration 

abstract class Angle
{
  static const AR = pi / 360; //to radian
  static const AD = 360/ pi; // to degrees
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

/*class RadianSin extends Angle
{
  late double value;

  RadianSin(double v)
  {
    value = v * pi;
  }
}

class RadianCon extends Angle
{
  late double value;

  RadinCon(double v)
  {
    value = v;
  }

  Degree get Convert()
}*/

class Degree extends Angle
{
  late double value;
  //8:45 - 8:51

  Degree(double v)
  {
    value = v;
  }

  Radian get Convert
  {
    return Radian(value * Angle.AR, true);
  }

}