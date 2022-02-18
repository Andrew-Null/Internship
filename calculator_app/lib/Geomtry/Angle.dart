// ignore_for_file: non_constant_identifier_names, constant_identifier_names, camel_case_types, file_names

import 'dart:math';
import 'package:epics_app/Geomtry/Side.dart';
import '../Common/Misc.dart';
import 'Geometry.dart';

typedef float = double; //to reduce pointless errors and frustration 

abstract class Angle extends Primitive2D
{
	static const AR = pi / 360; //to radian
	static const AD = 360/ pi; // to degrees

	//num Sine();
	//num Cosine();
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
		return sin(value * Angle.AR) * Angle.AD;
	}

	num Cosine()
	{
		return cos(value * Angle.AR) * Angle.AD;
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

		if ( XOR(XOR(AA, AB), XOR(BA, BB)))
		{
			double ian = AA ? ( atan2(A.B.Y - A.A.Y, A.B.X - A.A.X) - atan2(B.B.Y - A.A.Y, B.B.X - A.A.X) ) : 0.0;
			ian = AB ? ( atan2(A.B.Y - A.A.Y, A.B.X - A.A.X) - atan2(B.A.Y - A.A.Y, B.A.X - A.A.X) ) : ian;
			ian = BA ? ( atan2(A.A.Y - A.B.Y, A.A.X - A.B.X) - atan2(B.A.Y - A.B.Y, B.A.X - A.B.X) ) : ian;
			ian = BB ? ( atan2(A.A.Y - A.B.Y, A.A.X - A.B.X) - atan2(B.A.Y - A.B.Y, B.A.X - A.B.X) ) : ian;
			rad = Radian(ian, true);
			deg = rad.Convert();
		}
		else
		{
			rad = Radian(0, true);
			deg = Degree(0);
			valid = false;
		}
	}
}