// ignore_for_file: file_names, library_prefixes, non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';

import '../../../Geometry/Angle.dart' as Ang; 
import '../../../Geometry/Side.dart' as Side;
import 'TriVars.dart' as TV;
import '../../../main.dart' as main;
import 'Triangle.dart' as TS;

SizedBox OutBoxGen(TV.SyAIE index, BuildContext context)
{
  int source = index.index;

  var raw = TV.Values[source];
  String text = "";
  if (raw is Ang.Degree)
  {
    text = raw.value.toString();
  }
  else if (raw is Ang.Radian)
  {
    text = raw.value.toString();
  }
  else if (raw is Side.Side)
  {
    text = raw.length.toString();
  }

  final w = MediaQuery.of(context).size.width;
  return SizedBox(width: (w * .49), child: Padding(padding: const EdgeInsets.all(6.0), child: Text
    (
        text,
		)
	));
}

Column AngleOut(BuildContext context)
{
  return Column
  (
    children: 
    [
      OutBoxGen(TV.SyAIE.AA, context),
      OutBoxGen(TV.SyAIE.AB, context),
      OutBoxGen(TV.SyAIE.AC, context)
    ],
  );
}
Column SideOut(BuildContext context)
{
  return Column
  (
    children: 
    [
      OutBoxGen(TV.SyAIE.sa, context),
      OutBoxGen(TV.SyAIE.sb, context),
      OutBoxGen(TV.SyAIE.sc, context)
    ],
  );
}

Padding PiSwitch(BuildContext context, TV.AngIndex cual)
{
  int intex = cual.index;
  return Padding(padding: const EdgeInsets.all(TV.DEFAULTPAD),
    child: Switch
    (
      value: TV.HasPi[intex],
      onChanged: (value)
      {
        TV.HasPi[intex] = !TV.HasPi[intex];TS.ToPrimitive2D(intex);main.app.Refresh;
      },
    ), 
  );
}

Column PiSwitches(BuildContext context)
{
  const double TEXTPAD = 2.0;
  return Column
  (children: [
    const Padding(child: Text("Includes pi?"), padding: EdgeInsets.all(TEXTPAD)),
    PiSwitch(context, TV.AngIndex.a),
    PiSwitch(context, TV.AngIndex.b),
    PiSwitch(context, TV.AngIndex.c)
  ]);
}

Padding RSwitch(BuildContext context)
{
  const double SWITCHPAD = 4.0;
  return Padding
  (
    padding: const EdgeInsets.all(SWITCHPAD), child:
    Switch
    (
    value: TV.RMode,
    onChanged: (val)
    {
      TV.RMode = !TV.RMode;
      
      for(int fv = 0; fv <= 2; fv ++)
      {
        TS.ToPrimitive2D(fv);
      }
      
      main.app.Refresh;
    },
    )
  );
}

Column SideTextBoxes(BuildContext context)
{
  return Column
  (
    children:
    [
			TxtBoxGen(TV.SyAIE.sa, context),
			TxtBoxGen(TV.SyAIE.sb, context),
			TxtBoxGen(TV.SyAIE.sc, context)
    ]
  );
}

Column AngleTextBoxes(BuildContext context)
{
  return Column
  (
    children:
    [
			TxtBoxGen(TV.SyAIE.AA, context),
			TxtBoxGen(TV.SyAIE.AB, context),
			TxtBoxGen(TV.SyAIE.AC, context)
    ]
  );
}

SizedBox TxtBoxGen(TV.SyAIE index, BuildContext context)
{
  const double SWITCHSPACE = 32.5;
  final w = MediaQuery.of(context).size.width;
  int intex = index.index;

  return SizedBox(width: (w * .49) - (TV.RMode ? SWITCHSPACE : 0.0), child: Padding(padding: const EdgeInsets.all(6.0), child: TextField(
    keyboardType: TextInputType.number,
    onChanged: (content)
    {
      TS.ToPrimitive2D(intex);
      main.app.Refresh;
    },
		decoration: InputDecoration
    (
      labelText: TV.TxtLabels[intex],
      border: OutlineInputBorder
      (
        borderSide: BorderSide
        (
	        color: TV.Values[intex] == null ? const Color(0xffff0000) : const Color(0xff00ff00),
          width: 5.0,
        )
      ),
    ),
    controller: TV.TxtControllers[intex],
  )));
}