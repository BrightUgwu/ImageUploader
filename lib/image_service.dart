
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as ob;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class ImageService {
var resultdata = "";

Map mapResponse = {}.obs;

  Future<dynamic> postImage(File image) async {

    try {
      FormData data = FormData.fromMap({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'serial eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjpbeyJjcmVhdGVkQXQiOiIxNS0wMi0yMDIyIDA2OjI3OjEzIiwidXBkYXRlZEF0IjoiMTUtMDItMjAyMiAwNjoyNzoxMyIsImNyZWF0ZWRCeSI6Ik1HUiIsIm1vZGlmaWVkQnkiOiJNR1IiLCJpZCI6MTMsIm5hbWUiOiJST0xFX1VTRVJfT1dORVIiLCJkZXNjcmlwdGlvbiI6IlVTRVIgUk9MRSIsImRlZmF1bHQiOnRydWV9LHsiY3JlYXRlZEF0IjoiMTUtMDItMjAyMiAwNjoyNzoxMyIsInVwZGF0ZWRBdCI6IjE1LTAyLTIwMjIgMDY6Mjc6MTMiLCJjcmVhdGVkQnkiOiJNR1IiLCJtb2RpZmllZEJ5IjoiTUdSIiwiaWQiOjEzLCJuYW1lIjoiUk9MRV9VU0VSX09XTkVSIiwiZGVzY3JpcHRpb24iOiJVU0VSIFJPTEUiLCJkZWZhdWx0Ijp0cnVlfSx7ImNyZWF0ZWRBdCI6IjE1LTAyLTIwMjIgMDY6Mjc6MTMiLCJ1cGRhdGVkQXQiOiIxNS0wMi0yMDIyIDA2OjI3OjEzIiwiY3JlYXRlZEJ5IjoiTUdSIiwibW9kaWZpZWRCeSI6Ik1HUiIsImlkIjoxNSwibmFtZSI6IlJPTEVfVVNFUl9BRE1JTiIsImRlc2NyaXB0aW9uIjoiQ09SUE9SQVRFIEFETUlOIFJPTEUiLCJkZWZhdWx0Ijp0cnVlfV0sImlkIjoxNzA1LCJzdWIiOiJjbGVhbkB5b3BtYWlsLmNvbSIsImlhdCI6MTY3NTEwMDc3NiwiZXhwIjoxNzA2NjU4Mzc2fQ.FDBkz_cyqK8tjWM6ajiG9HE-SEyqnLzzRQhPMiuC5DdCMWDzQy9CjxqFbHXzsjtFUXtPPYFcj1jU8gG-g550YA',
        'file': await MultipartFile.fromFile(image.path),
      });

      var dio = Dio();
      var response = await dio.post(
          "https://services.staging.wayapos.ng/file-resource-service/upload/profile-picture/1705",
          data: data, onSendProgress: (int sent, int total) {
        print("PROGRESSBAR: $sent $total");
      });
      print("UploadResponseCODE: ${response.statusCode}");
      print("UploadResponse: ${response.data}");
      resultdata = response.data;
      print("UploadResponseMSG: ${response.statusMessage}");
      mapResponse = json.decode(response.data);
      print("HELLOMAP: ${mapResponse}");

      if (response.statusCode == 200) {
        print("BASTARD");

        return response.data;
      }
    }catch(e){
      print("HELLOBAD ${e}");
    }
  }



  Future uploadImage(File image) async {
      final request = http.MultipartRequest('POST',
      Uri.parse("https://services.staging.wayapos.ng/file-resource-service/upload/profile-picture/1705"));
      request.fields["Authorization"] = "serial eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjpbeyJjcmVhdGVkQXQiOiIxNS0wMi0yMDIyIDA2OjI3OjEzIiwidXBkYXRlZEF0IjoiMTUtMDItMjAyMiAwNjoyNzoxMyIsImNyZWF0ZWRCeSI6Ik1HUiIsIm1vZGlmaWVkQnkiOiJNR1IiLCJpZCI6MTMsIm5hbWUiOiJST0xFX1VTRVJfT1dORVIiLCJkZXNjcmlwdGlvbiI6IlVTRVIgUk9MRSIsImRlZmF1bHQiOnRydWV9LHsiY3JlYXRlZEF0IjoiMTUtMDItMjAyMiAwNjoyNzoxMyIsInVwZGF0ZWRBdCI6IjE1LTAyLTIwMjIgMDY6Mjc6MTMiLCJjcmVhdGVkQnkiOiJNR1IiLCJtb2RpZmllZEJ5IjoiTUdSIiwiaWQiOjEzLCJuYW1lIjoiUk9MRV9VU0VSX09XTkVSIiwiZGVzY3JpcHRpb24iOiJVU0VSIFJPTEUiLCJkZWZhdWx0Ijp0cnVlfSx7ImNyZWF0ZWRBdCI6IjE1LTAyLTIwMjIgMDY6Mjc6MTMiLCJ1cGRhdGVkQXQiOiIxNS0wMi0yMDIyIDA2OjI3OjEzIiwiY3JlYXRlZEJ5IjoiTUdSIiwibW9kaWZpZWRCeSI6Ik1HUiIsImlkIjoxNSwibmFtZSI6IlJPTEVfVVNFUl9BRE1JTiIsImRlc2NyaXB0aW9uIjoiQ09SUE9SQVRFIEFETUlOIFJPTEUiLCJkZWZhdWx0Ijp0cnVlfV0sImlkIjoxNzA1LCJzdWIiOiJjbGVhbkB5b3BtYWlsLmNvbSIsImlhdCI6MTY3NTEwMDc3NiwiZXhwIjoxNzA2NjU4Mzc2fQ.FDBkz_cyqK8tjWM6ajiG9HE-SEyqnLzzRQhPMiuC5DdCMWDzQy9CjxqFbHXzsjtFUXtPPYFcj1jU8gG-g550YA";
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      var reqResponse = await request.send();

      reqResponse.stream.transform(utf8.decoder).listen((value) {
        var jsonResPonse = jsonDecode(value) as Map<String,dynamic>;

        if(reqResponse.statusCode == 200){
          print("HELLOIGOT: ${reqResponse.statusCode}");
        }
        print("OTHERWIZE: ${reqResponse.statusCode}");
      });

      print("OTHERWIZEOZ: ${reqResponse.statusCode}");
      print("OTHERWIZEOZREQ: ${reqResponse.request}");
      print("OTHERWIZEOZ: ${reqResponse.stream}");

  }




  }
  