 // ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'Menus/MMenu.dart';
import '../main.dart';

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

List<num?> _Values =
[
  null,
  null,
  null,
  null,
  null,
  null
];
//TextEditingController _controller = TextEditingController();

TextField TxtBoxGen(SyAIE index)
{
  //app.Refresh;
  late int intex;
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

  return TextField
  (
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
	//      color: _Values[intex] == null ? Colors.red : Colors.green
        )
      ),
    ),
    controller: _TxtControllers[intex],
  );
}

Column AngleTextBoxes()
{
  return Column
  (
    children:
    [
			TxtBoxGen(SyAIE.AA),
			TxtBoxGen(SyAIE.AB),
			TxtBoxGen(SyAIE.AC)
    ]
  );
}

Column SideTextBoxes()
{
  return Column
  (
    children:
    [
			TxtBoxGen(SyAIE.sa),
			TxtBoxGen(SyAIE.sb),
			TxtBoxGen(SyAIE.sc)
    ]
  );
}

Scaffold TriSolver(BuildContext context)
{
	// ignore: prefer_const_constructors
	return Scaffold(body: 
		Column(children:
			[
        Row(children:
        [
          AngleTextBoxes(),
          //SideTextBoxes()
      	]),
				MMB()
			]
		)
	);
}
