// ignore_for_file: non_constant_identifier_names, constant_identifier_names

//import 'dart:convert';

import 'dart:math';

import '../Angle.dart';
import '../Side.dart';
import '../Geometry.dart';
import '../../Common/Misc.dart';

//typedef Match(Side? s, Angle? a);
//typedef One = bool;
//typedef SineLaw(LDS known, Primitive unknown);

class LDS //law de sine
{
  late double angle;
  late double side;

  LDS(Side s, Angle A)
  {
    if (A is Radian)
    {
      angle = s.length / A.Sine();
      side = A.Sine() / s.length;
    }
    else
    {
      num rad = Radian((A as Degree).value * Angle.AR, true).Sine();
      side =  rad / s.length;
      side = s.length / rad;
    }
  }
}

enum Known
{
  Neither,
  Side,
  Angle,
  Both
}

class Triangle extends Polygon
{
  static Primitive LawOfSines(LDS known, Primitive unknown)
  {
    if (unknown is Side) 
    {
      return _FAngle(known, unknown);
    }
    else if (unknown is Angle)
    {
      return _FSide(known, unknown);
    }
    throw 'LawOfSines has recieved a Point Class';
  }

  static Radian _FAngle(LDS known, Side unknown) //find angle
  {
    return Radian(known.angle * unknown.length, true);
  }

  static Side _FSide(LDS known, Angle unknown)
  {
    if (unknown is Radian)
    {
      return Side(known.side * unknown.Sine());
    }
    if (unknown is Degree)
    {
      return Side(known.side * unknown.Convert().Sine());
    }
    throw 'LawOSine has recieved what should be an impossible (abstract) input';
  }

  Triangle Solve //constructor in progress
  (
    Side? pa, Side? pb, Side? pc, 
    Angle? PA, Angle? PB, Angle? PC
  )
  {
    //given
    final dynamic GivenZ = ((pa != null) && (PA != null)) ? LDS(pa, PA) : false;
    final dynamic GivenY = ((pb != null) && (PB != null)) ? LDS(pb, PB) : false;
    final dynamic GivenX = ((pc != null) && (PC != null)) ? LDS(pc, PC) : false;

    //only check each for null once
    //b is for bool
    bool bpa = pa != null;
    bool bpb = pb != null;
    bool bpc = pc != null;
    //so is B
    bool BPA = PA != null;
    bool BPB = PB != null;
    bool BPC = PC != null;

    //Ternary madness
    final Known zGiven = XOR(bpa, BPA) ?
     (bpa ? Known.Side : Known.Angle ) : ((BPA && GivenZ != false) ? Known.Both : Known.Neither);

    final Known yGiven = XOR(bpb, BPB) ?
     (bpb ? Known.Side : Known.Angle ) : ((BPB && GivenY != false) ? Known.Both : Known.Neither);
    
    final Known xGiven = XOR(bpc, BPC) ?
     (bpc ? Known.Side : Known.Angle ) : ((BPC && GivenX != false) ? Known.Both : Known.Neither);

    //Start 
    //Angle 
    //Deduction
    double AngTot = 180;
    int debductions = 0;
    int which = 0;
    if (PA != null)
    {
      if (PA is Degree)
      {
        AngTot -= PA.value;
        debductions += 1;
        which = which | 1;
      }
      else if (PA is Radian)
      {
        
        AngTot -= PA.Convert().value;
        debductions += 1;
        which = which | 1;
      }
      else { throw "PA impossibly is the abstract Angle class";}
    }

    if (PB != null)
    {
      if (PB is Degree)
      {
        AngTot -= PB.value;
        debductions += 1;
        which = which | 2;
      }
      else if (PB is Radian)
      {
        AngTot -= PB.Convert().value;
        debductions += 1;
        which = which | 2;
      }
      else { throw "PB impossibly is the abstract Angle class";}
    }

    if (PC != null)
    {
      if (PC is Degree)
      {
        AngTot -= PC.value;
        debductions += 1;
        which = which | 4;
      }
      else if (PC is Radian)
      {
        
        AngTot -= PC.Convert().value;
        debductions += 1;
        which = which | 4;
      }
      else { throw "PC impossibly is the abstract Angle class";}
    }

    if (debductions == 2)
    {
      if (which & 1 == 0 && which & 2 == 2 && which & 4 == 4)
      {
        PA ??= Degree(AngTot);
      }
      else if (which & 1 == 1 && which & 2 == 0 && which & 4 == 4)
      {
        PB ??= Degree(AngTot);
      }
      else if (which & 1 == 1 && which & 2 == 2 && which & 4 == 0)
      {
        PC ??= Degree(AngTot);
      }
    }
    //End 
    //Angle
    //Deduction

    if (GivenZ != false || GivenY != false || GivenX != false)
    {//time for law of sines

      LDS good = (GivenZ != false ? GivenZ : (GivenY != false ? GivenY : GivenX));

      if (zGiven == Known.Angle)
      {
        pa = Side(asin(
          good.angle * (PA is Radian ? PA.value : 
        PA is Degree ? PA.Convert().value : throw "PA is an impossible abstract Angle class")));
      }
      else if (zGiven == Known.Side && pa is Side)
      {
        PA = Radian
        (
          asin(good.side * pa.length), true
        );
      }

      if (yGiven == Known.Angle)
      {
        pb = Side(asin(
          good.angle * (PB is Radian ? PB.value : 
        PB is Degree ? PB.Convert().value : throw "PB is an impossible abstract Angle class")));
      }
      else if (yGiven == Known.Side && pb is Side)
      {
        PB = Radian
        (
          asin(good.side * pb.length), true
        );
      }

      if (xGiven == Known.Angle)
      {
        pc = Side(asin(
          good.angle * (PC is Radian ? PC.value : 
        PC is Degree ? PC.Convert().value : throw "PC is an impossible abstract Angle class")));
      }
      else if (xGiven == Known.Side && pc is Side)
      {
        PC = Radian
        (
          asin(good.side * pc.length), true
        );
      }

    }
    return Triangle();
  }
}