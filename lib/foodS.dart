import 'package:snap/addUser.dart';
import 'package:snap/myfood.dart';
import 'dart:io';
import 'package:snap/users.dart';
class foodS{
  static List<myfood> myfoods = List.empty(growable: true);
  static List<myfood> seaFoods = List.empty(growable: true);
  static List<myfood> fastFoods = List.empty(growable: true);
  static List<myfood> homes = List.empty(growable: true);
  static void addFood(myfood s, int index){
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
