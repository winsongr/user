import 'package:flutter/material.dart';
import 'package:user/models/items.dart';
import 'package:user/widgets/cart_appbar.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({Key? key, this.model}) : super(key: key);
  final Items? model;
  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:CartAppbar(),
    );
  }
}
