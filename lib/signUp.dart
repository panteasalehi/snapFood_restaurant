class signUp{
  String name;
  String address;
  String type;
  String phoneNumber;
  String password;

  signUp(String name,String address, String type, String phoneNumber , String password){
    this.name = name;
    this.address = address;
    this.type = type;
    this.phoneNumber = phoneNumber;
    this.password = password;
  }
  String getName(){
    return name;
  }
  String getAddress(){
    return address;
  }
  String getType(){
    return type;
  }
  String getPhoneNumber(){
    return phoneNumber;
  }
  String getpassword(){
    return password;
  }

}