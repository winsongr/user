import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:user/models/sellers.dart';

class InfoDesignWidget extends StatefulWidget {
  InfoDesignWidget({Key? key, this.model, this.context}) : super(key: key);
  Sellers? model;
  BuildContext? context;
  @override
  State<InfoDesignWidget> createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height:MediaQuery.of(context).size.height*1,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Divider(
              height: 4,
              thickness: 3,
              color: Colors.grey[300],
            ),
            Image.network(
              widget.model!.sellerAvatarUrl!,
              height:180.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              widget.model!.sellerName!,
              style: const TextStyle(
                color: Colors.cyan,
                fontSize: 20,
              ),
            ),Divider(
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
