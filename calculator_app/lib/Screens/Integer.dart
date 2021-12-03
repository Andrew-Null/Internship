// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types, unused_import
//import 'dart:html';

import 'package:flutter/material.dart';
import '../main.dart';
import '../Common/Numpad.dart';
import '../Common/Math.dart';
import '../Common/Coverter.dart';

List<num> si_nms = [0, 0];
ASDMOPs? si_op;

Scaffold IntCalc() //will return scaffold later
{
  late Numpad NPad;
  
  void Clear()
  {
    NPad.Reset;
    if (si_op != null)
    {si_nms[1] = 0;}
    else if (si_op != null && si_nms[1] != 0)
    {si_op = null;}
    else
    {
      si_nms = [0,0];
      si_op = null;
    }
    app.Refresh;
  }
  
  TextButton GOpButton(ASDMOPs eop)
  {
    late String symbol;

    switch (eop)
    {
      case ASDMOPs.Add:
      {
        symbol = "+";
      }break;
      case ASDMOPs.AprxDiv:
      {
        symbol = "~/";
      }break;
      case ASDMOPs.Div:
      {
        symbol = "/";
      }break;
      case ASDMOPs.Mod:
      {
        symbol = "%";
      }break;
      case ASDMOPs.Mul:
      {
        symbol = "*";
      }break;
      case ASDMOPs.Sub:
      {
        symbol = "-";
      }break;
      default:
      {
        symbol = "err";
      }
    }

    return TextButton(child: Text(symbol), onPressed: () 
    {

      if (si_op != null)
      {
        si_nms[0] = EvalASDM(si_nms[0], si_nms[1], si_op as ASDMOPs);
        si_nms[1] = 0;
      }

      si_op = eop;
      assert(si_op != null, "op unassigned"); 
      CTotal();
      si_nms[1] = 0;
      app.Refresh;
    });
  }

  NPad = Numpad(widg: TextButton(child: const Text("Clear"), onPressed: () 
    {
      Clear();
    }
  ));

  num ETotal()
  {
    return NPad.GTotal;
  }

  NPad.Update(()
  {
   // print("updating");
    si_nms[(si_op != null) ? 1 : 0] = ETotal();
    print(((si_op != null) ? 1 : 0).toString());
    //print(NPad.GTotal);
    app.Refresh;
    //print("updated");
    print(si_nms[0]);
    print(si_nms[1]);
  });

 /* NPad.Updater(() 
  {
    si_nms[(si_op != null) as int] = NPad.GTotal;
    app.Refresh;
  });*/



  return Scaffold(body: Center(child: Row(children: [Text(si_nms[(si_op != null) ? 1 : 0].toString()), 
  NPad.Build, 
  Column(children: 
    [GOpButton(ASDMOPs.Add),
    GOpButton(ASDMOPs.Sub),
    GOpButton(ASDMOPs.Mul),
    GOpButton(ASDMOPs.AprxDiv)
  ])])));

}

/*Scaffold IntCalc(BuildContext context)
{
  return Scaffold
  (
		Row
		(children: [

		])
  );
}*/