// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'Angle.dart' as Ang;
import 'dart:math' as DMath;

Ang.Angle AngDeduction(Ang.Angle Uno, Ang.Angle Dos)
{
	if (Uno is Ang.Degree && Dos is Ang.Degree)
	{
		return Ang.Degree(180.0 - (Uno.value + Dos.value));
	}
	else if (Uno is Ang.Radian && Dos is Ang.Radian)
	{
		return Ang.Radian
		(
			DMath.pi - (Uno.value + Dos.value),
			true
		);
	}
	else if (Uno is Ang.Radian && Dos is Ang.Degree)
	{
		return Ang.Radian
		(
			DMath.pi - (Uno.value + Dos.Convert().value),
			true
		);
	}
	else if (Uno is Ang.Degree && Dos is Ang.Radian)
	{
		return Ang.Degree(180 - (Uno.value + Dos.Convert().value));
	}
	throw "AngDeduction(): Has recieved and abstract angle class";
}