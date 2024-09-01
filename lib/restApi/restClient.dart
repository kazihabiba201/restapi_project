import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restapi_project/style/style.dart';

Future<bool> productCreateRequest(fromValues) async {
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var PostBody = json.encode(fromValues);
  var PostHeader = {"Content-Type": "application/json"};

  var response = await http.post(URL, headers: PostHeader, body: PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody['status'] == "success") {
    successToast("Request Success");
    return true;
  } else {
    errorToast("Request fail ! try again");
    return false;
  }
}

Future<List> productGridViewrequest() async{
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var PostHeader = {"Content-Type": "application/json"};

 var response= await http.get(URL, headers: PostHeader);

  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

   if (ResultCode == 200 && ResultBody['status'] == "success") {
    successToast("Request Success");
    return  ResultBody['data'];
  } else {
    errorToast("Request fail ! try again");
    return [];
  }
}

Future<bool> productDeleteRequest(id) async{
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/"+id);
  var PostHeader = {"Content-Type": "application/json"};

 var response= await http.get(URL, headers: PostHeader);

  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

   if (ResultCode == 200 && ResultBody['status'] == "success") {
    successToast("Request Success");
    return  true;
  } else {
    errorToast("Request fail ! try again");
    return false;
  }
}

Future<bool> ProductUpdateRequest(fromValues,id) async{

  var URL=Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/"+id);

  var PostBody=json.encode(fromValues);

  var PostHeader={"Content-Type":"application/json"};

  var response= await  http.post(URL,headers:PostHeader,body: PostBody);

  var ResultCode=response.statusCode;

  var ResultBody=json.decode(response.body);

  if(ResultCode==200 && ResultBody['status']=="success"){
    successToast("Request Success");
    return true;
  }
  else{
    errorToast("Request fail ! try again");
    return false;
  }
}
