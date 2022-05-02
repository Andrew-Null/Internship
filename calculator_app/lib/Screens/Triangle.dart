 // ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, library_prefixes

import 'package:calculator_app/Geometry/Geometry.dart' as Geo;
import 'package:calculator_app/Geometry/Angle.dart' as Ang;
import 'package:calculator_app/Geometry/Side.dart' as Side;
import 'package:flutter/material.dart';
import 'Menus/MMenu.dart' as MM;
import '../main.dart' as main;

bool _RMode = false; //Radian Mode
const _DEFAULTPAD = 1.0;

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

List<Geo.Primitive2D?> _Values =
[
  null,
  null,
  null,
  null,
  null,
  null
];

void ToPrimitive2D(int intex)
{
  try
  {
    double val = double.parse(_TxtControllers[intex].text);
    if (intex >= 3)
    {
      if (_RMode)
      {
      	_Values[intex] = Ang.Radian(val,_HasPi[intex]);
      }
      else
      {
        _Values[intex] = Ang.Degree(val);
      }

    }
    else
    {
			_Values[intex] = Side.Side(val);
    }

  }
  catch(e)
  {
    _Values[intex] = null;
  }
}

SizedBox OutBoxGen(SyAIE index, BuildContext context)
{
  int source = 0;
  switch (index)
  {
    case SyAIE.sc: {source = 5;}break;
    case SyAIE.sb: {source = 4;}break;
    case SyAIE.sa: {source = 3;}break;
    case SyAIE.AC: {source = 2;}break;
    case SyAIE.AB: {source = 1;}break;
    case SyAIE.AA: {source = 0;}break;
  }

  var raw = _Values[source];
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
      OutBoxGen(SyAIE.AA, context),
      OutBoxGen(SyAIE.AB, context),
      OutBoxGen(SyAIE.AC, context)
    ],
  );
}
Column SideOut(BuildContext context)
{
  return Column
  (
    children: 
    [
      OutBoxGen(SyAIE.sa, context),
      OutBoxGen(SyAIE.sb, context),
      OutBoxGen(SyAIE.sc, context)
    ],
  );
}

SizedBox TxtBoxGen(SyAIE index, BuildContext context)
{
  const double SWITCHSPACE = 32.5;
  final w = MediaQuery.of(context).size.width;
  int intex = index.index;

  return SizedBox(width: (w * .49) - (_RMode ? SWITCHSPACE : 0.0), child: Padding(padding: const EdgeInsets.all(6.0), child: TextField(
    keyboardType: TextInputType.number,
    onChanged: (content)
    {
      ToPrimitive2D(intex);
      main.app.Refresh;
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
      
      for(int fv = 0; fv <= 2; fv ++)
      {
        ToPrimitive2D(fv);
      }
      
      main.app.Refresh;
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
  int intex = cual.index;
  return Padding(padding: const EdgeInsets.all(_DEFAULTPAD),
    child: Switch
    (
      value: _HasPi[intex],
      onChanged: (value)
      {
        _HasPi[intex] = !_HasPi[intex];ToPrimitive2D(intex);main.app.Refresh;
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
          SideOut(context),
          AngleOut(context),
        ]),
        Row(children: 
        [
        const Text("Radians?"),
        RSwitch(context),
				MM.MMB()
        ]),
			]
		)
	);
}
