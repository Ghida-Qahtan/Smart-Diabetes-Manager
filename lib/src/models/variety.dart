
  class Variety {
  int _id;
  int _mealId;
  String _email;
  String _eat;
  double _carb;
  int _amount;


 // Meal(this._email, this._mealId, this._eat,this._amount);
  Variety(this._id,this._mealId, this._email, this._eat,this._carb,this._amount);

  int get id => _id;
  int get mealId => _mealId;
  String get email => _email;
  String get eat => _eat;
  double get carb => _carb;
  int get amount => _amount;

  set id(int newint) => _id = newint;
  set mealId(int newint) => _mealId = newint;
  set email(String newemail) => _email = newemail;
  set eat(String neweat) => _eat = neweat;
  set carb(double newcarb) => _carb = newcarb;
  set amount(int newamount) => _amount = newamount;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
   
    map['id'] = _id;
    map['mealId'] = _mealId;
    map['email']=_email;
    map['eat'] = _eat;
    map['carb'] = _carb;
    map['amount'] = _amount;
    return map;
  }

  Variety.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];   
    this._mealId = map['mealId'];   
    this._email = map['email'];
   // this._id = map['id'];   
    this._eat = map['eat'];
    this._carb = map['carb'];
    this._amount = map['amount'];

  }
}
