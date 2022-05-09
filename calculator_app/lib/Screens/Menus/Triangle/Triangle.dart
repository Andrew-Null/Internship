 // ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, library_prefixes

import 'package:calculator_app/Geometry/Angle.dart' as Ang;
import 'package:calculator_app/Geometry/Side.dart' as Side;
import 'package:flutter/material.dart';
import '../MMenu.dart' as MM;
import '../../../Geometry/Triangle/Triangle.dart' as Tri;

import 'TriVars.dart' as TV;
import 'TriComponents.dart' as TC;

//import 'dart:io' as DIO;

int Iterate(int val, TV.Contents mode)
{
  //print("Iterating $val for $mode");
  //Future.delayed(Duration(seconds: 10), () => null);
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
          //print("None defaulted with $val");
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
          //print("Side defaulted with $val");
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
          //print("Angle defaulted with $val");
          return Iterate(val.abs() % 6, mode);
        }
      }
    }
  }
}

Tri.Triangle? TryAAS(int A1, {int limit = 3})
{
  print("Trying AAS $limit");
  //DIO.sleep(Duration(seconds: 10));
  int A2 = Iterate(A1, TV.Contents.Angle);
  int S = Iterate(A2, TV.Contents.Side);

  if (TV.Values[A1] is Ang.Angle && TV.Values[A2] is Ang.Angle && TV.Values[S] is Side.Side)
  {
    var tri = Tri.Triangle.AAS
    (
      TV.Values[A1] as Ang.Angle,
      TV.Values[A2] as Ang.Angle,
      TV.Values[S] as Side.Side
    );
    return tri;
  }

  if (limit > 0)
  {
    return TryAAS(Iterate(A1, TV.Contents.Angle), limit: limit - 1);
  }
  return null;
}

Tri.Triangle? TryASA(int A1, {int limit = 3})
{
  print("Trying ASA $limit");
  //DIO.sleep(Duration(seconds: 10));
  int S = Iterate(A1, TV.Contents.Side);
  int A2 = Iterate(S, TV.Contents.Angle);

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

  if (limit > 0)
  {
    return TryASA(Iterate(A1, TV.Contents.Angle), limit: limit - 1);
  }
  return null;
}

Tri.Triangle? TrySSA(int S1, {int limit = 3})
{
  print("Trying SSA $limit");
  //DIO.sleep(Duration(seconds: 10));
  int S2 = Iterate(S1, TV.Contents.Side);
  int A = Iterate(S2, TV.Contents.Angle);

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

  if (limit > 0)
  {
    return TrySSA(Iterate(S1, TV.Contents.Side), limit: limit - 1);
  }
  return null;
}

Tri.Triangle? TrySAS(int S1, {int limit = 3})
{
  print("Trying SAS $limit");
  //DIO.sleep(Duration(seconds: 10));
  int A = Iterate(S1, TV.Contents.Angle);
  int S2 = Iterate(A, TV.Contents.Side);

  if (TV.Values[S1] is Side.Side && TV.Values[A] is Ang.Angle && TV.Values[S2] is Side.Side)
  {
    var tri = Tri.Triangle.SAS
    (
      TV.Values[S1] as Side.Side,
      TV.Values[A] as Ang.Angle,
      TV.Values[S2] as Side.Side
    );
    return tri;
  }

  if (limit > 0)
  {
    var irt = TryASA(Iterate(S1, TV.Contents.Side), limit: limit - 1);
    if (irt is Tri.Triangle)
    {
      irt.RotAaB();
    }
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

void TrySolve()
{
  print("Trying to Solve");
  Tri.Triangle? tri = TryAAS(0);
  tri ??= TryASA(0);
  tri ??= TrySSA(5);
  tri ??= TrySAS(5);
  tri ??= TrySSS();

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
  //TrySolve();
  if(TV.TxtControllers[intex].text.isEmpty)
  {
    //print("$intex is empty");
  }
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
  for(int fv = 0; fv <= 2; fv ++)
  {
    TV.Values[fv] = null;
    (TV.TxtControllers[fv].text.isEmpty) ? null : ToPrimitive2D(fv);
  }
  TrySolve();
  print(TV.Values);
  for (var box in TV.TxtControllers)
  {
   // print(box.text);
  }
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
