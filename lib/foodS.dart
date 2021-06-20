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
    Send("the String is"+s.getname()+"the String is"+s.getprice()+"the String is"+s.getdescription()+"the String is"+users.getUsers().elementAt(index).phoneNumber+"the String is"+users.getUsers().elementAt(index).password+s.state.toString());
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
void Send(String str) async{
  await Socket.connect('192.168.43.165', 1122).then((serverSocket) {
    print('connected');
    String addingFood = "the String isadd food";
    addingFood+=str;
    serverSocket.writeln(addingFood);
  });
}