abstract class EndPoints
{
  static const String ecoBaseUrl ='https://nti-ecommerce-api-production-74b6.up.railway.app/api/';
  static const String login = 'login';
  static const String register = 'register';
  static const String getUserData = 'get_user_data';
  static const String getMenu = 'categories';
  static const String refreshToken = 'refresh_token';
  static const String logout = 'delete_user';
  static const String bestSeller = 'best_seller_products';
  static const String slider = 'sliders';
  static const String topRated = 'top_rated_products';
  static const String products = 'products';
  static String search({
    required String q,
  }) {
    return 'products/search?q=$q';
  }
  static const String UpdateProfile='update_profile';
  static const String PlaceOrder='place_order';
  static const String Order='orders';
  static String CancelOrder({
    required int id,
  }){
    return 'orders/cancel/$id';
  }



}