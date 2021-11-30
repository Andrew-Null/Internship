// ignore_for_file: file_names, constant_identifier_names, non_constant_identifier_names

enum Operation
{
  Add,
  Sub,
  Div, // for floats
  Mod // remainder
}

NType? Eval<NType>(NType Num1, NType Num2, Operation Op)
{

  if (NType is int || NType is double || NType is num)
  {
    

    switch (Op)
    {
      case Operation.Add:
      {
        if (NType is int)
        {
          return ((Num1 as int) + (Num2 as int)) as NType;
        }
        else if (NType is double)
        {
          return ((Num1 as double) + (Num2 as double)) as NType;
        }
        else
        {
          return ((Num1 as num) + (Num2 as num)) as NType;
        }
      }
      case Operation.Sub:
      {
        if (NType is int)
        {
          return ((Num1 as int) - (Num2 as int)) as NType;
        }
        else if (NType is double)
        {
          return ((Num1 as double) - (Num2 as double)) as NType;
        }
        else
        {
          return ((Num1 as num) - (Num2 as num)) as NType;
        }
      }
      case Operation.Div:
      {
        if (NType is int)
        {
          return ((Num1 as int) ~/ (Num2 as int)) as NType;
        }
        else if (NType is double)
        {
          return ((Num1 as double) / (Num2 as double)) as NType;
        }
        else
        {
          return ((Num1 as num) / (Num2 as num)) as NType;
        }
      }
      case Operation.Mod
      {
        if (NType is int)
        {
          return ((Num1 as int) % (Num2 as int)) as NType;
        }
        else if (NType is double)
        {
          return ((Num1 as double) % (Num2 as double)) as NType;
        }
        else
        {
          return ((Num1 as num) % (Num2 as num)) as NType;
        }
      }
      default:
      {
        return null;
      }
    }
  } 
  else
  {
    return null;
  }
}