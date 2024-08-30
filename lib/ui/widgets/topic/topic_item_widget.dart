import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/topic.dart';
import '../../screens/message/message_screen.dart';

class TopicItemWidget extends StatelessWidget {
  final Topic topic;
  final String? questionId;
  final String? questionTitle;

  TopicItemWidget({
    Key? key,
    required this.topic,
    this.questionId,
    this.questionTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => MessageScreen(
              topicId: topic.id,
              topicName: topic.name,
              questionId: questionId,
              questionTitle: questionTitle,
            ));
      },
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 51,
                    height: 51,
                    margin: EdgeInsets.only(left: 5),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: CachedNetworkImage(
                            // imageUrl: Constants.USERS_PROFILES_URL +
                            //     _chatRoomModel.userImg,
                            imageUrl:
                                'https://st2.depositphotos.com/1007566/12301/v/950/depositphotos_123013242-stock-illustration-avatar-man-cartoon.jpg',
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   right: 0,
                        //   child: Icon(
                        //     Icons.brightness_1,
                        //     color: Colors.green,
                        //     size: 16,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AutoSizeText(
                          topic.name!.toUpperCase(),
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500, fontSize: 14.5),
                        ),
                        topic.description!.isEmpty
                            ? Container()
                            : Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 + 20,
                                child: AutoSizeText(
                                  'Discussion Area: ${topic.description}',
                                  style: GoogleFonts.roboto(
                                      color: Colors.black.withOpacity(0.8),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                  maxLines: 5,
                                ),
                              ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 + 20,
                          child: AutoSizeText(
                            'Created by: ${topic.creator!.name}',
                            // 'Created by: ${topic.creator}',
                            style: GoogleFonts.roboto(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),

                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
