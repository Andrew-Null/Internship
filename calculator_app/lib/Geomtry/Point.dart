// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'dart:ffi';
import 'dart:math';

typedef float = double;

class Point
{
  late num X;
  late num Y;

  Point(num x, y)
  {
    X = x;
    Y = y;
  }

  bool Equal(Point other)
  {
    return other.GX == X && other.GY == Y;
  }

  num get GX {return X;}
  num get GY {return Y;}
}

num Distance(Point A, Point B)
{
  num AX = A.GX;
  num AY = A.GY;
  
  num BX = B.GX;
  num BY = B.GY;

  return sqrt(pow((AX - BX),2) + pow((AY- BY), 2));
}