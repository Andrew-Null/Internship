// ignore_for_file: file_names, non_constant_identifier_names

//import 'dart:ffi';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:math';
import '../main.dart';
//import '../Screens/Screens.dart';


//num cn_total = 0;
//SOptions cn_LUP = screen; //last used pad

//void CTotal() {cn_total = 0;}
//void STotal(num ttl) {cn_total = ttl;}

class Numpad
{
  num total = 0;
  bool float = false;
  int decimal = 0;
  Widget? LB; //left button
  Widget? RB;
  bool neg = false;

  //late Function Left;
  //late Function Right;
  late Function update;

  late double BWidth;
  late double BHeight;
  late double FSize;

  void STotal(num ttl) {total = ttl;}

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
        //cn_total = total;
        update();

        decimal += float ? 1 : 0;
        //print("button pressed");
      }, child: Text(BNT.toString()),
    //style: TextButton.styleFrom(fixedSize: Size.fromWidth(BWidth)),
    );
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
    child: const Text("."),
    //style: TextButton.styleFrom(fixedSize: Size.fromWidth(BHeight)),

    );
  }

  Row FTouches()
  {
    late Widget FinishR;
    if (RB != null) 
    {FinishR = RB as Widget;}
    else
    {
      FinishR = DPoint();
    }

    late Widget FinishL;
    if (LB != null)
    {FinishL = LB as Widget;}
    else
    {
      FinishL = TextButton(onPressed: () {neg = !neg; update(); app.Refresh;},
        child: const Text("-/+"),
        //style: TextButton.styleFrom(fixedSize: Size.fromWidth(BHeight)),
        );
    }


    return Row
    (
      children: 
      [
        FinishL,
        GButton(0),
        FinishR
      ]
    );
  }

  void Buttons({Widget? SignB, Widget? DecimalB})
  {
    if (SignB != null )
    {
      LB = SignB;
    }
    if (DecimalB != null)
    {
      RB = DecimalB;
    }
  }
  
  num GTotal()
  {
    //print(neg ? "negative" :"positive");
    return total * (neg ? -1 : 1);
  }

  void Reset()
  {
    //print("reseting");
    neg = false;
    decimal = 0;
    //cn_total = 0;
    total = 0;
    float = false;
  }
  

  Column Build()
  {
    return Column(children: [UnoATres(), CuatroASeis(), SieteANueve(), FTouches()]);
  }

  Map<String, dynamic> All()
  {
    return 
    {
      "total": GTotal,
      "negative": neg,
      "decimal": decimal,
      "floating": float
    };
  }

  Numpad({Function? updt, double Height = 4, Width = 4, Font = 12})
  {

    BHeight = Height;
    BWidth = Width;
    FSize = Font;

    update = () {app.Refresh;};

   if (updt != null)
    {
      update = updt;
    }

    /*if (screen != cn_LUP)
    {
      cn_total = 0;
    }
    total = cn_total;*/

  }

  void Update(Function param0) 
  {
    update = param0;
  }

}