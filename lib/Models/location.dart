
class Location{
  String id,name,location,contact,city,branch,address,state;

  Location({
    required this.id,
    required this.name,
    required this.location,
    required this.state,
    required this.address,
    required this.branch,
    required this.city,
    required this.contact
  });
  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "name": name,
      "location":location,
      "address":address,
      "branch":branch,
      "city":city,
      "state":state,
      "contact":contact
    };
  }


  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      contact: map['contact'],
      address: map['address'],
      branch: map['branch'],
      city: map['city'],
      state: map['state']
    );
  }

}