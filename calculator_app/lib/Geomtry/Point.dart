// ignore_for_file: file_names, camel_case_types

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

  num get GX {return X;}
  num get GY {return Y;}
}

num Distance(Point A, B)
{
  num AX = A.GX;
  num AY = A.GY;
  
  num BX = B.GX;
  num BY = B.GY;

  return sqrt(pow((AX - BX),2) + pow((AY- BY), 2));
}