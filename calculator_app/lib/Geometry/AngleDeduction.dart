// ignore_for_file: non_constant_identifier_names

import 'Angle.dart';
import 'dart:math';

Angle AngDeduction(Angle Uno, Angle Dos)
{
	if (Uno is Degree && Dos is Degree)
	{
		return Degree(180.0 - (Uno.value + Dos.value));
	}
	else if (Uno is Radian && Dos is Radian)
	{
		return Radian
		(
			pi - (Uno.value + Dos.value),
			true
		);
	}
	else if (Uno is Radian && Dos is Degree)
	{
		return Radian
		(
			pi - (Uno.value + Dos.Convert().value),
			true
		);
	}
	else if (Uno is Degree && Dos is Radian)
	{
		return Degree(180 - (Uno.value + Dos.Convert().value));
	}
	throw "AngDeduction(): Has recieved and abstract angle class";
}