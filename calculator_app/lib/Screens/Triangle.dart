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

SizedBox TxtBoxGen(SyAIE index, BuildContext context)
{
  final w = MediaQuery.of(context).size.width;
  print("Creating TextFields");
  //app.Refresh;
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

  return SizedBox(width: w * .49, child: TextField(//);
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
	      color: _Values[intex] == null ? Colors.red : Colors.green
        )
      ),
    ),
    controller: _TxtControllers[intex],
  ));
}

Column AngleTextBoxes(BuildContext context)
{
  print("Creating Angle Text boxes");
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
  print("Creating Side Text Boxes");
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

Scaffold TriSolver(BuildContext context)
{
	// ignore: prefer_const_constructors
	return Scaffold(body: 
		Column(children:
			[
        Row(children:
        [
          //TxtBoxGen(SyAIE.AA, context)
          AngleTextBoxes(context),
          SideTextBoxes(context)
      	]),
				MMB()
			]
		)
	);
}
