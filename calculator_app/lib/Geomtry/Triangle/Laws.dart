import 'dart:html';
import "dart:math";

import 'package:calculator_app/Geomtry/Geometry.dart';

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
			angle = s.length / A.Sine();
			side = A.Sine() / s.length;
		}
		else
		{
			num rad = Radian((A as Degree).value * Angle.AR, true).Sine();
			side =  rad / s.length;
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
    num numerator = pow(a.length,2) + pow(b.length,2) - pow(c.length,2);
    num denominator = 2*a.length*b.length;
    return Radian(acos(numerator/denominator),true);
  }
  else if (c is Degree)
  {

  }
  else if (c is Radian)
  {

  }
  throw "LDC has recieved either an abstract class or a point class";
}