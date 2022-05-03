// ignore_for_file: non_constant_identifier_names, constant_identifier_names, library_prefixes, file_names


import '../Angle.dart' as Ang;
import '../Side.dart' as Side;
import '../Geometry.dart' as Geo;
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

  //'constructors'

  static Triangle AAS(Ang.Angle A, Ang.Angle B, Side.Side a)
  {
    Triangle ret = Triangle();
    Laws.LDS SLaw = Laws.LDS(a, A);

    Ang.Angle C = AD.AngDeduction(A, B);

    ret.A = A;
    ret.B = B;
    ret.C = C;
    ret.a = a;
    ret.b = SLaw.GetSide(B);
    ret.c = SLaw.GetSide(C);

    return ret;
  }
}