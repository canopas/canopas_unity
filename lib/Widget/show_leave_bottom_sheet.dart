
import 'package:flutter/material.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/services/LeaveService/apply_for_leaves_api_service.dart';
import 'package:projectunity/ui/User/Leave/leave_request_form.dart';

void showLeaveModalBottomSheet(context) {
  ApplyForLeaveApiService apiservice = getIt<ApplyForLeaveApiService>();
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ListTile(
                leading:const Icon(Icons.adjust),
                title: const Text('All Leaves',style: TextStyle(fontSize: 20)),
                onTap: (){},
              ),
              ListTile(
                leading:const Icon(Icons.adjust),
                title:const Text('Upcoming Leaves',style: TextStyle(fontSize: 20)),
                onTap: (){},
              ),
              ListTile(
                leading:const Icon(Icons.adjust),
                title:const Text('Team leaves',style: TextStyle(fontSize: 20),),
                onTap: (){},

              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                      ),

                      onPressed: (){
                      apiservice.applyForLeave();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LeaveRequestForm()));
                      }, child:const Text('Apply for Leaves',style: TextStyle(fontSize: 20),)),
                ),
              )
            ],
          ),
        );

      });
}
