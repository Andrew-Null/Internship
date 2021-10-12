// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';

List<Contact> ContactL = //contact list
[];

class Contact
{
  //name
  var PName = ""; //primero name/first name
  var MInitial    = ""; // middle intial
  var LName = ""; // last name
  var FName = ""; // full name

	void UFull() //update full name
	{
		FName = PName + " " + MInitial + " " + LName;
	}

  //phone number
  int PN1 = 0; //phone number part 1
  int PN2 = 0; //phone number part 2
  int PN3 = 0; //phone number part 3

  //message
  bool    BothM = false;  //Both message types
  bool TMessage = false;  //Text message
  bool CMessage = false;  // call as message

  Contact(String PN, String MI, String LN, int CPN1, int CPN2, int CPN3, bool B, bool TM)
  {
    PName = PN;
    MInitial = MI;
    LName = LN;
    UFull();

    PN1 = CPN1;
    PN2 = CPN2;
    PN3 = CPN3;

    BothM = B;
    TMessage = B || TM;
    CMessage = B || !TM;

  }

}

ListView CreateList(List<Contact> Contacts, BuildContext context)
{
  return ListView.builder
  (
    itemCount: Contacts.length,

    itemBuilder: (BuildContext context, int index)
    {
      return Text(Contacts[index].FName);
    },
  );
}

ListView GTL(int TN, BuildContext context) //generate test list
{
  String PName = "Test";
  String MI = "I";
  String LName = "ng";

  int PN1 = 0;
  int PN2 = 0;
  int PN3 = 0;

  bool Both = false;
  bool Text = true;

  for (var fv1 = 0; fv1 < TN; fv1++)
  {
    PN3++;
    PN2 += ((PN3 > 9999) ? 1: 0); 
    PN1 += ((PN2 > 999) ? 1 : 0); 
    PN3 = PN3 % 10000;
    ContactL.add(Contact(PName, MI, LName, PN1, PN2, PN3, Both, Text));
  }

  return CreateList(ContactL, context);

}



//icons
const CEDIT   = Icons.edit;           // contact edit
const CDELETE = Icons.delete_outline; // contact delete
const CADD    = Icons.add;            // contact add