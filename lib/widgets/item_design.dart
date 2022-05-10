import 'package:flutter/material.dart';
import 'package:user/models/items.dart';

class ItemsDesignWidget extends StatefulWidget {
  const ItemsDesignWidget({Key? key, this.model, this.context})
      : super(key: key);
  final Items? model;
  final BuildContext? context;
  @override
  State<ItemsDesignWidget> createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Divider(
              height: 4,
              thickness: 3,
              color: Colors.grey[300],
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
              widget.model!.title!,
              style: const TextStyle(
                color: Colors.cyan,
                fontSize: 20,
              ),
            ),
            Text(
              widget.model!.shortInfo!,
              style: const TextStyle(
                color: Colors.cyan,
                fontSize: 20,
              ),
            ),
            Divider(
              height: 4,
              thickness: 3,
              color: Colors.grey[300],
            ),
          ]),
        ),
      ),
    );
  }
}
