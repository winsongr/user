import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/models/items.dart';
import 'package:user/models/menus.dart';
import 'package:user/widgets/app_drawer.dart';
import 'package:user/widgets/item_design.dart';
import 'package:user/widgets/progress_bar.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({Key? key, this.model}) : super(key: key);
  final Menus? model;
  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.amber, Colors.cyan],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text(
          "IFOOD",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (c) => const MenuUploadScreen()));
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const Positioned(
                  top: 13,
                  right: 20,
                  child: Center(
                    child: Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.white,
                    ),

                    // Text(
                    //   "0",
                    //   style: TextStyle(
                    //       color: Color.fromARGB(255, 143, 23, 23),
                    //       fontSize: 15),
                    // ),
                  ))
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "${widget.model!.menuTitle} items",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("sellers")
                    .doc(widget.model!.sellerUID)
                    .collection("menus")
                    .doc(widget.model!.menuID)
                    .collection("items")
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: circularProgress(),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: snapshot.data!.size,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            Items model = Items.fromJson(
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>);

                            return ItemsDesignWidget(
                                model: model, context: context);
                          },
                        );
                }),
          ],
        ),
      ),
    );
  }
}
