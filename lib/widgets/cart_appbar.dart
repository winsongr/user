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
              icon: const Icon(Icons.shopping_cart, color: Colors.cyan,),
              onPressed: ()
              {
                //send user to cart screen
              },
            ),
            Positioned(
              child: Stack(
                children: const [
                  Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.green,
                  ),
                  Positioned(
                    top: 3,
                    right: 4,
                    child: Center(
                      child: Text("0", style: TextStyle(color: Colors.white, fontSize: 12),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
