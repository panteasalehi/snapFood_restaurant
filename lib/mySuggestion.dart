class mySuggestoin{
  static List<String> SuggestionList = ["your food is awful " , "your food is very awful"];
  static List<String> answerList = List.empty(growable: true);

  static void addComment(String comment){
    SuggestionList.add(comment);
  }
  static void addAnswer(String ans){
    answerList.add(ans);
  }
}