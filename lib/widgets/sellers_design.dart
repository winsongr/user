import 'package:flutter/material.dart';
import 'package:user/mainScreens/menus_screen.dart';
import 'package:user/models/sellers.dart';

class SellersDesignWidget extends StatefulWidget {
  const SellersDesignWidget({Key? key, this.model, this.context})
      : super(key: key);
  final Sellers? model;
  final BuildContext? context;
  @override
  State<SellersDesignWidget> createState() => _SellersDesignWidgetState();
}

class _SellersDesignWidgetState extends State<SellersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => MenusScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              
              Image.network(
                widget.model!.sellerAvatarUrl!,
                height: 180.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                widget.model!.sellerName!,
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                ),
              ),
             
            ]),
          ),
        ),
      ),
    );
  }
}
