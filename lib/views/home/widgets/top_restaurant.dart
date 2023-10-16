import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_ui_clone/models/response/restaurant_model.dart';

import 'package:foodpanda_ui_clone/views/deitialspage/product_detials.dart';
import 'package:foodpanda_ui_clone/views/home/widgets/insert.dart';


class TopRestaurant extends StatefulWidget {
  RestaurantData restaurantData;
 TopRestaurant({
   required this.restaurantData,
    Key? key,
  }) : super(key: key);

  @override
  State<TopRestaurant> createState() => _TopRestaurantState();
}

class _TopRestaurantState extends State<TopRestaurant> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsPage()));
      },
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(
                        Icons.add_circle_outline_outlined,
                        size: 30),
                    title: const Text(
                      'Insert',
                      style: TextStyle(fontSize: 22),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RestaurantForm()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                        Icons.remove_circle_outline_outlined,
                        size: 30),
                    title: const Text('Delete'),
                    onTap: () async {
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.draw_outlined,
                      size: 30,
                    ),
                    title: const Text('Update'),
                    onTap: () {
                    },
                  ),
                ],
              );
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              'https://cms.istad.co${widget.restaurantData.attributes?.picture?.data?.attributes?.url}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              color: Colors.pink.shade600,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              "Top restaurant",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "${widget.restaurantData.attributes?.deliveryTime} mn",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "${widget.restaurantData.attributes?.name}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "\$\$\$ ${widget.restaurantData.attributes?.category}",
                      style: const TextStyle(fontSize: 16),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "\$ ${widget.restaurantData.attributes?.deliveryFee.toString()} delivery fee",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
