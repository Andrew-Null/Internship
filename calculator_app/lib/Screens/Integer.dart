// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types, unused_import

import 'package:flutter/material.dart';
import '../main.dart';
import '../Common/Numpad.dart';
import '../Common/Math.dart';
import 'Menus/MMenu.dart';

List<int> _nms = [0, 0];
ASDMOPs? _op;

Numpad _NPad = Numpad();

class Expression
{
	late num Left;
	late num Right;
	late ASDMOPs op;

	Expression(int l, int r, ASDMOPs o)
	{
		Left = l;
		Right = r;
		op = o;
	}
}

//Map<Expression, int> Memo = {}; //for memoization, not sure if is necessary, but, it is unlikely to hurt
//Map<int, Expression> History {}
//Memo[History[index]] //maybe how history can work
//List<Expression> Exprs //to hod all the expressions rather than having both maps hold dupplicate data

int WI() //which index
{
	return _op != null ? 1 : 0;
}

Scaffold IntCalc(BuildContext context)
{

	void IntEvaluate()
	{

		assert(_op != null, "_op is still null");
		//var e = Expression(_nms[0], _nms[1],_op as ASDMOPs);

		//_nms[0] = Memo[e] ?? AddYRet(e); 

		_nms[1] = 0;
		_op = null;

		app.Refresh; 
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
		app.Refresh;
	}
	
	TextButton GOpButton(ASDMOPs eop)
	{
		late String symbol;

		switch (eop)
		{
			case ASDMOPs.Add:
			{
				symbol = "+";
			}break;
			case ASDMOPs.AprxDiv:
			{
				symbol = "~/";
			}break;
			case ASDMOPs.Div:
			{
				symbol = "/";
			}break;
			case ASDMOPs.Mod:
			{
				symbol = "%";
			}break;
			case ASDMOPs.Mul:
			{
				symbol = "*";
			}break;
			case ASDMOPs.Sub:
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
				_nms[0] = EvalASDM(_nms[0], _nms[1], _op as ASDMOPs) as int;
				_nms[1] = 0;
			}

			_op = eop;
			assert(_op != null, "op unassigned"); 
			_NPad.Reset();
			_nms[1] = 0;
			app.Refresh;
		});
	}


	num ETotal()
	{
		return _NPad.GTotal();
	}

	_NPad.Update(()
	{
		_nms[(_op != null) ? 1 : 0] = ETotal() as int;
		app.Refresh;
	});

	_NPad.Buttons(DecimalB: TextButton(child: const Text("Clear"), onPressed: () 
		{
			Clear();
		}));

	return Scaffold(body: Center(child: 
	Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.center,
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
								GOpButton(ASDMOPs.Add),
								GOpButton(ASDMOPs.Sub),
								GOpButton(ASDMOPs.Mul),
								GOpButton(ASDMOPs.AprxDiv)
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
									app.Refresh;
								},
							),
							TextButton(child: const Text(">>"),     
								onPressed: ()
							{
								_nms[WI()] = _nms[WI()] >> 1; 
								_NPad.STotal(_nms[WI()]); 
								app.Refresh;
							}
							),
						]) 
					]),
					MMB()  
				])
			)
		]),
	));
}