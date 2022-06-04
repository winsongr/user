import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/models/items.dart';
import 'package:user/models/menus.dart';
import 'package:user/widgets/cart_appbar.dart';
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
      appBar: CartAppbar(),
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
