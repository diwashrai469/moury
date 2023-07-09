import 'package:flutter/material.dart';


class KLoader {
  static Future<dynamic> showMyLoader(BuildContext context) async {
    return await showDialog(
        context:context,
        builder: (contex) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: GestureDetector(
              onTap: () {},
              child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: const CircularProgressIndicator(
                    color: Colors.blue,
                  )),
            )),
          );
        });
  }
}
