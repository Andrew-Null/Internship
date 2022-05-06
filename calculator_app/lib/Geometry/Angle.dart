// ignore_for_file: non_constant_identifier_names, constant_identifier_names, camel_case_types, file_names, library_prefixes

import 'dart:math' as DMath;
import 'Geometry.dart' as Geo;

abstract class Angle extends Geo.Primitive2D
{
  late double value;
  static const AR = DMath.pi / 180; //to radian
  static const AD = 180/ DMath.pi; // to degrees
}

class Radian extends Angle
{

	Radian(double v, bool HasPi)
	{
		value = v * (HasPi ? 1 : DMath.pi);
    while (value > (2 * DMath.pi))
    {value -= 2 * DMath.pi;}
    while (value < 0)
    {value += 2 * DMath.pi;}
	}

	Degree Convert()
	{
		return Degree(value * Angle.AD);
	}

	num Sine()
	{
		return DMath.sin(value);
	}
	num Cosine()
	{
		return DMath.cos(value);
	}

}

class Degree extends Angle
{
	Degree(double v)
	{
		value = v;
    while (value > 360)
    {value -= 360;}
    while (value < 0)
    {value += 360;}
	}

	Radian Convert()
	{
		return Radian(value * Angle.AR, true);
	}

	num Sine()
	{
		return Convert().Sine();
	}

	num Cosine()
	{
		return DMath.cos(Convert().value);
	}

}
