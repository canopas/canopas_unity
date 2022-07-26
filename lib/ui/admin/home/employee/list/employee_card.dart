import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/widget/user_profile_image.dart';

import '../../../../../di/service_locator.dart';
import '../../../../../model/employee/employee.dart';
import '../../../../../navigation/navigationStackItem/admin/admin_navigation_stack_items.dart';

class EmployeeCard extends StatelessWidget {
  EmployeeCard({Key? key, required this.employee}) : super(key: key);

  final NavigationStackManager _stackManager = getIt<NavigationStackManager>();
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          _stackManager.push(
              AdminNavigationStackItem.employeeDetailState(id: employee.id));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              ImageProfile(
                imageUrl: employee.imageUrl,
                iconSize: 60,
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EmployeeName(name: employee.name),
                  const SizedBox(
                    height: 7,
                  ),
                  EmployeeDesignation(designation: employee.designation)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeImage extends StatelessWidget {
  const EmployeeImage({Key? key, required this.imageUrl, required this.radius})
      : super(key: key);
  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return SizedBox(
          width: 70,
          height: 70,
          child: Icon(
            Icons.account_circle_rounded,
            size: 70,
            color: Colors.grey[900],
          ));
    } else {
      return SizedBox(
        width: 70,
        height: 70,
        child: CircleAvatar(
          radius: 70,
          backgroundImage: NetworkImage(imageUrl!),
        ),
      );
    }
  }
}

class EmployeeName extends StatelessWidget {
  const EmployeeName({Key? key, required this.name}) : super(key: key);
  final String? name;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Text(
      name ?? '',
      textAlign: TextAlign.start,
      style: height >= 700
          ? const TextStyle(
              fontSize: titleTextSize, fontWeight: FontWeight.w500)
          : const TextStyle(
              fontSize: subTitleTextSize, fontWeight: FontWeight.w500),
    );
  }
}

class EmployeeDesignation extends StatelessWidget {
  const EmployeeDesignation({Key? key, required this.designation})
      : super(key: key);
  final String? designation;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Text(
      designation ?? '',
      textAlign: TextAlign.start,
      style: height >= 700
          ? const TextStyle(fontSize: subTitleTextSize, color: Colors.black54)
          : const TextStyle(fontSize: bodyTextSize, color: Colors.black54),
    );
  }
}
