class mySuggestoin{
  static List<String> SuggestionList ;
  static List<String> answerList = List.empty(growable: true);

  static void addComment(String comment){
    SuggestionList.add(comment);
  }
  static void addAnswer(String ans){
    answerList.add(ans);
  }
}