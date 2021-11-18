// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import '../main.dart';

enum SOptions //screen options
{
  //HomeS,
  IntegerCS
}

Scaffold ChooseScreen(BuildContext context)
{
  switch(screen)
  {
		case SOptions.IntegerCS:
		{
			return ContactL[SEntry].ShowAll(context);
		} 
  }
}


