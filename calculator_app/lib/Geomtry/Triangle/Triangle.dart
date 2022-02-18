// ignore_for_file: non_constant_identifier_names

import '../Angle.dart';
import '../Side.dart';
import '../Geometry.dart';
import '../../Common/Misc.dart';

//typedef Match(Side? s, Angle? a);
typedef One = bool;
//typedef SineLaw = (LDS known, Primitive unknown);

class LDS //law de sine
{
  late double angle;
  late double side;
}

LDS Valid(Side s, Angle A)
{
  LDS ret = LDS();
  if (A is Radian)
  {
    ret.angle = s.length / A.Sine();
    ret.side = A.Sine() / s.length;
  }
  else
  {
    num rad = Radian((A as Degree).value * Angle.AR, true).Sine();
    ret.side =  rad / s.length;
    ret.side = s.length / rad;
  }
  return ret;
}



class Triangle extends Polygon
{
  Primitive LawOfSines(LDS known, Primitive unknown)
  {
    if (unknown is Side) 
    {
      return _FAngle(known, unknown);
    }
    else if (unknown is Angle)
    {
      return _FSide(known, unknown);
    }
    throw 'LawOfSines has recieved a Point Class';
  }

  Radian _FAngle(LDS known, Side unknown) //find angle
  {
    return Radian(known.angle * unknown.length, true);
  }

  Side _FSide(LDS known, Angle unknown)
  {
    if (unknown is Radian)
    {
      return Side(known.side * unknown.Sine());
    }
    if (unknown is Degree)
    {
      return Side(known.side * unknown.Convert().Sine());
    }
    throw 'LawOSine has recieved what should be an impossible input';
  }

  void TempTriangle //constructor in progress
  (
    Side? a, Side? b, Side? c, 
    Angle? A, Angle? B, Angle? C
  )
  {
    //given
    final dynamic GivenZ = ((a != null) && (A != null)) ? Valid(a, A) : false;
    final dynamic GivenY = ((b != null) && (B != null)) ? Valid(b, B) : false;
    final dynamic GivenX = ((c != null) && (C != null)) ? Valid(c, C) : false;

    final One zGiven = XOR((a != null), (A != null));
    final One yGiven = XOR((b != null), (B != null));
    final One xGiven = XOR((c != null), (C != null));
  }
}