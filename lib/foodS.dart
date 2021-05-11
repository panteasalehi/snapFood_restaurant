import 'package:snap/myfood.dart';

class foodS{
  static List<myfood> myfoods = List.empty(growable: true);
  static void addFood(myfood s){
    myfoods.add(s);
  }
  static List<myfood> getFoods(){
    return myfoods;
  }

}