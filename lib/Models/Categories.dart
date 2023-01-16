

class Categorie {

  String id;
  String title;
  String ImagePath;
  List<dynamic> Cateories;
  String Gender,Description;

  Categorie({required this.id,required this.title,required this.Cateories,required this.ImagePath,required this.Gender,required this.Description});

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "title": title,
      "ImagePath": ImagePath,
      "Categories":Cateories,
      "Gender":Gender,
      "Description":Description
    };
  }


  factory Categorie.fromMap(Map<String, dynamic> map) {
    return Categorie(
      id: map['id'],
      title: map['title'],
      ImagePath: map['ImagePath'],
      Cateories: map['Categories'],
      Gender: map['Gender'],
      Description:map['Description']
    );
  }
}