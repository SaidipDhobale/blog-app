import 'package:flutter/material.dart';

class DeleteMessage extends StatelessWidget {
  final bool _showMessage;
  const DeleteMessage({super.key,required bool showMessage}):_showMessage=showMessage;

  @override
  Widget build(BuildContext context) {
    return   Center(
                child: AnimatedOpacity(
                  opacity: _showMessage ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: 300,
                    height: 100,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow:const  [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.white, size: 30),
                        SizedBox(width: 12),
                        Text(
                          'Deleted Successfully!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
  }
}