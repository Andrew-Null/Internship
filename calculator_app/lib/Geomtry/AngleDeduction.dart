import 'Angle.dart';
Map<String, Radian> Triangle(Angle? A, 
Angle? B, 
Angle? C)
{
	Map<String, Radian> ret = {};

	if (A != null)
	{
		if (A is Radian)
		{
			ret["A"] = A;
		}
		else if (A is Degree)
		{
			ret["A"] = A.Convert();
		}
		else
		{
			throw "A is impossibly an abstract Angle class";
		}
	}

	if (B != null)
	{
		if (B is Radian)
		{
			ret["B"] = B;
		}
		else if (B is Degree)
		{
			ret["B"] = B.Convert();
		}
		else
		{
			throw "B is impossibly an abstract Angle class";
		}
	}

	if (C != null)
	{
		if (C is Radian)
		{
			ret["C"] = C;
		}
		else if (C is Degree)
		{
			ret["C"] = C.Convert();
		}
		else
		{
			throw "C is impossibly an abstract Angle class";
		}
	}

	int nn = 0; // not null
	nn += A != null ? 1 : 0;
	nn += B != null ? 1 : 0;
	nn += C != null ? 1 : 0;

	int which = 0;
	which = which | (A != null ? 1 : 0);
	which = which | (B != null ? 2 : 0);
	which = which | (C != null ? 4 : 0);

	if (nn == 2)
	{

		if (which & 1 == 0)
		{
			
		}
		else if (which & 2 == 0)
		{
			
		}
		else if (which & 4 == 0)
		{
			
		}
	}

	return ret;
}