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

  late List<Side.Side> _TempS;
  late List<Ang.Angle> _TempA;

  //Rotate
  void RotAaB()
  {
    _TempS = [a, b, c];
     a = _TempS[2];
     b = _TempS[0];
     c = _TempS[1];

    _TempA = [A, B, C];
    A = _TempA[2];
    B = _TempA[0];
    C = _TempA[1];
  }

  void RotAaC()
  {
    _TempS = [a, b, c];
    a = _TempS[1];
    b = _TempS[2];
    c = _TempS[0];

    _TempA = [A, B, C];
    A = _TempA[1];
    B = _TempA[2];
    C = _TempA[0];
  }

  void Mirror()
  {
    _TempS = [a,b,c];
    b = _TempS[2];
    c = _TempS[1];

    _TempA = [A, B, C];
    B = _TempA[2];
    C = _TempA[1];
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

  static Triangle LDC(Side.Side a, Side.Side b, Ang.Angle C)
  {
    Side.Side c = Laws.LDC(a, b, C) as Side.Side;
    return SSS(a, b, c);
  }

  void ConvertAngle(bool TR) //to radian
  {
    if (TR)
    {
      A = A is Ang.Degree ?(A as Ang.Degree).Convert(): A;
      B is Ang.Degree ? B = (B as Ang.Degree).Convert() : B;
      C is Ang.Degree ? C = (C as Ang.Degree).Convert() : C;
    }
    else
    {
      A = A is Ang.Radian ?(A as Ang.Radian).Convert(): A;
      B is Ang.Radian ? B = (B as Ang.Radian).Convert() : B;
      C is Ang.Radian ? C = (C as Ang.Radian).Convert() : C;
    }
  }
}