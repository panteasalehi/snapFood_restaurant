class signUp{
  String name;
  String address;
  bool isSeaFood;
  bool isFastFood;
  bool home;
  String phoneNumber;
  String password;
  signUp(String name,String address, String phoneNumber , String password ,bool sea , bool home , bool fastfood){
    this.name = name;
    this.address = address;
    this.phoneNumber = phoneNumber;
    this.password = password;
    isFastFood =fastfood;
    this.home=home;
    isSeaFood = sea;
  }
  String getName(){
    return name;
  }
  String getAddress(){
    return address;
  }

  String getPhoneNumber(){
    return phoneNumber;
  }
  String getpassword(){
    return password;
  }

}