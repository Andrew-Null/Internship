// ignore_for_file: non_constant_identifier_names, constant_identifier_names, camel_case_types, file_names

import 'dart:math';
//import '../Common/Misc.dart';
import 'Geometry.dart';
import 'Side.dart';

typedef float = double; //to reduce pointless errors and frustration 

abstract class Angle extends Primitive2D
{
  static const AR = pi / 180; //to radian
  static const AD = 180/ pi; // to degrees
}

class Radian extends Angle
{
	late double value;

	Radian(double v, bool HasPi)
	{
		value = v * (HasPi ? 1 : pi);
	}

	Degree Convert()
	{
		return Degree(value * Angle.AD);
	}

	num Sine()
	{
		return sin(value);
	}
	num Cosine()
	{
		return cos(value);
	}

}

class Degree extends Angle
{
	late double value;

	Degree(double v)
	{
		value = v;
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
		return cos(Convert().value);
	}

}
