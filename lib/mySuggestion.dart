class mySuggestoin{
  static List<String> SuggestionList = ["your food is awful " , "your food is very awful" , "your food is not bad" , "yor food is very good"];
  static List<String> answerList = List.empty(growable: true);

  static void addComment(String comment){
    SuggestionList.add(comment);
  }
  static void addAnswer(String ans){
    answerList.add(ans);
  }
}