import '../Angle.dart';
import '../Side.dart';

typedef Match = bool;
typedef One = bool;
class Triangle
{
  void TempTriangle //constructor in progress
  (
    Side? a, Side? b, Side? c, 
    Angle? A, Angle? B, Angle? C
  )
  {
    Match Z = (a != null) && (A != null);
    Match Y = (b != null) && (B != null);
    Match X = (c != null) && (C != null);

    One z = (a != null) || (A != null);
    One y = (b != null) || (B != null);
    One x = (c != null) || (C != null);
  }
}