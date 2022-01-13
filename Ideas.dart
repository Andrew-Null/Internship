class Expression {}
typedef widget = void; //for demonstrational purposes
widget ExampleOne (int HistIndex)
{
  //widget Display
  Map<Expression, int> Memo = {};
  List<Expression> History = [];

  var result = Memo[History[HistIndex]];
  //Display
}

widget ExampleTwo(int HistIndex)
{
  widget Display(Expression exp, int answer) {} //would have definition
  List<Expression> Storage = [];
  List<int> Answers = [];

  Display(Storage[HistIndex], Answers[HistIndex]); //would be returned
}