import 'package:flutter/material.dart';

class CartAppbar extends StatefulWidget with PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  CartAppbar({Key? key, this.bottom}) : super(key: key);
  @override
  State<CartAppbar> createState() => _CartAppbarState();
  @override
  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80+AppBar().preferredSize.height);
}

class _CartAppbarState extends State<CartAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
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
            Positioned(
              child: Stack(
                children: const [
                  Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  Positioned(
                      top: 13,
                      right: 20,
                      child: Center(
                        child: Text(
                          "0",
                          style: TextStyle(
                              color: Color.fromARGB(255, 143, 23, 23),
                              fontSize: 15),
                        ),
                      ))
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
