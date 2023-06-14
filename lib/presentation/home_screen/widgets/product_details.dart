import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/firebase_functions.dart';
import '../../../domain/models/product_models.dart';
import '../../constants/constants.dart';
import '../../widgets/textfield_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ValueNotifier<bool> editNotifier = ValueNotifier(true);

  final TextEditingController nameController = TextEditingController();

  final TextEditingController subnameController = TextEditingController();

  final TextEditingController categoryController = TextEditingController();

  final TextEditingController quantityController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController colorController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  List imageList = [];

  @override
  void initState() {
    imageList = widget.data['image'];
    log(imageList.toString());
    super.initState();
  }

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
            // automaticallyImplyLeading: true,
            foregroundColor: Colors.black,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset("assets/back.svg")),
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
                ValueListenableBuilder(
                  valueListenable: editNotifier,
                  builder: (context, editOrUpdate, child) => Column(
                    children: [
                      Center(
                        child: imageList.length == 1
                            ? GestureDetector(
                                onTap: () {
                                  editOrUpdate ? null : pickFirstImage();
                                },
                                child: SizedBox(
                                    width: size.width * 0.7,
                                    child:
                                        Image.network(widget.data["image"][0])),
                              )
                            : Stack(
                                children: [
                                  FlutterCarousel(
                                    items: List.generate(
                                        imageList.length,
                                        (index) => SizedBox(
                                            width: size.width * 0.7,
                                            child: Image.network(
                                                imageList[index]))),
                                    options: CarouselOptions(
                                      indicatorMargin: 5,
                                      viewportFraction: 1,
                                      slideIndicator:
                                          const CircularSlideIndicator(
                                              indicatorRadius: 4,
                                              itemSpacing: 15,
                                              currentIndicatorColor:
                                                  Colors.black,
                                              indicatorBackgroundColor:
                                                  Colors.grey),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.add_a_photo_outlined),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Visibility(
                        visible: !editOrUpdate,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            editOrUpdate ? null : pickMoreImage();
                          },
                          label: const Text(
                            "Add Image",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Product Name",
                        textString: widget.data["name"] ?? 'No name',
                        textController: nameController,
                        enableTextField: !editOrUpdate,
                        // enableTextField: false,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "SubName",
                        enableTextField: !editOrUpdate,
                        textString: widget.data["subname"] ?? 'No Subname',
                        textController: subnameController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Category",
                        enableTextField: !editOrUpdate,
                        textString: widget.data["category"] ?? 'No Category',
                        textController: categoryController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Quantity",
                        enableTextField: !editOrUpdate,
                        textString: widget.data["quantity"].toString(),
                        textController: quantityController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Price",
                        enableTextField: !editOrUpdate,
                        textString: widget.data["price"].toString(),
                        textController: priceController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Color",
                        enableTextField: !editOrUpdate,
                        textString: widget.data["color"] ?? 'No Color',
                        textController: colorController,
                      ),
                      DetailsTextFieldWidget(
                        size: size,
                        fieldName: "Description",
                        enableTextField: !editOrUpdate,
                        textString: widget.data["description"] ??
                            'No Description Available Now',
                        textController: descriptionController,
                        height: 150,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder(
              valueListenable: editNotifier,
              builder: (context, editOrUpdate, child) => TextButton(
                onPressed: () {
                  editNotifier.value = !editNotifier.value;
                  editOrUpdate
                      ? null
                      : updateProduct(
                          context: context,
                          id: widget.data['id'],
                          productsModel: Products(
                            subname: subnameController.text,
                            category: categoryController.text,
                            quantity: int.parse(quantityController.text),
                            price: int.parse(priceController.text),
                            color: colorController.text,
                            description: descriptionController.text,
                            imageList: imageList,
                            productName: nameController.text,
                          ),
                        );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: size.width * 0.32, vertical: 20)),
                ),
                child: Text(
                  editOrUpdate ? '   Edit   ' : 'Update',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void pickFirstImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return;
    } else {
      File file = File(pickedFile.path);
      String imageUrl = await _uploadFirstImage(
          file, widget.data['name'], widget.data['image']);
      setState(() {
        imageList.add(imageUrl);
      });
    }
  }

  void pickMoreImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return;
    } else {
      File file = File(pickedFile.path);
      imageList = await _uploadMoreImage(file, widget.data['productName'],
          widget.data['networkImageList'], widget.data['id']);

      setState(() {
        imageList = imageList;
      });
    }
  }
}

Future<String> _uploadFirstImage(
    File file, String productName, List imageList) async {
  final FirebaseStorage storage = FirebaseStorage.instance;

  int index = imageList.length;

  Reference oldRef = storage.ref().child('images/$productName (${index + 1})');
  await oldRef.delete();
  Reference ref = storage.ref().child('images/$productName (${index + 1})');

  UploadTask task = ref.putFile(file);

  task.snapshotEvents.listen((TaskSnapshot snapshot) {
    log('Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
  });

  await task;

  String downloadURL = await ref.getDownloadURL();
  log('File uploaded successfully: $downloadURL');

  return downloadURL;
}

Future<List> _uploadMoreImage(
    File file, String productName, List imageList, String id) async {
  final FirebaseStorage storage = FirebaseStorage.instance;

  int index = imageList.length;

  Reference ref = storage.ref().child('images/$productName (${index + 1})');

  UploadTask task = ref.putFile(file);

  task.snapshotEvents.listen((TaskSnapshot snapshot) {
    log('Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
  });

  await task;

  String downloadURL = await ref.getDownloadURL();
  log('File uploaded successfully: $downloadURL');
  imageList.add(downloadURL);
  addMoreImage(imageList, id);

  return imageList;
}
