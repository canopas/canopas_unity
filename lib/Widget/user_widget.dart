import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        elevation: 10,
        child: Row(
          children: [
            const Icon(
              Icons.account_circle_rounded,
              size: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Darpan Vithani',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Team Lead',
                  style: TextStyle(
                      // fontSize: 20,fontWeight: FontWeight.w300
                      ),
                ),
                Text(
                  'darpan@canopas.com',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                'CA1001',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
