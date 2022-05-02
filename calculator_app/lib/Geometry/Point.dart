// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, library_prefixes

import 'dart:math' as DMath;
import 'Geometry.dart' as Geo;

typedef float = double;

class Point extends Geo.Primitive2D
{
	late num X;
	late num Y;

	Point(num x, y)
	{
		X = x;
		Y = y;
	}

	bool Equal(Point other)
	{
		return other.X == X && other.Y == Y;
	}
}

num Distance(Point A, Point B)
{
	num AX = A.X;
	num AY = A.Y;
	
	num BX = B.X;
	num BY = B.Y;

	return DMath.sqrt(DMath.pow((AX - BX),2) + DMath.pow((AY- BY), 2));
}