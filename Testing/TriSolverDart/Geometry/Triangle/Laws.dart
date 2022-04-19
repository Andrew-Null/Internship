// ignore_for_file: unnecessary_cast

import "dart:math";

import '../Geometry.dart';
import '../Angle.dart';
import '../Side.dart';

class LDS //law de sine
{
	late double angle;
	late double side;

	LDS(Side s, Angle A)
	{
		if (A is Radian)
		{
			side = s.length / A.Sine();
			angle = A.Sine() / s.length;
		}
		else
		{
			num rad = Radian((A as Degree).value * Angle.AR, true).Sine();
			angle =  rad / s.length;
			side = s.length / rad;
		}
	}

	Radian GetAngle(Side s)
	{
		return Radian(asin(angle * s.length), true);
	}

	Side GetSide(Angle a)
	{
		return Side(side * (a is Radian ? a.Sine() : (a is Degree ? a.Convert().Sine() : throw "GetSide has recieved an abstract angle class")));
	}
}

Primitive2D LDC(Side a, Side b, Primitive2D c) //law de cosines
{
  if (c is Side)
  {
    final num numerator = pow(a.length,2) + pow(b.length,2) - pow((c as Side).length,2);
    final num denominator = 2*a.length*b.length;
    return Radian(acos(numerator/denominator),true);
  }
  else if (c is Degree)
  {
    final num Squared = pow(a.length,2) + pow(b.length,2);
    final num Multiple = 2 * a.length * b.length * (c as Degree).Cosine();
		return Side(sqrt(Squared - Multiple));
  }
  else if (c is Radian)
  {
		final num Squared = pow(a.length,2) + pow(b.length,2);
		final num Multiple = 2 * a.length * b.length * (c as Radian).Cosine();
		return Side(sqrt(Squared - Multiple));
  }
  throw "LDC has recieved either an abstract angle class or a point class";
}
