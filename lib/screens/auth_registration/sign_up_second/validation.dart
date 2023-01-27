
bool checkEmail ({required String email}){
  String goodLetters = 'abcdefghijklmnopqrstuvwxyz1234567890_-.@';
  for (String i in email.toLowerCase().split('')) {
    if (goodLetters.contains(i) == false) {
      return true;
    }
  }
  if (email.contains('@') == false){
    return true;
  }
  List<String> partsEmail = email.split('@');
  if (partsEmail[0].length < 2) {
    return true;
  }
  if (partsEmail[1].length < 3) {
    return true;
  }
  if (partsEmail[1].contains('.') == false) {
    return true;
  }

  if (partsEmail[1].split('.')[0].isEmpty) {
    return true;
  }
  if (partsEmail[1].split('.')[1].length < 2) {
    return true;
  }
  return false;
}

bool checkPassword ({required String password}){
  String goodLetters = 'abcdefghijklmnopqrstuvwxyz1234567890';
  for (String i in password.toLowerCase().split('')) {
    if (goodLetters.contains(i) == false) {
      return false;
    }
  }
  return true;
}