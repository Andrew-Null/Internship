// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import '../List/CList.dart';
import '../main.dart';

enum SOptions //screen options
{
  HomeS,
  ShowContactS,
	Testing
}

Scaffold ChooseScreen(BuildContext context)
{
  switch(screen)
  {
		case SOptions.ShowContactS:
		{
			return ContactL[SEntry].ShowAll(context);
		} 
		case SOptions.HomeS:
		{
			return GHomeS(context,5);
		}
		case SOptions.Testing:
		{
			return GHomeS(context, 5);
		}
  }
}

Scaffold GHomeS(BuildContext context, int size) //generate home screen
{
	 return Scaffold
			(
      	appBar: AppBar(
        	// ignore: prefer_const_constructors
        	title: Text("Home"), //change this later
      	),
      	body: Center
      	(

        child: GTL(size, context),

        ),
      );
}

