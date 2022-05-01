 // ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:calculator_app/Geometry/Geometry.dart';
import 'package:calculator_app/Geometry/Angle.dart';
import 'package:calculator_app/Geometry/Side.dart';
import 'package:flutter/material.dart';
import 'Menus/MMenu.dart';
import '../main.dart';

bool _RMode = false; //Radian Mode
const DEFAULTPAD = 1.0;

enum SyAIE //side and angles index enum
{
	AA,
	AB,
	AC,
	sa,
	sb,
	sc
}

List<TextEditingController> _TxtControllers =
[
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController()
];

List<String> _TxtLabels =
[
  "Angle A",
  "Angle B",
  "Angle C",
  "Side a",
  "Side b",
  "Side c"
];

List<Primitive2D?> _Values =
[
  null,
  null,
  null,
  null,
  null,
  null
];

Primitive2D ToPrimitie2D(SyAIE what, num value)
{
  //0-2 which, 3 what, 4 radian, 5 has pi
  const int ISANG = 3; //is angle
  final int RadPi = _RMode ? 1 << 4 : 0;
  int info = 0; //
  switch (what)
  {
    case SyAIE.AA:
    {
      info = 1 + (1 << ISANG) + RadPi;
    }
  }
}

SizedBox TxtBoxGen(SyAIE index, BuildContext context)
{
  const double SWITCHSPACE = 32.5;
  final w = MediaQuery.of(context).size.width;
  int intex = 0;
  switch (index)
  {
    case SyAIE.AA:
    {
      intex = 0;
    }break;
    case SyAIE.AB:
    {
      intex = 1;
    }break;
    case SyAIE.AC:
    {
      intex = 2;
    }break;
    case SyAIE.sa:
    {
      intex = 3;
    }break;
    case SyAIE.sb:
    {
      intex = 4;
    }break;
    case SyAIE.sc:
    {
      intex = 5;
    }break;
  }
  print(intex);
  print(_Values[intex] == null ? "red\n" : "green\n");

  return SizedBox(width: (w * .49) - (_RMode ? SWITCHSPACE : 0.0), child: Padding(padding: const EdgeInsets.all(4.0), child: TextField(
    keyboardType: TextInputType.number,
    onChanged: (content)
    {
      try
      {
        _Values[intex] = num.parse(_TxtControllers[intex].text);
      }
      catch(e)
      {
        _Values[intex] = null;
      }
      app.Refresh;
    },
		decoration: InputDecoration
    (
      labelText: _TxtLabels[intex],
      border: OutlineInputBorder
      (
        borderSide: BorderSide
        (
	        color: _Values[intex] == null ? const Color(0xffff0000) : const Color(0xff00ff00),
          width: 5.0,
          //style: BorderStyle.solid
        )
      ),
    ),
    controller: _TxtControllers[intex],
  )));
}

Column AngleTextBoxes(BuildContext context)
{
  return Column
  (
    children:
    [
			TxtBoxGen(SyAIE.AA, context),
			TxtBoxGen(SyAIE.AB, context),
			TxtBoxGen(SyAIE.AC, context)
    ]
  );
}

Column SideTextBoxes(BuildContext context)
{
  return Column
  (
    children:
    [
			TxtBoxGen(SyAIE.sa, context),
			TxtBoxGen(SyAIE.sb, context),
			TxtBoxGen(SyAIE.sc, context)
    ]
  );
}

Padding RSwitch(BuildContext context)
{
  const double SWITCHPAD = 4.0;
  return Padding
  (
    padding: EdgeInsets.all(SWITCHPAD), child:
    Switch
    (
    value: _RMode,
    onChanged: (val)
    {
      _RMode = !_RMode;
      app.Refresh;
    },
    )
  );
}
enum AngIndex
{
  a,
  b,
  c
}

List<bool> _HasPi = [false, false, false];

Padding PiSwitch(BuildContext context, AngIndex cual)
{
  int intex = 0;
  switch (cual)
  {
    case AngIndex.a:
    {}break;
    case AngIndex.b:
    {
      intex = 1;
    }break;
    case AngIndex.c:
    {
      intex = 2;
    }break;
  }
  return Padding(padding: const EdgeInsets.all(DEFAULTPAD),
    child: Switch
    (
      value: _HasPi[intex],
      onChanged: (value)
      {
        _HasPi[intex] = !_HasPi[intex];
        app.Refresh;
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
    PiSwitch(context, AngIndex.a),
    PiSwitch(context, AngIndex.b),
    PiSwitch(context, AngIndex.c)
  ]);
}

Scaffold TriSolver(BuildContext context)
{
	// ignore: prefer_const_constructors
	return Scaffold(body: 
		Column(children:
			[
        (_RMode ?
        Row(children:
        [
          SideTextBoxes(context),
          AngleTextBoxes(context),
          PiSwitches(context)
      	]):
        Row(children:
        [
          SideTextBoxes(context),
          AngleTextBoxes(context),
      	])
        ),
        Row(children: 
        [
        const Text("Radians?"),
        RSwitch(context),
				MMB()
        ]),
			]
		)
	);
}
