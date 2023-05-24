import 'dart:developer';
import 'dart:io';
import 'package:admin/domain/firebase_functions.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/models/product_models.dart';
import '../../constants/constants.dart';
import '../../widgets/textfield_widget.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController subnameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<String> imageList = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: kMainBgColor,
          appBar: AppBar(
            backgroundColor: kMainBgColor,
            elevation: 0,
            foregroundColor: Colors.black,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_left)),
            title: const Text(
              "Product Details",
              style: TextStyle(
                color: kTextBlackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (pickedFile == null) {
                        return;
                      } else {
                        File file = File(pickedFile.path);
                        imageList =
                            await _uploadImage(file, nameController.text);
                        setState(() {});
                      }
                    },
                    child: SizedBox(
                      width: size.width * 0.7,
                      height: size.width * 0.7,
                      child: imageList.isEmpty
                          ? Container(
                              height: size.height * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Text(
                                  'Pick Image',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            )
                          : Image.network(
                              imageList[0],
                            ),
                    ),
                  ),
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Product Name",
                  textController: nameController,
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Sub Name",
                  textController: subnameController,
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Category",
                  textController: categoryController,
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Quantity",
                  textController: quantityController,
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Price",
                  textController: priceController,
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Color",
                  textController: colorController,
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Description",
                  textController: descriptionController,
                  height: 160,
                  maxLines: 4,
                ),
                SizedBox(
                  height: size.height * 0.1,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                addProduct(
                    Products(
                      productName: nameController.text.trim(),
                      subname: subnameController.text.trim(),
                      category: categoryController.text.trim(),
                      quantity: int.parse(quantityController.text.trim()),
                      price: int.parse(priceController.text.trim()),
                      color: colorController.text.trim(),
                      description: descriptionController.text.trim(),
                      imageList: imageList,
                    ),
                    context);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                        horizontal: size.width * 0.32, vertical: 20)),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<List<String>> _uploadImage(File file, String productName) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    int index = imageList.length;

    firebase_storage.Reference ref =
        storage.ref().child('images/$productName (${index + 1})');

    firebase_storage.UploadTask task = ref.putFile(file);

    await task;
    String downloadURL = await ref.getDownloadURL();
    log(downloadURL);
    imageList.add(downloadURL);
    return imageList;
  }
}
