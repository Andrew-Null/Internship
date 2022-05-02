// ignore_for_file: non_constant_identifier_names, constant_identifier_names, library_prefixes

import 'dart:math';

import '../Angle.dart' as Ang;
import '../Side.dart' as Side;
import '../Geometry.dart' as Geo;
import '../../Common/Misc.dart' as Misc;
import '../AngleDeduction.dart' as AD;
import 'Laws.dart' as Laws;

enum Known
{
	Neither,
	Side,
	Angle,
	Both
}

class Triangle extends Geo.Polygon
{
	late Side.Side a;
	late Side.Side b;
	late Side.Side c;

	late Ang.Angle A;
	late Ang.Angle B;
	late Ang.Angle C;

	static Triangle Solve
	(
		Side.Side? pa, Side.Side? pb, Side.Side? pc, 
		Ang.Angle? PA, Ang.Angle? PB, Ang.Angle? PC
	)
	{
		Triangle ret = Triangle();
		//given
		//final dynamic GivenZ = ((pa != null) && (PA != null)) ? Laws.LDS(pa, PA) : false;
		//final dynamic GivenY = ((pb != null) && (PB != null)) ? Laws.LDS(pb, PB) : false;
		//final dynamic GivenX = ((pc != null) && (PC != null)) ? Laws.LDS(pc, PC) : false;

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
		Saber[0] = bpa ^ BPA ?
			(bpa ? Known.Side : Known.Angle) : (BPA ? Known.Both : Known.Neither);
		Saber[1] = bpb ^ BPB ?
			(bpb ? Known.Side : Known.Angle) : (BPB ? Known.Both : Known.Neither);
		Saber[2] = bpc ^ BPC ?
			(bpc ? Known.Side : Known.Angle) : (BPC ? Known.Both : Known.Neither);

		const A = 0;
		const B = 1;
		const C = 2;

		int angles = 0;
		int sides = 0;
		int pair = 0;
		int neither = 0;

			for (int ind = 0 ; ind <= 2; ind++)
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
					}break;
					case Known.Neither: 
					{
						neither++;
					}break;
				}
			}
	
// Law of Sine Time
//What to do about ambigous case
//http://jwilson.coe.uga.edu/EMT668/EMAT6680.2001/Mealor/EMAT%206700/law%20of%20sines/Law%20of%20Sines%20ambiguous%20case/lawofsinesambiguouscase.html#:~:text=Law%20of%20Sines%2D%2DAmbiguous%20Case&text=For%20those%20of%20you%20who,of%20those%20angles%20(SSA).
				if (pair >= 1 && (sides >= 2 || angles >= 2))
				{
					for (int fv = 0 ; fv <= 3 ; fv++)
					{
						if (Saber[A] == Known.Both)
						{
							ret.a = pa as Side.Side;
							ret.A = PA as Ang.Angle;
							Laws.LDS lds = Laws.LDS(ret.a, ret.A);
							if (Saber[B] == Known.Angle || Saber[B] == Known.Side)
							{
								if (Saber[B] == Known.Angle)
								{
									ret.b = pb as Side.Side;
									ret.B = lds.GetAngle(ret.b);
									sides++;
									pair++;
								}
								else 
								{
									ret.B = PB as Ang.Angle;
									ret.b = lds.GetSide(ret.B);
									angles++;
									pair++;
								};
							}
							if (Saber[C] == Known.Angle || Saber[C] == Known.Side)
							{
								if (Saber[C] == Known.Angle)
								{
									ret.c = pc as Side.Side;
									ret.C = lds.GetAngle(ret.c);
									sides++;
									pair++;
								}
								else 
								{
										ret.C = PC as Ang.Angle;
										ret.c = lds.GetSide(ret.C);
										angles++;
										pair++;
								};
							}
						}
						if (Saber[B] == Known.Both)
						{
							ret.b = pb as Side.Side;
							ret.B = PB as Ang.Angle;
							Laws.LDS lds = Laws.LDS(ret.b, ret.B);
							if (Saber[A] == Known.Angle || Saber[A] == Known.Side)
							{
								if (Saber[A] == Known.Angle) 
								{
									ret.a = pa as Side.Side;
									ret.A = lds.GetAngle(ret.a);
									neither--;
									sides++;
									pair++;
								} 
								else
								{
									ret.A = PA as Ang.Angle;
									ret.a = lds.GetSide(ret.A);
									neither--;
									angles++;
									pair++;
								};
							}
							if (Saber[C] == Known.Angle || Saber[C] == Known.Side)
							{
								if (Saber[C] == Known.Angle)
								{
									ret.c = pc as Side.Side;
									ret.C = lds.GetAngle(ret.c);
									neither--;
									sides++;
									pair++;
								}
								else 
								{
									ret.C = PC as Ang.Angle;
									ret.c = lds.GetSide(ret.C);
									neither--;
									angles++;
									pair++;
								};
							}
						}
						if (Saber[C] == Known.Both)
						{
							ret.c = pc as Side.Side;
							ret.C = PC as Ang.Angle;
							Laws.LDS lds = Laws.LDS(ret.c, ret.C);
							if (Saber[A] == Known.Angle || Saber[A] == Known.Side)
							{
								if (Saber[A] == Known.Angle)
								{
									ret.a = pa as Side.Side;
									ret.A = lds.GetAngle(ret.a);
									neither--;
									sides++;
									pair++;
								} 
								else 
								{
									ret.A = PA as Ang.Angle;
									ret.a = lds.GetSide(ret.A);
									neither--;
									angles++;
									pair++;
								};
							}
							if (Saber[B] == Known.Angle || Saber[B] == Known.Side)
							{
								if (Saber[B] == Known.Angle)
								{
									ret.b = pb as Side.Side;
									ret.B = lds.GetAngle(ret.b);
									neither--;
									sides++;
									pair++;
								}
								else 
								{
									ret.B = PB as Ang.Angle;
									ret.b = lds.GetSide(ret.B);
									neither--;
									angles++;
									pair++;
								};
							}
						}
					}
// Angle Deduction
			if (angles == 2)
			{
				if (PA != null && PB != null)
				{
					ret.C = AD.AngDeduction(PA, PB);
				}
				else if (PA != null && PC != null)
				{
					ret.B = AD.AngDeduction(PA, PC);
				}
				else if (PB != null && PC != null)
				{
					ret.A = AD.AngDeduction(PB, PC);
				}
			}

//law of cosine
// there is no escape
//https://yoshiwarabooks.org/trig/The-Law-of-Cosines.html#:~:text=If%20we%20use%20the%20Law%20of%20Cosines%20to%20find%20a,solutions%2C%20there%20are%20two%20triangles.
			
		}
	return ret;
	}
}