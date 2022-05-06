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
  print("Iterating $val for $mode");
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
          print("None defaulted with $val");
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
          print("Side defaulted with $val");
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
          print("Angle defaulted with $val");
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

void TrySolve()
{
  print("Trying to Solve");
  Tri.Triangle? tri = TryAAS(0);
  if (tri == null)
  {

  }

  if (tri != null)
  {
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
  try
  {
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
  TrySolve();
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
