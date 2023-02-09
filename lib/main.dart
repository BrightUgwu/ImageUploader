import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload/image_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_upload/repository.dart';
import 'image_service.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    print("MYNAMEIS: ${introData.read("name")}");
// TODO: implement initState
    super.initState();
  }
  LocalRepository localRepository = LocalRepository();
  ImageService imageService = ImageService();
  TextEditingController nameController = TextEditingController();

  File? _image;


  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if(image == null) return;
        var imageTemp = File(image.path);
      print("HEYIGOTIMG: ${introData.read("img")}");
        imageTemp = (await cropImage(imagefile: imageTemp))!;
      imageService.postImage(imageTemp);
        setState(() {
          _image = imageTemp;
        });
    } on PlatformException catch (e) {
      print(e);
    }

  }
  Future<File?> cropImage({required File imagefile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imagefile.path);
    if(croppedImage == null) return null;
    return File(croppedImage.path);

  }

  var introData = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Center(
                child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  child: Center(
                    child: ClipOval(
                      child: _image != null ? Image.file(
                         _image!,
                        ) : Text("select photo"),
                    ),
                  ),
                  )
                ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
              ),
            ),
            ElevatedButton(onPressed: (){
              print("MYNAMEISBOBAND: ${imageService.resultdata}");
              introData.write("img", imageService.resultdata);
              print("HELLONOOOOOO: ${ introData.read("img")}");

              localRepository.saveName(nameController.text);
              imageService.uploadImage(_image!);
            }, child: Text("Post Image"))


            ,ElevatedButton(onPressed: (){
              box.write("name",nameController.text);
            }, child:
              Text("Save Name")
            )
            ,
            ElevatedButton(onPressed: (){
              print("HELLOBROTHER ${box.read("name")}");
              }, child:
              Text("Get Name")
            )
            ,
            Text("Name is: ${box.read("name")}")


          ],
        ),

        floatingActionButton: FloatingActionButton(
            onPressed: () {
              pickImage();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add)

          // This trailing comma makes auto-formatting nicer for build methods
        )
    );
  }
}
