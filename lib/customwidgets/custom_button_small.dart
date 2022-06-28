import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {

  final double height;
  final double weight;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  SmallButton({Key? key,this.height=32,this.weight=32,this.color=Colors.white,required this.icon,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: weight,
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(weight * 0.20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  spreadRadius: 1
              )
            ]
        ),
        child: Icon(icon),
      ),
    );;
  }
}


