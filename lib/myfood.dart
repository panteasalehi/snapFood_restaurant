class myfood{
  String name;
  String price;
  bool state;
  String description;
  bool hasPic;
  String picAdd;
  myfood( String name , String price,bool state,String description , bool hasPic){
    this.name =  name;
    this.price = price;
    this.state = state;
    this.description = description;
    this.hasPic = hasPic;
  }
  String getname (){
    return name;
  }
  String getpicAdd(){
    return picAdd;
  }
  String getprice (){
    return price;
  }
  String getdescription (){
    return description;
  }
  bool getstate(){
    return state;
  }

}