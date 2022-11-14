import 'package:flutter/material.dart';

import '../utils/style/style.dart';

class ShiftButton  extends StatefulWidget {
  const ShiftButton({Key? key, this.shiftName, this.status, this.onTap}) : super(key: key);
  final String? shiftName;
  final bool? status;
  final  GestureTapCallback? onTap;

  @override
  State<ShiftButton> createState() => _ShiftButtonState();
}

class _ShiftButtonState extends State<ShiftButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        widget.onTap;
      },
      child: Container(
        height: 40,
       // width: 65,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 0,
              //offset: Offset(3, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(14),
          shape: BoxShape.rectangle,
          //gradient: Gradients.blueGradient,
          color:widget.status == false? Colors.white70:AppColors.primaryColor.withOpacity(0.1),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.values[2],
            children:  [
              Text( widget.shiftName??"name",
                  // HomePage.selectedUserList.first.name.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                      color: AppColors.primaryColor,
                      overflow: TextOverflow.ellipsis)),
              const SizedBox(
                width: 4,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
