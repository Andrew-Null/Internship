// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';

class Contact
{
  //name
  var PName = ""; //primero name
  var MI    = ""; // middle intial
  var LName = ""; // last name
  var FName = ""; // full name

	void UFull()
	{
		FName = PName + " " + MI + " " + LName;
	}

  //phone number
  int PN1 = 0; //phone number part 1
  int PN2 = 0; //phone number part 2
  int PN3 = 0; //phone number part 3

  //message
  bool    BothM = false;  //Both message types
  bool TMessage = false;  //Text message
  bool CMessage = false;  // call as message
}

Container GenerateLE(Contact LC)	// generate list entry
{
	// ignore: sized_box_for_whitespace
	return Container
	(
		height: 50,
		child: Center(child: Text(LC.FName)),
		
		
		/*child: const Center
		(
			child: FloatingActionButton
			(
				child: Icon(CEDIT),
			),
		)*/

	);
}

//icons
const CEDIT   = Icons.edit;           // contact edit
const CDELETE = Icons.delete_outline; // contact delete
const CADD    = Icons.add;            // contact add