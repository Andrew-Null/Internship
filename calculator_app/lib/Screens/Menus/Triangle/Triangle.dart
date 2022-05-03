 // ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, library_prefixes

import 'package:calculator_app/Geometry/Angle.dart' as Ang;
import 'package:calculator_app/Geometry/Side.dart' as Side;
import 'package:flutter/material.dart';
import '../MMenu.dart' as MM;
import '../../../Geometry/Triangle/Triangle.dart' as Tri;

import 'TriVars.dart' as TV;
import 'TriComponents.dart' as TC;

void ToPrimitive2D(int intex)
{
  try
  {
    double val = double.parse(TV.TxtControllers[intex].text);
    if (intex <= 3)
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
