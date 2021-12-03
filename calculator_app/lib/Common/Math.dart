// ignore_for_file: file_names, constant_identifier_names, non_constant_identifier_names

//import 'dart:html';

enum ASDMOPs
{
  Add,
  Sub,
  Mul,
  Div, // for doubles
  AprxDiv, // ~/ for ints
  Mod // remainder
}

num EvalASDM(num n1, n2, ASDMOPs op)
{
  
  switch (op)
  {
    case ASDMOPs.Add:
    {
      return n1 + n2;
    }
    case ASDMOPs.Sub:
    {
      return n1 - n2;
    }
    case ASDMOPs.Mul:
    {
      return n1 * n2;
    }
    case ASDMOPs.Div:
    {
      return n1 / n2;
    }
    case ASDMOPs.AprxDiv:
    {
      return n1 ~/ n2;
    }
    case ASDMOPs.Mod:
    {
      return n1 % n2;
    }
  }
  return 0;
}

abstract class BExpression //base expression
{
  void Evaluate();
}

class ASDM extends BExpression
{
  num Num1 = 0;
  num Num2 = 0;
  late ASDMOPs opnum;
  //bool why = false;

  set OP(ASDMOPs op)
  {
    opnum = op;
  }

  set First(num n1)
  {
    Num1 = n1;
  }

  set Second(num n2)
  {
    Num2 = n2;
  }

  @override
  num Evaluate()
  {
    switch (opnum)
    {
      case ASDMOPs.Add:
      {
        return Num1 + Num2;
      }
      case ASDMOPs.Sub:
      {
        return Num1 - Num2;
      }
      case ASDMOPs.Mul:
      {
        return Num1 * Num2;
      }
      case ASDMOPs.Div:
      {
        return Num1 / Num2;
      }
      case ASDMOPs.AprxDiv:
      {
        return Num1 ~/ Num2;
      }
      case ASDMOPs.Mod:
      {
        return Num1 % Num2;
      }
    }
  }

}