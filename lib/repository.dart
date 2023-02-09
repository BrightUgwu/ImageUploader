import 'package:get_storage/get_storage.dart';


final box = GetStorage();
class LocalRepository{

  GetStorage introdata = GetStorage();

  saveName(name){
    introdata.write("name", name);
  }

  saveImgurl(img){
    introdata.write("img", img);
  }

  static getName() {
    return GetStorage().read("name");
  }

}