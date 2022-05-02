// ignore_for_file: unnecessary_cast

import "dart:math";

import '../Geometry.dart' as Geo;
import '../Angle.dart' as Ang;
import '../Side.dart' as Side;

class LDS //law de sine
{
	late double angle;
	late double side;

	LDS(Side.Side s, Ang.Angle A)
	{
		if (A is Ang.Radian)
		{
			side = s.length / A.Sine();
			angle = A.Sine() / s.length;
		}
		else
		{
			num rad = Ang.Radian((A as Ang.Degree).value * Ang.Angle.AR, true).Sine();
			angle =  rad / s.length;
			side = s.length / rad;
		}
	}

	Ang.Radian GetAngle(Side.Side s)
	{
		return Ang.Radian(asin(angle * s.length), true);
	}

	Side.Side GetSide(Ang.Angle a)
	{
		return Side.Side(side * (a is Ang.Radian ? a.Sine() : (a is Ang.Degree ? a.Convert().Sine() : throw "GetSide has recieved an abstract angle class")));
	}
}

Geo.Primitive2D LDC(Side.Side a, Side.Side b, Geo.Primitive2D c) //law de cosines
{
  if (c is Side.Side)
  {
    final num numerator = pow(a.length,2) + pow(b.length,2) - pow((c as Side.Side).length,2);
    final num denominator = 2*a.length*b.length;
    return Ang.Radian(acos(numerator/denominator),true);
  }
  else if (c is Ang.Degree)
  {
    final num Squared = pow(a.length,2) + pow(b.length,2);
    final num Multiple = 2 * a.length * b.length * (c as Ang.Degree).Cosine();
		return Side.Side(sqrt(Squared - Multiple));
  }
  else if (c is Ang.Radian)
  {
		final num Squared = pow(a.length,2) + pow(b.length,2);
		final num Multiple = 2 * a.length * b.length * (c as Ang.Radian).Cosine();
		return Side.Side(sqrt(Squared - Multiple));
  }
  throw "LDC has recieved either an abstract angle class or a point class";
}
