import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodpanda_ui_clone/data/response/status.dart';
import 'package:foodpanda_ui_clone/models/resquest/restaurant_respones_model.dart';
import 'package:foodpanda_ui_clone/viewmodels/image_viewmodel.dart';
import 'package:foodpanda_ui_clone/viewmodels/restaurant_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RestaurantForm extends StatefulWidget {
  RestaurantForm({super.key});
  @override
  _RestaurantFormState createState() => _RestaurantFormState();
}

class _RestaurantFormState extends State<RestaurantForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController deliveryFeeController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();

  File? images;
  var imageViewModel = ImageViewModel();
  var restaurantViewModel = RestaurantViewModel();
  var imageId;

  _getImageFromSource(type) async {
    var pickedFile = await ImagePicker().pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images = File(pickedFile.path);
      });
      imageViewModel.uploadImage(pickedFile.path);
    }
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      var requestBody = Data(
          name: nameController.text,
          category: categoryController.text,
          discount: int.parse(discountController.text),
          deliveryFee: double.parse(deliveryFeeController.text),
          deliveryTime: int.parse(deliveryTimeController.text),
          picture: imageId.toString()
      );
      restaurantViewModel.postRestaurant(requestBody);
      _formKey.currentState!.reset();
      // Clear the text field controllers
      nameController.clear();
      categoryController.clear();
      discountController.clear();
      deliveryFeeController.clear();
      deliveryTimeController.clear();
      // Clear the image selection
    }
  }
  @override
  void dispose() {
    // Dispose the text field controllers when the widget is disposed
    nameController.dispose();
    categoryController.dispose();
    discountController.dispose();
    deliveryFeeController.dispose();
    deliveryTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    controller: categoryController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a category';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Discount',
                    ),
                    controller: discountController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a discount';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Delivery Fee',
                    ),
                    controller: deliveryFeeController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a delivery fee';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Delivery Time',
                    ),
                    controller: deliveryTimeController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a delivery time';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => _getImageFromSource('gallery'),
                    child: const Text('Select Image'),
                  ),
                  ChangeNotifierProvider(
                    create: (context)=>imageViewModel,
                    child: Consumer<ImageViewModel>(
                      builder: (context,viewModel,_){
                        switch(viewModel.image.status){
                          case Status.LOADING:
                            return Center( child: CircularProgressIndicator(),);
                          case Status.COMPlETED:
                           // print("image id ${viewModel.image.data.id}");
                            imageId=viewModel.image.data.id;
                            return Container(
                              width: 250,
                              height: 250,
                              child: images == null
                                  ? Image.asset('assets/images/cofee1.webp')
                                  : Image.file(images!),
                            );
                          default:return Container();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: submitForm,
                    child:  ChangeNotifierProvider(
                      create: (context)=>restaurantViewModel,
                      child: Consumer<RestaurantViewModel>
                        (builder: (context,viewModel,_){
                        if(viewModel.response.status == Status.COMPlETED){
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content:Text("Operation Success"))
                            );
                          });
                        }
                        return Text('Submit');
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
