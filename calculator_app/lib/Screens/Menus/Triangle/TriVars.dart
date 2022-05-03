// ignore_for_file: constant_identifier_names, non_constant_identifier_names, library_prefixes
import 'package:flutter/material.dart';

import '../../../Geometry/Geometry.dart' as Geo;

bool RMode = false; //Radian Mode
const DEFAULTPAD = 1.0;

List<String> TxtLabels =
[
  "Angle A",
  "Angle B",
  "Angle C",
  "Side a",
  "Side b",
  "Side c"
];

List<TextEditingController> TxtControllers =
[
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController()
];

List<Geo.Primitive2D?> Values =
[
  null,
  null,
  null,
  null,
  null,
  null
];

List<bool> HasPi = [false, false, false];

enum SyAIE //side and angles index enum
{
	AA,
	AB,
	AC,
	sa,
	sb,
	sc
}

enum AngIndex
{
  a,
  b,
  c
}

enum Contents
{
  None, //null
  Side,
  Angle
}
