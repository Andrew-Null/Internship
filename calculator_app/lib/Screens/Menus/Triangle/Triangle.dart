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
          return Iterate(val.abs() % 6, mode);
        }
      }
    }
    case TV.Contents.Side:
    {
      switch(val)
      {
        case 1 | 5: {return 3;}
        case 2 | 3: {return 4;}
        case 0 | 4: {return 5;}
        default: {return Iterate(val.abs() % 6, mode);}
      }
    }
    case TV.Contents.Angle:
    {
      switch(val)
      {
        case 0 | 5: {return 1;}
        case 1 | 3: {return 2;}
        case 2 | 4: {return 0;}
        default: {return Iterate(val.abs() % 6, mode);}
      }
    }
  }
}

Future<void> CanSolve() async
{
  int total = 0;
  List<TV.Contents> nn = List<TV.Contents>.filled(6, TV.Contents.None);
  for (int fv = 0; fv <= 5; fv ++)
  {
    if (TV.Values[fv] != null) {total++;}
    if  (TV.Values[fv] is Ang.Angle)
    {
      nn[fv] = TV.Contents.Angle;
    }
    else if (TV.Values[fv] is Side.Side)
    {
      nn[fv] = TV.Contents.Side;
    }
  }
}

void ToPrimitive2D(int intex)
{
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