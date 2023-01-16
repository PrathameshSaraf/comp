//
// class PhotoUpload{
//   String id;
//   String imageUrl;
//   String Gender;
//   String HairStyle;
//   String Color;
//
//   PhotoUpload({
//     required this.id,
//     required this.imageUrl,
//     required this.Gender,
//     required this.HairStyle,
//     required this.Color,
//   });
//
//   Map<String ,dynamic>toMap()
//   {
//     return {
//       'id':id,
//       'imageUrl': imageUrl,
//       'Gender': Gender,
//       'hairStyle':HairStyle,
//       'color':Color,};
//   }
//
//   // static fromJson(Map<String,dynamic>json)=>PhotoUpload(
//   //   id:json['id'],
//   //   imageUrl:json['imageUrl'],
//   //   Gender:json['Gender'],
//   //   HairStyle:json['hairStyle'],
//   //   Color:json['color'],
//   // );
//   //
//   List<PhotoUpload> toMenuModel( c) {
//     List<PhotoUpload> photos = [];
//     for (var m in c) {
//       photos.add(PhotoUpload(
//           id: m.id, imageUrl: m.imageUrl,Gender: m.Gender,HairStyle: m.HairStyle,Color: m.Color
//       ));
//     }
//     return photos;
//   }
// }

class Photos{
  String name,id,Imagepath,summary;
  List<String> Categories,AdditionalPhotos;
  String LongDes1;
  Photos({required this.name,required this.id,required this.Categories,required this.AdditionalPhotos,required this.Imagepath,required this.summary,required this.LongDes1});

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "name": name,
      "Imagepath":Imagepath,
      "summary":summary,
      "Categories":Categories,
      "AdditionalPhotos":AdditionalPhotos,
      "LongDes1":LongDes1,

    };
  }
  factory Photos.fromMap(Map<String, dynamic> map) {
    return Photos(
      id: map['id'],
      name: map['name'],
      summary: map['summary'],
      Imagepath: map['Imagepath'],
      AdditionalPhotos: map['AdditionalPhotos'],
      Categories: map['Categories'],
      LongDes1: map['LongDes1'],

    );
  }
}