// ignore_for_file: non_constant_identifier_names, constant_identifier_names

//import 'dart:convert';

import 'dart:math';

import '../Angle.dart';
import '../Side.dart';
import '../Geometry.dart';
import '../../Common/Misc.dart';

//typedef Match(Side? s, Angle? a);
//typedef One = bool;
//typedef SineLaw(LDS known, Primitive unknown);

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
}

enum Known
{
	Neither,
	Side,
	Angle,
	Both
}

class Triangle extends Polygon
{
	static Primitive2D LawOfSines(LDS known, Primitive2D unknown)
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

	static Radian _FAngle(LDS known, Side unknown) //find angle
	{
		return Radian(known.angle * unknown.length, true);
	}

	static Side _FSide(LDS known, Angle unknown)
	{
		if (unknown is Radian)
		{
			return Side(known.side * unknown.Sine());
		}
		if (unknown is Degree)
		{
			return Side(known.side * unknown.Convert().Sine());
		}
		throw 'LawOSine has recieved what should be an impossible (abstract) input';
	}

	Triangle Solve
	(
		Side? pa, Side? pb, Side? pc, 
		Angle? PA, Angle? PB, Angle? PC
	)
	{
		//given
		final dynamic GivenZ = ((pa != null) && (PA != null)) ? LDS(pa, PA) : false;
		final dynamic GivenY = ((pb != null) && (PB != null)) ? LDS(pb, PB) : false;
		final dynamic GivenX = ((pc != null) && (PC != null)) ? LDS(pc, PC) : false;

		//only check each for null once
		//b is for bool
		final bool bpb = pb != null;
		final bool bpc = pc != null;
		final bool bpa = pa != null;
		//so is B
		final bool BPA = PA != null;
		final bool BPB = PB != null;
		final bool BPC = PC != null;

		//Ternary madness
		List<Known> Saber = [];
		//final Known zGiven = XOR(bpa, BPA) ?
		// (bpa ? Known.Side : Known.Angle ) : (BPA ? Known.Both : Known.Neither);

		//final Known yGiven = XOR(bpb, BPB) ?
		 //(bpb ? Known.Side : Known.Angle ) : (BPB ? Known.Both : Known.Neither);
		
		//final Known xGiven = XOR(bpc, BPC) ?
		 //(bpc ? Known.Side : Known.Angle ) : (BPC ? Known.Both : Known.Neither);
		Saber[0] = XOR(bpa, BPA) ?
			(bpa ? Known.Side : Known.Angle) : (BPA ? Known.Both : Known.Neither);
		Saber[1] = XOR(bpb, BPB) ?
			(bpb ? Known.Side : Known.Angle) : (BPB ? Known.Both : Known.Neither);
		Saber[2] = XOR(bpc, BPC) ?
			(bpc ? Known.Side : Known.Angle) : (BPC ? Known.Both : Known.Neither);

		int angles = 0;
		int sides = 0;
		int pair = 0;
		int neither = 0;

			for (int ind = 0 ; ind <= 2; ind ++)
			{
				switch (Saber[ind])
				{
					case Known.Side:
					{
						sides++;
					} break;
					case Known.Angle:
					{
						angles++;
					}break;
					case Known.Both:
					{
						pair++;
						sides++;
						angles++;

						/*switch (ind)
						{
							case 0:
							{
								pair = pair + "a";
							} break;
							case 1:
							{
								pair = pair + "b"
							} break;
							case 2:
							{
								pair = pair + "c";
							}

						}*/
					}break;
				  case Known.Neither: 
					{
						neither++;
					}break;
				}

				if (pair >= 1)
				{}
				else if (sides >= 2)
				{}
				else if (angles >= 2)
				{}

			}

		return Triangle();
	}
}
