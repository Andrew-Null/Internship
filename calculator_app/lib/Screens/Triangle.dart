 // ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables

 import 'package:flutter/material.dart';
 import 'Menus/MMenu.dart';
 import '../main.dart';

enum SyAIE //side and angles index enum
{
	AA = 0,
  AB = 1,
  AC = 2,
  sa = 3,
  sb = 4,
  sc = 5
}

TextEditingController _TxtControllers =
[
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController()
]

String _TxtLabels =
[
  "Angle A",
  "Angle B",
  "Angle C",
  "Side a",
  "Side b",
  "Side c"
]

num? _Values =
[
  null,
  null,
  null,
  null,
  null,
  null
]
//TextEditingController _controller = TextEditingController();

TextField TxtBoxGen(SyAIE index)
{
  //app.Refresh;
  return TextField
  (
    keyboardType: TextInputType.number,
    onChanged: ()
    {
      try
      {
        _Values[index] = num.parse(_TxtControllers[index]);
      }
      catch
      {
        _Values[index] = null;
      }
    },
    decoration: InputDecoration
    (
      border: const OutlineInputBorder(),
      labelText: _TxtLabels[index],
    ),
    controller: _TxtControllers[index],
  );
}

Column AngleTextBoxes()
{
  return Column
  (
    children:
    [

    ]
  )
}


Scaffold TriSolver()
{
	// ignore: prefer_const_constructors
	return Scaffold(body: 
		Column(children: 
			[
				const TextField(keyboardType: TextInputType.number),
				MMB()
			]
		)
	);
}
