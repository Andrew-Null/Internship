// ignore_for_file: file_names, non_constant_identifier_names

//import 'dart:ffi';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:math';
import '../main.dart';
//import '../Screens/Screens.dart';

class Numpad
{
	num total = 0;
	bool float = false;
	int decimal = 0;
	Widget? LB; //left button
	Widget? RB;
	bool neg = false;

	late Function update;

	late double BWidth;
	late double BHeight;
	late double FSize;

	void STotal(num ttl) {total = ttl;}

	TextButton GButton( int BNT) //button number text
	{
		return TextButton(onPressed: () 
		{
			if (float == true)
			{
					total = total + (BNT * pow(10, -1 * (1+ decimal)));
					decimal++;
				}
				else
				{
					total = (total * 10) + BNT;
				}
				update();

				decimal += float ? 1 : 0;
			}, child: Text(BNT.toString()),
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
		return total * (neg ? -1 : 1);
	}

	void Reset()
	{
		neg = false;
		decimal = 0;
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

	}

	void Update(Function fn) 
	{
		update = fn;
	}

}