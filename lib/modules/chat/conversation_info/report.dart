
import 'package:farm_hub/modules/chat/conversation_info/coversation_info.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var reportController = TextEditingController();
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, size: screenWidth * 0.06),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.info_circle_fill, color: Colors.black,
                size: screenWidth * 0.06),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Report an issue',
               style:TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.w600,
                 color: defaultColor
               ),
              ),
              SizedBox(height: 40,),
              Text('Help us understand the issue. Can you help us understand the issue with this conversation? We want to make sure we address any concerns you may have.'),
              SizedBox(height: 30,),
              containerItem('It\'s spam', Icons.warning_rounded),
              SizedBox(height: 10,),
              containerItem('It\'s a report', Icons.report),
              SizedBox(height: 40,),
              Text('Write a report!',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
              SizedBox(height: 10,),
              defaultForm(label: '...',
                  type: TextInputType.text,
                  controller: reportController,
                  validate: (value){
                    return null;
                  }),
              SizedBox(height: 30,),
              defaultButton(background: Colors.red,
                  text: 'Report harrisonmatovu',
                  function: (){
                    showModalBottomSheet(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      context: context,
                      isScrollControlled: true, // Allows setting custom height
                      builder: (context) => FractionallySizedBox(
                        heightFactor: 0.45,
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Container(
                                  height: 8,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'We appreciate you bringing this issue to our attention! Your feedback is incredibly valuable as it helps us identify areas for improvement in our service. Rest assured, our team is actively addressing the reported issue to ensure a better experience for all users. Thank you for your patience and understanding as we work to resolve this matter promptly!',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              defaultButton(
                                background: Colors.black,
                                text: 'Exit',
                                function: () {},
                                height: 58,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(height: 24,),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    border: Border.all(
                      style: BorderStyle.solid,
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  child: const Text(
                    'Leave page',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
