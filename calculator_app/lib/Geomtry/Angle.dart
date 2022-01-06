// ignore_for_file: non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'dart:math';

import 'package:epics_app/Geomtry/Side.dart';

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

class AngleDeSideDePoint extends Angle
{
  late Radian rad;
  late Degree deg;
  bool valid = true;
  AngleDeSideDePoint(DePoints A, DePoints B)
  {
    bool AA = A.A.Equal(B.A); 
    bool AB = A.A.Equal(B.B); 
    bool BA = A.B.Equal(B.A); 
    bool BB = A.B.Equal(B.B); 
    if ( AA || AB || BA || BB)
    {
      double? ian = AA ? ( atan2(A.B.Y - A.A.Y, A.B.X - A.A.X) - atan2(B.B.Y - A.A.Y, B.B.X - A.A.X) ) : null;
      ian = AB ? ( atan2(A.B.Y - A.A.Y, A.B.X - A.A.X) - atan2(B.A.Y - A.A.Y, B.A.X - A.A.X) ) : ian;
      ian = BA ? ( atan2(A.A.Y - A.B.Y, A.A.X - A.B.X) - atan2(B.A.Y - A.B.Y, B.A.X - A.B.X) ) : ian;
      ian = BB ? ( atan2(A.A.Y - A.B.Y, A.A.X - A.B.X) - atan2(B.A.Y - A.B.Y, B.A.X - A.B.X) ) : ian;
      rad = Radian(ian as double, true);
      deg = rad.Convert;
    }
    else// (A.length == 0 || B.length == 0 )
    {
      rad = Radian(0, true);
      deg = Degree(0);
      valid = false;
    }
  }
}