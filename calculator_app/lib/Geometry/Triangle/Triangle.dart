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

  //Rotate
  void RotAaB()
  {
    Side.Side TempS = c;
    c = b;
    b = a;
    a = TempS;

    Ang.Angle TempA = C;
    B = A;
    C = B;
    A = TempA;
  }

  void RotAaC()
  {
    Side.Side TempS = b;
    b = c;
    c = a;
    a = TempS;

    Ang.Angle TempA = B;
    B = C;
    C = A;
    A = TempA;

  }

  //'constructors'
  Triangle
  (
    Side.Side pa, Side.Side pb, Side.Side pc, 
    Ang.Angle PA, Ang.Angle PB, Ang.Angle PC
  )
  {
    a = pa;
    b = pb;
    c = pc;

    A = PA;
    B = PB;
    C = PC;
  }

  static Triangle AAS(Ang.Angle A, Ang.Angle B, Side.Side a)
  {
    final SLaw = Laws.LDS(a, A);
    final C = AD.AngDeduction(A, B);

    return Triangle
    (
      a, 
      SLaw.GetSide(B), 
      SLaw.GetSide(C), 
      A, B, C
    );
  }

  static Triangle ASA(Ang.Angle A, Side.Side c, Ang.Angle B)
  {
    final C = AD.AngDeduction(A, B);
    final SLaw = Laws.LDS(c, C);

    return Triangle
    (
      SLaw.GetSide(A), SLaw.GetSide(B), c,
      A, B, C
    );
  }

  static Triangle SSA(Side.Side a, Side.Side c, Ang.Angle A)
  {
    final Law = Laws.LDS(a, A);
    final C = Law.GetAngle(c);
    final B = AD.AngDeduction(A, C);
    return Triangle
    (
      a,Law.GetSide(B),c,
      A,B,C
    );
  }

  static Triangle SAS(Side.Side a, Ang.Angle B, Side.Side c)
  {
    final b = Laws.LDC(a, c, B) as Side.Side;
    final law = Laws.LDS(b,B);

    return Triangle(a, b, c, law.GetAngle(a), B, law.GetAngle(c));
  } 
  static Triangle SSS(Side.Side a, Side.Side b, Side.Side c)
  {
    return Triangle(a, b, c, 
    Laws.LDC(a, b, c) as Ang.Radian, 
    Laws.LDC(a, c, b) as Ang.Radian, 
    Laws.LDC(c, b, a) as Ang.Radian);
  }
}