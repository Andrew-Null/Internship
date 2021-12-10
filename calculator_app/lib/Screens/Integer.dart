// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types, unused_import
//import 'dart:html';

//import 'dart:js';

import 'package:flutter/material.dart';
import '../main.dart';
import '../Common/Numpad.dart';
import '../Common/Math.dart';
import '../Common/Coverter.dart';
import 'Menus/MMenu.dart';

List<int> si_nms = [0, 0];
ASDMOPs? si_op;

int WI() //which index
{
  return si_op != null ? 1 : 0;
}

Scaffold IntCalc(BuildContext context) 
{
  //const double FontS = 24, Height = 72, Width = 72;


  late Numpad NPad;

  void IntEvaluate()
  {
    assert(si_op != null, "si_op is still null");
    int u = si_nms[0];// u - uno
    int d = si_nms[1];// d - dos
    var o = si_op;    // o - op
    si_nms[0] = EvalASDM(u, d, si_op as ASDMOPs)as int;
    si_nms[1] = 0;
    si_op = null;

    app.Refresh; 
  }
  
  void Clear()
  {
    //print("clearing");
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
        si_nms[0] = EvalASDM(si_nms[0], si_nms[1], si_op as ASDMOPs) as int;
        si_nms[1] = 0;
      }

      si_op = eop;
      assert(si_op != null, "op unassigned"); 
      NPad.Reset;
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
    si_nms[(si_op != null) ? 1 : 0] = ETotal() as int;
    //print(((si_op != null) ? 1 : 0).toString());
    app.Refresh;
    //print(si_nms[0]);
    //print(si_nms[1]);
  });

  return Scaffold(body: Center(child: 
  Column(
      //alignment: Alignment.center,
      children: 
      [
        Center(child: Column(
        children: [
          Align
          (
            child: Text(si_nms[(si_op  != null) ?1: 0].toString()), 
            alignment:  Alignment.topCenter
          ),
          Row(
            children: [ 
            NPad.Build, 
            Column(children:
              [
                GOpButton(ASDMOPs.Add),
                GOpButton(ASDMOPs.Sub),
                GOpButton(ASDMOPs.Mul),
                GOpButton(ASDMOPs.AprxDiv)
              ]
            ),
            Column(children: 
            [
              TextButton(child: const Text("="),    onPressed: () {IntEvaluate();},),
              TextButton(child: const Text("<<"),         
                onPressed: () 
                {
                  si_nms[WI()] = si_nms[WI()] << 1; 
                  si_nms[WI()]; app.Refresh;
                },
              ),
              TextButton(child: const Text(">>"),     
                onPressed: ()
              {
                si_nms[WI()] = si_nms[WI()] >> 1; 
                STotal(si_nms[WI()]); 
                app.Refresh;
              }
              ),
            ]) 
          ]),
          MMB()  
        ])
      )
    ]),
  ));
}