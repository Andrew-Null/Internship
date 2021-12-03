// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import '../main.dart';
import 'Integer.dart';
//import '../Numpad.dart';

enum SOptions //screen options
{
  //HomeMS, //going to need this later
  //GeometryMS, //also going to need this later
  IntegerCS
}

Scaffold ChooseScreen(BuildContext context)
{
  switch(screen)
  {
		case SOptions.IntegerCS:
		{
      //Numpad temp = Numpad(widg: null);
			return IntCalc();
		} 
  }
}


