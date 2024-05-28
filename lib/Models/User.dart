class User{
  String _id="nothing";
  String _name="nothing";
  String _gender="nothing";
  String _birthYear="nothing";
  String _height="nothing";

  String get id => _id;


  User(this._id, this._name, this._gender, this._birthYear,this._height);

  // to convert from json to obj
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
       json["url"],
       json['name'],
       json['gender'],
       json['birth_year'],
       json['height'],
    );
  }

  set id(String value) {
    _id = value;
  }

  String get height => _height;

  set height(String value) {
    _height = value;
  }

  String get name => _name;

  String get birthYear => _birthYear;

  set birthYear(String value) {
    _birthYear = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  set name(String value) {
    _name = value;
  }
}