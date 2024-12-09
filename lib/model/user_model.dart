class UserModel {
  final String day;
  final String month;
  final String year;
  final String name;
  final String gender;
  final String image;

  UserModel({
    required this.day,
    required this.month,
    required this.year, 
    required this.name, 
    required this.gender,
    required this.image,
    });

  toJson(){
    return{
      "name":name,
      "day":day,
      "month": month,
      "year":year,
      "gender":gender,
      "image_path":image,
    };
  }
  
}