 // ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, library_prefixes

import 'package:calculator_app/Geometry/Angle.dart' as Ang;
import 'package:calculator_app/Geometry/Side.dart' as Side;
import 'package:flutter/material.dart';
import '../MMenu.dart' as MM;
import '../../../Geometry/Triangle/Triangle.dart' as Tri;

import 'TriVars.dart' as TV;
import 'TriComponents.dart' as TC;


int Iterate(int val, TV.Contents mode)
{
  switch (mode)
  {
    case TV.Contents.None:
    {
      switch (val)
      {
        case 0: {return 5;}
        case 5: {return 1;}
        case 1: {return 3;}
        case 3: {return 2;}
        case 2: {return 4;}
        case 4: {return 0;}
        default: 
        {
          return Iterate((val % 6).abs(), mode);
        }
      }
    }
    case TV.Contents.Side:
    {
      switch(val)
      {
        case 1: {return 3;} case 5: {return 3;}
        case 2: {return 4;} case 3: {return 4;}
        case 0: {return 5;} case 4: {return 5;}
        default: 
        {
          return Iterate(val.abs() % 6, mode);
        }
      }
    }
    case TV.Contents.Angle:
    {
      switch(val)
      {
        case 0: {return 1;} case 5: {return 1;}
        case 1: {return 2;} case 3: {return 2;}
        case 2: {return 0;} case 4: {return 0;}
        default: 
        {
          return Iterate(val.abs() % 6, mode);
        }
      }
    }
  }
}

Tri.Triangle? TryASA(int A1, {int limit = 3})
{
  int S = Iterate(A1, TV.Contents.Side);
  int A2 = Iterate(S, TV.Contents.Angle);

  print("${TV.TxtControllers[A1].text} : ${TV.TxtControllers[S].text} : ${TV.TxtControllers[A2].text}");

  if (TV.Values[A1] is Ang.Angle && TV.Values[A2] is Ang.Angle && TV.Values[S] is Side.Side)
  {
    var tri = Tri.Triangle.ASA
    (
      TV.Values[A1] as Ang.Angle,
      TV.Values[S] as Side.Side,
      TV.Values[A2] as Ang.Angle
    );
    return tri;
  }

  if (limit > 1)
  {
    var irt = TryASA(Iterate(A1, TV.Contents.Angle), limit: limit - 1);
    if (irt is Tri.Triangle)
    {
      irt.RotAaB();
    }
    return irt;
  }
  return null;
}

Tri.Triangle? TryASS(int A, {int limit = 3})
{
  int S1 = Iterate(A, TV.Contents.Side);
  int S2 = Iterate(S1, TV.Contents.Side);
  
  print("${TV.TxtControllers[A].text} : ${TV.TxtControllers[S1].text} : ${TV.TxtControllers[S2].text}");

  Ang.Angle? a = TV.Values[A] as Ang.Angle?;
  Side.Side? s1 = TV.Values[S1] as Side.Side?;
  Side.Side? s2 = TV.Values[S2] as Side.Side?;

  if (a != null && s1 != null && s2 != null)
  {
    return Tri.Triangle.SSA(s2, s1, a);
  }
  if (limit > 1)
  {
    var tri = TryASS(Iterate(A, TV.Contents.Angle), limit: limit - 1);
    if (tri != null)
    {tri.RotAaB();}
    return tri;
  }
  return null;

}

Tri.Triangle? TrySAA()
{
  bool rot = true;
  Tri.Triangle? tri = _TrySAA(5, 1, 2);
  if (tri != null && rot) {tri.RotAaC(); rot = false;}
  tri ??= _TrySAA(5, 0, 2);
  if (tri != null && rot) {tri.Mirror(); tri.RotAaC(); rot = false;}
  tri ??= _TrySAA(4, 0, 1);
  if (tri != null && rot) {tri.RotAaB(); rot = false;}
  tri ??= _TrySAA(4, 2, 1);
  if (tri != null && rot) {tri.RotAaC(); rot = false;}
  tri ??= _TrySAA(3, 1, 0);
  if (tri != null && rot) {tri.Mirror(); rot = false;}
  tri ??= _TrySAA(3, 2, 0);

  return tri;
}
Tri.Triangle? _TrySAA(int S, int A1, int A2)
{

  print("${TV.TxtControllers[S].text} : ${TV.TxtControllers[A1].text} : ${TV.TxtControllers[A2].text}");

  Side.Side? s = TV.Values[S] as Side.Side?;
  Ang.Angle? a1 = TV.Values[A1] as Ang.Angle?;
  Ang.Angle? a2 = TV.Values[A2] as Ang.Angle?;

  if (s != null && a1 != null && a2 != null)
  {
    var tri = Tri.Triangle.AAS(a2, a1, s);
    if (tri != null)
    {
      tri.RotAaC();
    }
    return tri;
  }
  return null;

}

Tri.Triangle? TrySSA(int S1, {int limit = 3})
{
  int S2 = Iterate(S1, TV.Contents.Side);
  int A = Iterate(S2, TV.Contents.Angle);

  print("${TV.TxtControllers[S1].text} : ${TV.TxtControllers[S2].text} : ${TV.TxtControllers[A].text}");

  if (TV.Values[S1] is Side.Side && TV.Values[S2] is Side.Side && TV.Values[A] is Ang.Angle)
  {
    var tri = Tri.Triangle.SSA
    (
      TV.Values[S1] as Side.Side,
      TV.Values[S2] as Side.Side,
      TV.Values[A] as Ang.Angle
    );
    return tri;
  }

  if (limit > 1)
  {
    var tri = TrySSA(Iterate(S1, TV.Contents.Side), limit: limit - 1);
    if (tri is Tri.Triangle)
    {
      tri.RotAaB();
    }
    return tri;
  }
  return null;
}

Tri.Triangle? TrySAS(int S1, {int limit = 3})
{
  int A = Iterate(S1, TV.Contents.Angle);
  int S2 = Iterate(A, TV.Contents.Side);

  print("${TV.TxtControllers[S1].text} : ${TV.TxtControllers[A].text} : ${TV.TxtControllers[S2].text}");

  if (TV.Values[S1] != null && TV.Values[A]!= null && TV.Values[S2] != null)
  {
    var tri = Tri.Triangle.SAS
    (
      TV.Values[S1] as Side.Side,
      TV.Values[A] as Ang.Angle,
      TV.Values[S2] as Side.Side
    );
    return tri;
  }

  if (limit > 1)
  {
    var irt = TrySAS(Iterate(S1, TV.Contents.Side), limit: limit - 1);
    if (irt != null)
    {
      irt.RotAaB();
    }
    return irt;
  }
  return null;
}

Tri.Triangle? TrySSS()
{
  if (TV.Values[4] is Side.Side && TV.Values[3] is Side.Side && TV.Values[5] is Side.Side)
  {
    return Tri.Triangle.SSS(TV.Values[3] as Side.Side, TV.Values[4] as Side.Side, TV.Values[5] as Side.Side);
  }
}

Tri.Triangle? TryLDC({int S1 = 3, int S2 = 4, int A = 2, int limit = 3})
{
  Side.Side? s1 = TV.Values[S1] as Side.Side?;
  Side.Side? s2 = TV.Values[S2] as Side.Side?;
  Ang.Angle? a = TV.Values[A] as Ang.Angle?;

  print("${TV.TxtControllers[S1].text} : ${TV.TxtControllers[S2].text} : ${TV.TxtControllers[A].text}");

  if (s1 != null && s2 != null && a != null)
  {
    return Tri.Triangle.LDC(s1, s2, a);
  } 
  if (limit > 1)
  {
    var tri = TryLDC
    (
      S1: Iterate(S1, TV.Contents.Side),
      S2: Iterate(S2, TV.Contents.Side),
      A: Iterate(A, TV.Contents.Angle),
      limit: limit -1
    );
    if (tri != null)
    {
      tri.RotAaC();
    }
    return tri;
  }
  return null;
}

void TrySolve()
{
  //print("AAS");
  //Tri.Triangle? tri = TryAAS(0); //001

  print("ASA");
  Tri.Triangle? tri = TryASA(0); //010

  print("ASS");
  tri ??= TryASS(0); //011

  print("SAA");
  tri ??= TrySAA(); //100

  print("SAS");
  tri ??= TrySAS(5); //101

  print("SSA");
  tri ??= TrySSA(5); //110

  print("SSS");
  tri ??= TrySSS();  //111

  print("LDC");
  tri ??= TryLDC();

  if (tri != null)
  {
    tri.ConvertAngle(TV.RMode);
    TV.Values[TV.SyAIE.AA.index] = tri.A;
    TV.Values[TV.SyAIE.AB.index] = tri.B;
    TV.Values[TV.SyAIE.AC.index] = tri.C;
    TV.Values[TV.SyAIE.sa.index] = tri.a;
    TV.Values[TV.SyAIE.sb.index] = tri.b;
    TV.Values[TV.SyAIE.sc.index] = tri.c;
  }
}

void ToPrimitive2D(int intex)
{
  try
  {
    TV.Values[intex] = null;
    double val = double.parse(TV.TxtControllers[intex].text);
    if (intex <= 2)
    {
      if (TV.RMode)
      {
      	TV.Values[intex] = Ang.Radian(val,TV.HasPi[intex]);
      }
      else
      {
        TV.Values[intex] = Ang.Degree(val);
      }

    }
    else
    {
			TV.Values[intex] = Side.Side(val);
    }

  }
  catch(e)
  {
    TV.Values[intex] = null;
  }
}






Scaffold TriSolver(BuildContext context)
{
  for(int fv = 0; fv <= 5; fv++) {TV.Values[fv] = null;}
  for(int fv = 0; fv <= 5; fv++)
  {
    String txt =  TV.TxtControllers[fv].text;
    (TV.TxtControllers[fv].text.isEmpty) ? null : ToPrimitive2D(fv);
  }
  print(TV.Values);
  TrySolve();
  int fv = 0;
	return Scaffold(body: 
		Column(children:
			[
        (TV.RMode ?
        Row(children:
        [
          TC.SideTextBoxes(context),
          TC.AngleTextBoxes(context),
          TC.PiSwitches(context)
      	]):
        Row(children:
        [
          TC.SideTextBoxes(context),
          TC.AngleTextBoxes(context),
      	])
        ),
        Row(children: 
        [
          TC.SideOut(context),
          TC.AngleOut(context),
        ]),
        Row(children: 
        [
        const Text("Radians?"),
        TC.RSwitch(context),
				MM.MMB()
        ]),
			]
		)
	);
}
