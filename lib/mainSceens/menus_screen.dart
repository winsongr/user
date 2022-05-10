import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/models/menus.dart';
import 'package:user/models/sellers.dart';
import 'package:user/widgets/app_drawer.dart';
import 'package:user/widgets/menus_design.dart';
import 'package:user/widgets/progress_bar.dart';

class MenusScreen extends StatefulWidget {
  const MenusScreen({Key? key, this.model}) : super(key: key);
  final Sellers? model;
  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
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
        automaticallyImplyLeading: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // Navigator.push(context,
        //       //     MaterialPageRoute(builder: (c) => const MenuUploadScreen()));
        //     },
        //     icon: const Icon(
        //       Icons.shopping_cart,
        //       size: 30,
        //       color: Color.fromARGB(255, 255, 255, 255),
        //     ),
        //   ),
        //   Positioned(
        //       child: Stack(
        //     children: const [
        //       Icon(
        //         Icons.brightness_1,
        //         size: 20.0,
        //         color: Colors.white,
        //       ),
        //       Positioned(
        //           top: 3,
        //           right: 4,
        //           child: Center(
        //             child: Text(
        //               "0",
        //               style: TextStyle(color: Colors.white, fontSize: 12),
        //             ),
        //           ))
        //     ],
        //   ))
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  const EdgeInsets.fromLTRB(0,6.0,0,0),
              child: Text(
                
                "${widget.model!.sellerName} Menu's",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0),

              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("sellers")
                    .doc(widget.model!.sellerUid)
                    .collection("menus")
                    .orderBy("publishedDate", descending: true)
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

                            Menus model = Menus.fromJson(
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>);
                            return MenusDesignWidget(
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
