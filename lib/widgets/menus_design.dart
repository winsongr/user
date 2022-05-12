import 'package:flutter/material.dart';
import 'package:user/mainScreens/item_screen.dart';
import 'package:user/models/menus.dart';

class MenusDesignWidget extends StatefulWidget {
  const MenusDesignWidget({Key? key, this.model, this.context})
      : super(key: key);
  final Menus? model;
  final BuildContext? context;
  @override
  State<MenusDesignWidget> createState() => _MenusDesignWidgetState();
}

class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell( onTap: (){
        
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) =>  ItemsScreen(model:widget.model)));
            
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              const SizedBox(
                height: 2.0,
              ),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 150.0,
                
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                widget.model!.menuTitle!,
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                ),
              ),
              Text(
                widget.model!.menuInfo!,
                style: const TextStyle(
                  color: Colors.cyan,
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
