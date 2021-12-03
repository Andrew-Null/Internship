// ignore_for_file: file_names, non_constant_identifier_names

//import 'dart:ffi';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:math';
import '../main.dart';
import '../Screens/Screens.dart';


num cn_total = 0;
SOptions cn_LUP = screen; //last used pad
bool cn_neg = false;

void CTotal() {cn_total = 0;}

class Numpad
{
  late num total;
  bool float = false;
  int decimal = 0;
  Widget? LB; //last button
  late Function update;

  TextButton GButton( int BNT) //button number text
  {
    return TextButton(onPressed: () 
    {
      //print("button pressing");
      if (float == true)
      {
        total = total + (BNT * pow(10, -1 * (1+ decimal)));
        decimal++;
      }
      else
      {
        //print("else");
        //print(total.toString());
        total = (total * 10) + BNT;
        //print(total.toString());
      }
      cn_total = total;
      update();

      decimal += float ? 1 : 0;
      //print("button pressed");
    }, child: Text(BNT.toString()),);
  }

  Row UnoATres()
  {
    return Row(children: [GButton(1), GButton(2),GButton(3)]);
  }

  Row CuatroASeis()
  {
    return Row(children: [GButton(4), GButton(5),GButton(6)]);
  }

  Row SieteANueve()
  {
    return Row(children: [GButton(7), GButton(8),GButton(9)]);
  }

  TextButton DPoint()
  {
    return  TextButton(onPressed: () 
    {
      float = true;
      update();
    },
      child: const Text("."));
  }

  Row FTouches()
  {
    late Widget finish;
    if (LB != null) 
    {finish = LB as Widget;}
    else
    {
      finish = DPoint();
    }
    return Row
    (
      children: 
      [
        TextButton(onPressed: () {cn_neg = !cn_neg; update(); app.Refresh;},
        child: const Text("-/+")),
        GButton(0),
        finish
      ]
    );
  }

  set Extra(Widget widg)
  {
    LB = widg;
  }
  
  num get GTotal
  {
    print(cn_neg ? "negative" :"positive");
    return total * (cn_neg ? -1 : 1);
  }

  get Reset
  {
    print("reseting");
    cn_neg = false;
    decimal = 0;
    cn_total = 0;
    total = 0;
    float = false;
  }
  

  Column get Build
  {
    return Column(children: [UnoATres(), CuatroASeis(), SieteANueve(), FTouches()]);
  }

  Map<String, dynamic> get All
  {
    return 
    {
      "total": GTotal,
      "negative": cn_neg,
      "decimal": decimal,
      "floating": float
    };
  }

  Numpad({Widget? widg, Function? updt})
  {
    if (widg != null)
    {
      LB = widg;
    }

    update = () {app.Refresh;};

   if (updt != null)
    {
      update = updt;
    }

    if (screen != cn_LUP)
    {
      cn_total = 0;
    }
    total = cn_total;

  }

  void Update(Function param0) 
  {
    update = param0;
  }

  /*void Updater(Null Function() param0) 
  {
    update = param0;
  }*/

  // Updater(Null Function() param0) {}

}