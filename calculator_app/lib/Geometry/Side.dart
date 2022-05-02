import 'Point.dart' as Point;
import 'Geometry.dart' as Geo;



class Side extends Geo.Primitive2D
{
  late num length;

  Side(num l)
  {
    length = l;
  }
}

class DePoints extends Side
{
  late Point.Point A;
  late Point.Point B;
  DePoints(Point.Point a, b) : super(Point.Distance(a,b)) 
  {
    A = a;
    B = b;
  }
}