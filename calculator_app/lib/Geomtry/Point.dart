// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'dart:math';

typedef float = double;

class Point extends Primitive
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
    return other.X == X && other.Y == Y;
  }
}

num Distance(Point A, Point B)
{
  num AX = A.X;
  num AY = A.Y;
  
  num BX = B.X;
  num BY = B.Y;

  return sqrt(pow((AX - BX),2) + pow((AY- BY), 2));
}