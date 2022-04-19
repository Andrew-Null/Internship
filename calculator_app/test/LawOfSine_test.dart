import '../lib/Geometry/Triangle/Laws.dart';
import '../lib/Geometry/Angle.dart';
import '../lib/Geometry/Side.dart';
import '../lib/Geometry/Geometry.dart';


//import 'package:flutter_test/flutter_test.dart';

void main()
{
  Side a = Side(1);
  Angle A = Degree(75);

  //assert(LDS(a, A).GetSide(Degree(30)).length == 0.5176380902050414);
  print(LDS(a,A).GetSide(Degree(30)).length);

}