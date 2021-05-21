import 'package:snap/myfood.dart';

class foodS{
  static List<myfood> myfoods = List.empty(growable: true);
  static List<myfood> seaFoods = List.empty(growable: true);
  static List<myfood> fastFoods = List.empty(growable: true);
  static List<myfood> homes = List.empty(growable: true);
  static void addFood(myfood s){
    myfoods.add(s);
  }
  static void addSeaFood(myfood s){
    seaFoods.add(s);
  }
  static void addFastFood(myfood s){
    fastFoods.add(s);
  }
  static void addHome(myfood s){
    homes.add(s);
  }
   static List<myfood> getFoods(){
    return myfoods;
  }
  static void removeFood(myfood f){
    myfoods.remove(f);
  }
}