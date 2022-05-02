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