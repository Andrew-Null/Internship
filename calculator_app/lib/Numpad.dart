// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:math';

class Numpad
{
  dynamic total = 0;
  bool float = false;
  int decimal = 0;
  bool neg = false;
  Widget? LB;

  TextButton GButton(int BNT) //button number text
  {
    return TextButton(onPressed: () 
    {
      total = (((total * (10)) + BNT) * float as int) + ((float as int) * (total + (pow(10, -1 - decimal) * BNT)));
      decimal += float as int;
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
    return  TextButton(onPressed: () {float = true;},
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
        TextButton(onPressed: () {neg = !neg;},
        child: const Text("-")),
        GButton(0),
        finish
      ]
    );
  }
  set Extra(Widget widg)
  {
    LB = widg;
  }
  
  get GTotal
  {
    return total * (1 - (2 * (neg as int)));
  }

  Column get Build
  {
    return Column(children: [UnoATres(), CuatroASeis(), SieteANueve(), FTouches()]);
  }

  Numpad(Widget? widg)
  {
    if (widg != null)
    {
      LB = widg;
    }
  }

}