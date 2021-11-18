// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types

//import 'dart:js';

import 'package:epics_app/Screens/Screens.dart';
import 'package:flutter/material.dart';

import '../main.dart';

List<Contact> ContactL = //contact list
[];
int SEntry = 0; //selected entry

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

  int Priority = 0; // the higher the longer before they are contacted

  //message
  bool    BothM = false;  //Both message types
  bool TMessage = false;  //Text message
  bool CMessage = false;  // call as message

  final EDITABLE = 7; //editable fields

  Contact(String PN, String MI, String LN, int CPN1, int CPN2, int CPN3, bool B, bool TM, int prty)
  {
    PName = PN;
    MInitial = MI;
    LName = LN;
    UFull();

    PN1 = CPN1;
    PN2 = CPN2;
    PN3 = CPN3;

		Priority = prty;

    BothM = B;
    TMessage = B || TM;
    CMessage = B || !TM;

  }

  Row CreateEntry(int EIndex, BuildContext context) //entry index
  {
    return Row
    (
      children:
      [
        Text(FName),
        FloatingActionButton
        (
          onPressed: ()
          {
            screen = SOptions.ShowContactS;
            app.Refresh();
          },
        )
      ]
    );
  }

	Row ShowMember(String hint, String label, int which)
	{
    final TCont = TextEditingController(); //text controller
		return Row(
        children: [
      TextField(decoration: InputDecoration(
			hintText: hint,
			labelText: label,
		),
    controller: TCont,
      // ignore: avoid_print
     // print("Saved");
			/**/
          ),
          FloatingActionButton(onPressed: ()
          {
            String? value = TCont.text;
            if (value != null && value != "" && value != '')
			    {
			  	  switch (which % EDITABLE) //  change   the divisor to match the  number Contact {}'s members editable   by text
			  	  {
			  	  	case 0:
			  	  	{
			  	  		PName = value;
                UFull();
			  	  	}break;
			  	  	case 1:
			  	  	{
			  	  		MInitial = value;
                UFull();
			  	  	}break;
			  	  	case 2:
			  	  	{
			  	  		LName = value;
                UFull();
			  	  	}break;
				    	case 3:
				    	{
                int temp = StrAInt(value);
                value = temp.toString();
                if (value.length == 3)
                {
                  PN1 = temp;
                }

				    	}break;
				    	case 4:
				    	{
                int temp = StrAInt(value);
                value = temp.toString();
                if (value.length == 3)
                {
                  PN2 = temp;
                }
				    	}break;
				    	case 5:
				    	{
                int temp = StrAInt(value);
                value = temp.toString();
                if (value.length == 4)
                {
                  PN3 = temp;
                }
				    	}break;
				    	case 6:
				    	{
                Priority = StrAInt(value);
                value = Priority.toString();
				    	}break;
				    }
            app.Refresh;
          }
          })
        ]
      );
    
	}

  Scaffold ShowAll(BuildContext context)
  {
    List<Row> Fields = [];
    Fields.add(ShowMember(PName, "First Name", 0));
    return Scaffold
    (
      appBar: AppBar
      ( 
        // ignore: prefer_const_constructors
        title: Text("Contact Members"),
      ),
      body: Center
      (child: Column
        (
          children:
          [
              Text(PName + " " + MInitial + " " + LName),
              Text(FName),
              Text(PN1.toString() + " " + PN2.toString() + " " + PN3.toString()),
              Text(BothM.toString() + " " + TMessage.toString() + " " + CMessage.toString()),

             //Fields[0],
              /*FloatingActionButton(onPressed: ()
              {
                print("Presssed");
                //Fields[0];
                app.Refresh;
              })*/

							/*Row(
								children: [],
							)*/

          ]
        ) 
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()
          {
            print("Going Home");
            screen = SOptions.HomeS;
            app.Refresh();
          },
      ) ,
    );
  }

}

ListView CreateList(List<Contact> Contacts, BuildContext context)
{
  return ListView.builder
  (
    itemCount: Contacts.length,

    itemBuilder: (BuildContext context, int index)
    {
      return Contacts[index].CreateEntry(index, context);
    },
  );
}

ListView GTL(int TN, BuildContext context) //generate test list
{
  String PName = "Testin";
  String MI = "G";
  String LName = TN.toString();

  int PN1 = 0;
  int PN2 = 0;
  int PN3 = 0;

	int priority = 0;

  bool Both = false;
  bool Text = true;

  for (var fv1 = ContactL.length; fv1 < TN; fv1++)
  {
    priority++;
		PN3 = priority % 10000;
    PN2 += (((PN3++) > 9999) ? 1: 0); 
    PN1 += ((PN2 > 999) ? 1 : 0); 
    ContactL.add(Contact(PName, MI, LName, PN1, PN2, PN3, Both, Text, priority));
  }

  return CreateList(ContactL, context);

}

int StrAInt(String? number)
{
	int SYA(int add, int value) // shift y add
	{
		return (value * 10) + add;
	}

	if (number == null)
	{
		return 0;
	}
	int value = 0;
	number.split('').forEach((element) 
	{
		switch (element)
		{
			case "0":
			{
				value = SYA(0, value);
			}break;
			case "1":
			{
				value = SYA(1, value);
			}break;
			case "2":
			{
				value = SYA(2, value);
			}break;
			case "3":
			{
				value = SYA(3, value);
			}break;
			case "4":
			{
				value = SYA(4, value);
			}break;
			case "5":
			{
				value = SYA(5, value);
			}break;
			case "6":
			{
				value = SYA(6, value);
			}break;
			case "7":
			{
				value = SYA(7, value);
			}break;
			case "8":
			{
				value = SYA(8, value);
			}break;
			case "9":
			{
				value = SYA(9, value);
			}break;
		}
	});
	return value;
}


//icons
const CEDIT   = Icons.edit;           // contact edit
const CDELETE = Icons.delete_outline; // contact delete
const CADD    = Icons.add;            // contact add
const HOME    = Icons.home;