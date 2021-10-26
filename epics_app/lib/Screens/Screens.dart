// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import '../List/CList.dart';
import '../main.dart';

enum SOptions //screen options
{
  HomeS,
  ShowContactS
}

Scaffold ChooseScreen(BuildContext context)
{
  switch(screen)
  {
		case SOptions.ShowContactS:
		{
			ShowContact(context, ContactL[SEntry]);
		} break;
		case SOptions.HomeS:
		{
			return GHomeS(context,5);
		} break;
    default:
    {
			return GHomeS(context,5); 
    } 
  }
	return GHomeS(context,10);
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

Scaffold ShowContact(BuildContext context, Contact who)
{
	return who.ShowAll(context);
}