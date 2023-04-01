import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:api_provider_mvvm_architecture/data/app_exception.dart';
import 'package:api_provider_mvvm_architecture/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiServices extends BaseApiServices{
  @override
  Future<dynamic> getGetApiResponse(dynamic url) async{
    try{
      final response=await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      final data=responseCheck(response);
      return data;
    }
    on SocketException catch(e){
          throw FetchDataException("No internet connection");
    }
  }

  @override
  Future getPostApiResponse(dynamic url,dynamic body) async{
    try{
      final response=await http.post(Uri.parse(url),body: body).timeout(const Duration(seconds: 10));
      final data=responseCheck(response);
      return data;
    }
    on SocketException{
      throw FetchDataException("No internet connection");
    }

  }

  dynamic responseCheck(Response response){
    switch(response.statusCode){
      case 200:
        final decodedData=jsonDecode(response.body);
        return decodedData;
      case 400:
        throw BadRequestException(response.body);
      case 500:
        throw BadRequestException(response.body);
      case 404:
        throw FetchDataException("Error occured while communication with server with status code${response.body}");

    }
  }

}