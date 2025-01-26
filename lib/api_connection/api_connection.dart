class API {
  static const hostConnect = "http://43.74.37.92:8080/geAPI";
  static const hostConnectUser = "$hostConnect/user";
  static const hostConnectSeller = "$hostConnect/seller";
  static const hostConnectRider = "$hostConnect/rider";

  //signup user
  static const validateEmail = "$hostConnectUser/validateemail.php";
  static const signUp = "$hostConnectUser/signupv3.php";
  static const login = "$hostConnectUser/login.php";

  //update user
  static const updateProfile = "$hostConnectUser/updateprofile.dart";
  static const fetchDataProd = "$hostConnectUser/fetchdata.php";

  //Product
  static const addProd = "$hostConnectSeller/addProductv2.php";
  static const imageFetch = "$hostConnectSeller";

  //Seller
  static const validateShopName = "$hostConnectSeller/validateshopname.php";
  static const regShop = "$hostConnectSeller/regShop.php";
  static const validateShopId = "$hostConnectSeller/validateshopid.php";
  static const fetchShop = "$hostConnectSeller/shop.php";

  //Rider
  static const addRider = "$hostConnectRider/addRider.php";
  static const validateRider = "$hostConnectRider/validateriderid.php";
  static const validateLPlate = "$hostConnectRider/validatelplate.php";
}
