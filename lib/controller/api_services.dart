import 'dart:convert';
//import 'dart:html';
//import 'package:classy_ecom_project/model/all_product.dart';
import 'package:classy_ecom_project/http_end_point.dart';
import 'package:classy_ecom_project/model/all_product_model.dart';
import 'package:classy_ecom_project/model/log_in_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiRequest with ChangeNotifier{
  // List<AllProduct> productsResponseFromJson(List<dynamic> data) {
  //   return List<AllProduct> products=data.map((e) => AllProduct.fromJson(e).toList());
  // }
  // List<AllProduct>.from(
  //     json.decode(str).map((x) => AllProduct.fromJson(x)));
  //List<Products> productList = <Products>[];
  Future allProductApiRequest() async {
    final response = await http.get(Uri.parse(
        'https://classyecommerce.excelitaiportfolio.com/api/products'));
    if (response.statusCode == 200) {
      final responseList = json.decode(response.body);
      //AllProductModel products=responseList.map((e) => AllProductModel.fromJson(e));
      AllProductModel products = AllProductModel.fromJson(responseList);
      return products.products;
      //   responseList.map((data) {
      //   return AllProductModel.fromJson(data);
      // }).toList();
    } else {
      throw Exception('Failed to load post');
    }
    //return ;
  }

//   Future<LoginApiResponse> apiCallLogin(Map<String, dynamic> param) async {
//     var url = Uri.parse('https://api.sakkhar.com/api/login');
//     var response = await http.post(url, body: param);
//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');
//
//     //print(await http.read(Uri.parse('https://api.sakkhar.com/api/login')));
//     final data = jsonDecode(response.body);
// //    if(response.statusCode.toString()=="201"){
// //      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ProductList()), (route) => false);
// //      print(">>>>>>"+response.statusCode.toString()+"<<<<<<<<<");
// //      return LoginApiResponse(token: data["token"], error: data["error"],status: "${response.statusCode}");
// //    }
//     return LoginApiResponse(
//       token: data["token"],
//       error: data["error"],
//       status: "${response.statusCode}",
//     );
//   }

  Future SignInApiRequest(Map<String,dynamic> param,BuildContext context) async {

    final response = await http.post(Uri.parse(logInApi),body: param);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');


    if (response.statusCode == 200){
      final dataList = jsonDecode(response.body);
      //LogInDataModel logindata=LogInDataModel().fromJson(dataList);
      final loginData=Provider.of<LogInDataModel>(context,listen: false);
      loginData.fromJson(dataList);
      //LogInDataModel list=LogInDataModel.fromJson(data);
      //List<LogInDataModel> logInDataList=dataList.map((data) => LogInDataModel.fromJson(data)).toList();
      print(loginData.message.toString());
      return loginData;//logindata.message;//data.map((e) => LogInDataModel.fromJson(e)).toList();
    }else{
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

class SignInApiResponse {
  String? token;
  String? error;
  String? status;

  SignInApiResponse({this.token, this.error, this.status});
}
