class myfood{
  String name;
  String price;

  String description;
  bool hasPic;
  String picAdd;
  myfood( String name , String price,String description , bool hasPic){
    this.name =  name;
    this.price = price;
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

}