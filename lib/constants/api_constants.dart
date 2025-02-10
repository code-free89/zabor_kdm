//final String baseUrl = "http://192.168.7.98:3002/";
//final String baseUrl = "https://vr1.elb.cisinlive.com/";
final String baseUrl = "https://api.zaboreats.com/";
final String apiVersion = "";

class Apis {
  // static String login = baseUrl + apiVersion + "user/login";
  static String login = baseUrl + apiVersion + "owner/login";
  static String restaurantList = baseUrl + apiVersion + "user/getrestaurantlist";
  static String orderList = baseUrl + apiVersion + "user/getorders";
  static String orderDetail = baseUrl + apiVersion + "user/order-detail";
  static String paymentUpdateApi = baseUrl + apiVersion + "user/updatePaymentStatus";
  static String updateStatusApi = baseUrl + apiVersion + "user/changeorderstatus";
  static String itemGroupApi = baseUrl + apiVersion + "user/getrestaurantgroups";
  static String itemListApi = baseUrl + apiVersion + "user/getmenuGroup";
  static String updateItemApi = baseUrl + apiVersion + "user/updatemenuItems";
  static String createGroupItemApi = baseUrl + apiVersion + "user/creategroup";
}