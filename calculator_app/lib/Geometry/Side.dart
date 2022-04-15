import 'Point.dart';
import 'Geometry.dart';

class Side extends Primitive2D
{
  late num length;

  Side(num l)
  {
    length = l;
  }
}

class DePoints extends Side
{
  late Point A;
  late Point B;
  DePoints(Point a, b) : super(Distance(a,b)) 
  {
    A = a;
    B = b;
  }
}