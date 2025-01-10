import 'package:dompet_mal/app/modules/participantPage/controllers/participant_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ParticipantPage extends StatelessWidget {
  final ParticipantPageController controller = Get.put(ParticipantPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partisipan', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.participants.length,
          padding: EdgeInsets.all(16.0),
          itemBuilder: (context, index) {
            final participant = controller.participants[index];
            return Container(
              margin: EdgeInsets.only(bottom: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(participant['image']!),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          participant['name']!,
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          participant['amount']!,
                          style: TextStyle(color: Colors.black, fontSize: 14.0),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          participant['date']!,
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
