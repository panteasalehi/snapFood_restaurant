import 'package:snap/signUp.dart';
class users{
 static List<signUp> myUsers = List.empty(growable: true);
 static void addUser(signUp s){
    myUsers.add(s);
  }
 static void removeUser(signUp s){
   myUsers.remove(s);
 }
  static List<signUp> getUsers(){
    return myUsers;
  }
}