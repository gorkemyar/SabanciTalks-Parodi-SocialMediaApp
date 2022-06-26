import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddImageView extends StatefulWidget {
  final bool isCamera;
  const AddImageView(this.isCamera, { Key? key }) : super(key: key);

  @override
  State<AddImageView> createState() => _AddImageViewState();
}

class _AddImageViewState extends State<AddImageView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        color: Colors.black,
        strokeWidth: 2,
        radius: const Radius.circular(20.0),
        dashPattern: const [10, 5],
       
        child: SizedBox(
          height: 100,
          width: 100,
          child: Icon(
            
            widget.isCamera ? Icons.camera_alt: Icons.add

          ),
        )),
    );
  }
}