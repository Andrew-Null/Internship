// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types, unused_import
//import 'dart:html';

//import 'dart:js';

import 'package:flutter/material.dart';
import '../main.dart';
import '../Common/Numpad.dart';
import '../Common/Math.dart';
//import '../Common/Coverter.dart';
import 'Menus/MMenu.dart';

List<int> _nms = [0, 0];
ASDMOPs? _op;

Numpad _NPad = Numpad();/*widg: TextButton(child: const Text("Clear"), onPressed: () 
    {
      Clear();
    }
  ));
  */



int WI() //which index
{
  return _op != null ? 1 : 0;
}

Scaffold IntCalc(BuildContext context) 
{
  //const double FontS = 24, Height = 72, Width = 72;


  //`late Numpad _NPad;

  void IntEvaluate()
  {
    assert(_op != null, "_op is still null");
    int u = _nms[0];// u - uno
    int d = _nms[1];// d - dos
    var o = _op;    // o - op
    _nms[0] = EvalASDM(u, d, _op as ASDMOPs)as int;
    _nms[1] = 0;
    _op = null;

    app.Refresh; 
  }
  
  void Clear()
  {
    //print("clearing");
    _NPad.Reset();
    if (_op != null)
    {_nms[1] = 0;}
    else if (_op != null && _nms[1] != 0)
    {_op = null;}
    else
    {
      _nms = [0,0];
      _op = null;
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

      if (_op != null)
      {
        _nms[0] = EvalASDM(_nms[0], _nms[1], _op as ASDMOPs) as int;
        _nms[1] = 0;
      }

      _op = eop;
      assert(_op != null, "op unassigned"); 
      _NPad.Reset();
      _nms[1] = 0;
      app.Refresh;
    });
  }


  num ETotal()
  {
    return _NPad.GTotal();
  }

  _NPad.Update(()
  {
    _nms[(_op != null) ? 1 : 0] = ETotal() as int;
    print(WI().toString());
    app.Refresh;
    //print(_nms[0]);
    //print(_nms[1]);
  });

  _NPad.Buttons(DecimalB: TextButton(child: const Text("Clear"), onPressed: () 
    {
      Clear();
    }));

  return Scaffold(body: Center(child: 
  Column(
      //alignment: Alignment.center,
      children: 
      [
        Center(child: Column(
        children: [
          Align
          (
            child: Text(_nms[(_op  != null) ?1: 0].toString()), 
            alignment:  Alignment.topCenter
          ),
          Row(
            children: [ 
            _NPad.Build(), 
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
                  _nms[WI()] = _nms[WI()] << 1; 
                  _nms[WI()]; app.Refresh;
                },
              ),
              TextButton(child: const Text(">>"),     
                onPressed: ()
              {
                _nms[WI()] = _nms[WI()] >> 1; 
                _NPad.STotal(_nms[WI()]); 
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