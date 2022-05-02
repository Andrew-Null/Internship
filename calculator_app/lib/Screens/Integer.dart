// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types, unused_import, library_prefixes

import 'package:flutter/material.dart';
import '../main.dart' as main;
import '../Common/Numpad.dart' as NP;
import '../Common/Math.dart' as Math;
import 'Menus/MMenu.dart' as MM;

List<int> _nms = [0, 0];
Math.ASDMOPs? _op;

NP.Numpad _NPad = NP.Numpad();

class Expression
{
	late num Left;
	late num Right;
	late Math.ASDMOPs op;

	Expression(int l, int r, Math.ASDMOPs o)
	{
		Left = l;
		Right = r;
		op = o;
	}
}

int WI() //which index
{
	return _op != null ? 1 : 0;
}

Scaffold IntCalc(BuildContext context)
{

	void IntEvaluate()
	{

    if (_op != null)
    {
      _nms[0] = Math.EvalASDM(_nms[0], _nms[1], _op as Math.ASDMOPs) as int;

  	  _nms[1] = 0;
		  _op = null;

		  main.app.Refresh; 
    }
	}
	
	void Clear()
	{
		_NPad.Reset();
		if (_op != null)
		{_nms[1] = 0;}
		else if (_op != null && _nms[1] != 0)
		{_op = null;}
		else
		{
			_nms = [0,0];
			_op = null;
		}
		main.app.Refresh;
	}
	
	TextButton GOpButton(Math.ASDMOPs eop)
	{
		late String symbol;

		switch (eop)
		{
			case Math.ASDMOPs.Add:
			{
				symbol = "+";
			}break;
			case Math.ASDMOPs.AprxDiv:
			{
				symbol = "~/";
			}break;
			case Math.ASDMOPs.Div:
			{
				symbol = "/";
			}break;
			case Math.ASDMOPs.Mod:
			{
				symbol = "%";
			}break;
			case Math.ASDMOPs.Mul:
			{
				symbol = "*";
			}break;
			case Math.ASDMOPs.Sub:
			{
				symbol = "-";
			}break;
			default:
			{
				symbol = "err";
			}
		}

		return TextButton(child: Text(symbol), onPressed: () 
		{

			if (_op != null)
			{
				_nms[0] = Math.EvalASDM(_nms[0], _nms[1], _op as Math.ASDMOPs) as int;
				_nms[1] = 0;
			}

			_op = eop;
			assert(_op != null, "op unassigned"); 
			_NPad.Reset();
			_nms[1] = 0;
			main.app.Refresh;
		});
	}


	num ETotal()
	{
		return _NPad.GTotal();
	}

	_NPad.Update(()
	{
		_nms[(_op != null) ? 1 : 0] = ETotal() as int;
		main.app.Refresh;
	});

	_NPad.Buttons(DecimalB: TextButton(child: const Text("Clear"), onPressed: () 
		{
			Clear();
		}));

	return Scaffold(body: Center(child: 
	Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
			children: 
			[
				Center(child: Column(
				children: [
					Align
					(
						child: Text(_nms[(_op  != null) ?1: 0].toString()), 
						alignment:  Alignment.topCenter
					),
					Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
						children: [ 
						_NPad.Build(), 
						Column(children:
							[
								GOpButton(Math.ASDMOPs.Add),
								GOpButton(Math.ASDMOPs.Sub),
								GOpButton(Math.ASDMOPs.Mul),
								GOpButton(Math.ASDMOPs.AprxDiv)
							]
						),
						Column(children: 
						[
							TextButton(child: const Text("="),    onPressed: () {IntEvaluate();},),
							TextButton(child: const Text("<<"),         
								onPressed: () 
								{
									int wi = WI();
									_nms[wi] = _nms[wi] << 1;
									main.app.Refresh;
								},
							),
							TextButton(child: const Text(">>"),     
								onPressed: ()
							{
								_nms[WI()] = _nms[WI()] >> 1; 
								_NPad.STotal(_nms[WI()]); 
								main.app.Refresh;
							}
							),
						]) 
					]),
					MM.MMB()  
				])
			)
		]),
	));
}