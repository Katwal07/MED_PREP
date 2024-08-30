// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart' as ip;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uuid/uuid.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../common/constants.dart';
import '../../../common/tools.dart';
import '../../../locator.dart';
import '../../../models/message.dart';
import '../../../models/question.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../widgets/common/full_screen_image.dart';
import '../../widgets/question/question_detail_screen.dart';

class MessageScreen extends StatefulWidget {
  final String? topicId;
  final String? topicName;
  final String? questionId;
  final String? questionTitle;

  const MessageScreen({
    Key? key,
    required this.topicId,
    required this.topicName,
    this.questionId,
    this.questionTitle,
  }) : super(key: key);
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String messageText = '';
  TextEditingController _messageController = TextEditingController();

  bool fromQuestionScreen() {
    if (widget.questionId != null && widget.questionTitle != null) {
      return true;
    }
    return false;
  }

  void _onMessageChanged(String value) {
    setState(() {
      messageText = value;
      // if (value.trim().isEmpty) {
      //   isCurrentUserTyping = false;
      //   return;
      // } else {
      //   isCurrentUserTyping = true;
      // }
    });
  }

  //60333a5e51e61b2ae2f275c3

  late io.Socket socket;

  void initSocket() async {
    String url = "$SOCKET_ENDPOINT/api/messages";
    socket = io.io(
      '$url',
      <String, dynamic>{
        'transports': ['websocket'],
      },
    );

    socket.on(
      'connect',
      (_) {
        _sendJoinChat();

        _sendIfQuestionIsAttached();
      },
    );

    socket.on(
      'messageReceived',
      (data) {
        print(data);
        _onReceiveMessage(data);
      },
    );
  }

  void _sendIfQuestionIsAttached() {
    if (fromQuestionScreen()) {
      _sendMessage(messageType: 2);
    }
    return;
  }

  void _sendJoinChat() {
    Map map = Map();
    map['topic'] = widget.topicId;

    var myJson = jsonEncode(map);

    socket.emit(
      "joinChat",
      myJson,
    );
  }

  void _onReceiveMessage(msg) {
    var data = jsonDecode(msg);
    int messageType = data['messageType'];
    print('type isssssssss $messageType');
    String img = data['img'];

    setState(
      () {
        _myMessages.insert(
          0,
          Message(
            id: data['id'],
            sender: Sender.fromJson(data['sender']),
            message: data['message'],
            messageType: messageType,
            img: img,
            topic: data['topic'],
            question: data['question'],
          ),
        );
      },
    );
  }

  late User loggedUser;
  StorageService _storageService = locator<StorageService>();

  Api _api = locator<Api>();

  String userId = 'bk';

  late FocusNode _focusNode;

  // Refresh Handling
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // List View Controller
  late ScrollController _scrollController;

  // Generating Unique ID
  var uuid = Uuid();

  _unSubscribes() {
    if (socket != null) {
      socket.disconnect();
    }
  }

  // Page Number of messages
  late int page;

  @override
  void initState() {
    super.initState();
    initSocket();

    _storageService.getUser().then((u) {
      loggedUser = u;
      userId = loggedUser.id!;
    });

    _scrollController = ScrollController(
      initialScrollOffset: 0,
    );

    _scrollController.addListener(
      _scrollListener,
    );

    fetchLastMessages();

    page = 1;
  }

  _scrollListener() {
    if (_scrollController.offset > 130) {
      FocusScope.of(context).requestFocus(
        new FocusNode(),
      );
    }
  }

  void fetchLastMessages() async {
    try {
      final tempMessageList =
          await _api.getLastMessages(topicId: widget.topicId!);

      setState(() {
        _myMessages = tempMessageList.messages;
      });
    } catch (err) {
      _myMessages = [];
    }
  }

  void _onLoadMore() {
    loadMoreMessages();
  }

  void loadMoreMessages() async {
    ++page;
    try {
      final tempMessageList =
          await _api.getLastMessages(topicId: widget.topicId!, page: page);

      for (int i = 0; i < tempMessageList.messages.length; i++) {
        _myMessages.add(tempMessageList.messages[i]);
      }
      if (tempMessageList.messages.length >= 20) {
        setState(() {
          _refreshController.loadComplete();
        });
      } else {
        setState(() {
          _refreshController.loadNoData();
        });
      }
    } catch (err) {}
  }

  @override
  void dispose() {
    super.dispose();
    if (_scrollController != null) {
      _scrollController.dispose();
    }
    _unSubscribes();
    _messageController.dispose();
  }

  List<Message> _myMessages = [
    // Message(
    //   id: 'gjksgjkds',
    //   message: null,
    //   messageType: 2,
    //   img: null,
    //   question: Question(
    //     question: 'What is Your Name?',
    //     optionA: 'Bikram Aryal',
    //     optionB: 'Mandip Joshi',
    //     optionC: 'Prabin Nepal',
    //     optionD: 'John Doe',
    //     explanation:
    //         'This is all clear that my name is bikram aryal',
    //     year: '2020',
    //     sectionName: 'Anatomy',
    //     id: 'gsgdsg',
    //   ),
    //   sender: Sender(
    //       id: 'bk',
    //       name: 'Bikram Aryal',
    //       photoUrl:
    //           'https://st2.depositphotos.com/1007566/12301/v/950/depositphotos_123013242-stock-illustration-avatar-man-cartoon.jpg'),
    //   topic: 'gsdgsagsag',
    // ),
    // Message(
    //   id: 'gjksgjkds',
    //   message: null,
    //   messageType: 1,
    //   img:
    //       'https://st2.depositphotos.com/1007566/12301/v/950/depositphotos_123013242-stock-illustration-avatar-man-cartoon.jpg',
    //   question: null,
    //   sender: Sender(
    //       id: 'bk',
    //       name: 'Bikram Aryal',
    //       photoUrl:
    //           'https://st2.depositphotos.com/1007566/12301/v/950/depositphotos_123013242-stock-illustration-avatar-man-cartoon.jpg'),
    //   topic: 'gsdgsagsag',
    // ),
    // Message(
    //   id: 'gjksgjkds',
    //   message: 'This is a message',
    //   messageType: 0,
    //   img: null,
    //   question: null,
    //   sender: Sender(
    //       id: 'bk',
    //       name: 'Bikram Aryal',
    //       photoUrl:
    //           'https://st2.depositphotos.com/1007566/12301/v/950/depositphotos_123013242-stock-illustration-avatar-man-cartoon.jpg'),
    //   topic: 'gsdgsagsag',
    // ),
    // Message(
    //   id: 'gjksgjkds',
    //   message: null,
    //   messageType: 2,
    //   img: null,
    //   question: Question(
    //     question: 'What is Your Name?',
    //     optionA: 'Bikram Aryal',
    //     optionB: 'Mandip Joshi',
    //     optionC: 'Prabin Nepal',
    //     optionD: 'John Doe',
    //     explanation:
    //         'This is all clear that my name is bikram aryal',
    //     year: '2020',
    //     sectionName: 'Anatomy',
    //     id: 'gsgdsg',
    //   ),
    //   sender: Sender(
    //       id: 'bk1',
    //       name: 'Bikram Aryal',
    //       photoUrl:
    //           'https://st2.depositphotos.com/1007566/12301/v/950/depositphotos_123013242-stock-illustration-avatar-man-cartoon.jpg'),
    //   topic: 'gsdgsagsag',
    // ),
    // Message(
    //   id: 'gjksgjkds',
    //   message: 'This is Another Message',
    //   messageType: 0,
    //   img: null,
    //   question: null,
    //   sender: Sender(
    //       id: 'bk2',
    //       name: 'Jeevan Aryal',
    //       photoUrl:
    //           'https://st2.depositphotos.com/1007566/12301/v/950/depositphotos_123013242-stock-illustration-avatar-man-cartoon.jpg'),
    //   topic: 'gsdgsagsag',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 27,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (_) => PeerProfile(widget.peerId)));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://st2.depositphotos.com/1007566/12301/v/950/depositphotos_123013242-stock-illustration-avatar-man-cartoon.jpg',
                    fit: BoxFit.contain,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              InkWell(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (_) => PeerProfile(widget.peerId)));
                },
                child: Container(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      AutoSizeText(
                        '${widget.topicName!.toUpperCase()}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AutoSizeText('500+ messages',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: SmartRefresher(
              controller: _refreshController,
              header: WaterDropHeader(),
              onLoading: _onLoadMore,
              enablePullUp: true,
              enablePullDown: false,
              child: ListView.builder(
                controller: _scrollController,
                addAutomaticKeepAlives: false,
                shrinkWrap: true,
                reverse: true,
                itemCount: _myMessages.length,
                itemBuilder: (context, i) {
                  var myMessage = _myMessages[i];

                  if (myMessage.sender!.id == userId) {
                    return InkWell(
                      child: Bubble(
                        padding: myMessage.messageType == 0
                            ? BubbleEdges.all(9)
                            : BubbleEdges.all(0),
                        margin: myMessage.img != null
                            ? BubbleEdges.only(top: 10)
                            : BubbleEdges.only(
                                top: (i < _myMessages.length - 1)
                                    ? ScreenUtil().setHeight(5.0)
                                    : ScreenUtil().setHeight(20.0),
                                left: ScreenUtil().setWidth(100.0),
                                bottom: i == 0
                                    ? ScreenUtil().setHeight(10.0)
                                    : ScreenUtil().setHeight(0.0)),
                        elevation: 0.4,
                        nip: BubbleNip.no,
                        color: myMessage.img != null
                            ? Colors.transparent
                            : Colors.blue,
                        style: new BubbleStyle(
                            radius:
                                Radius.circular(ScreenUtil().setWidth(40.0))),
                        nipHeight: ScreenUtil().setHeight(20),
                        nipWidth: ScreenUtil().setWidth(23),
                        alignment: Alignment.centerRight,
                        child: getMyMessageType(myMessage,
                            isMine: myMessage.sender!.id == userId),
                      ),
                    );
                    // My Message
                  } else {
                    // Peer Message
                    return InkWell(
                      onLongPress: () {
                        // Show dialog to delete message
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: CircleAvatar(
                              backgroundColor: Colors.amber,
                              child: CachedNetworkImage(
                                imageUrl: myMessage.sender!.photoUrl ??
                                    'https://bitpointx.com.au/img/logo/bitpoint.png',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: AutoSizeText(
                                    myMessage.sender!.name ?? '',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Bubble(
                                  padding: myMessage.messageType == 0
                                      ? BubbleEdges.all(9)
                                      : BubbleEdges.all(0),
                                  nip: BubbleNip.no,
                                  margin: BubbleEdges.only(top: 5),
                                  color: myMessage.img != null
                                      ? Colors.transparent
                                      : Color(
                                          0xfff0f0f0,
                                        ),
                                  nipHeight: ScreenUtil().setHeight(20),
                                  nipWidth: ScreenUtil().setWidth(23),
                                  style: new BubbleStyle(
                                    radius: Radius.circular(
                                      ScreenUtil().setWidth(
                                        40.0,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  elevation: 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      getMyMessageType(
                                        myMessage,
                                        isMine: myMessage.sender!.id == userId,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildBottomSection(),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  getMyMessageType(Message myMessage, {bool isMine = true}) {
    if (myMessage.messageType == 0) {
      return SelectableText(
        '${myMessage.message}',
        textAlign: TextAlign.start,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 17,
          color: isMine ? Colors.white : Colors.black,
        ),
      );
    } else if (myMessage.messageType == 1) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FullScreenImageScreen(
                myMessage.img!,
              ),
            ),
          );

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => FullScreenImageScreen(Constants.SAMPLE_IMAGE_URL),
          //   ),
          // );
        },
        child: CachedNetworkImage(
          imageUrl: myMessage.img!,
          // imageUrl: Constants.SAMPLE_IMAGE_URL,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      );
    } else if (myMessage.messageType == 2) {
      // return ChangeNotifierProvider.value(
      //   value: myMessage,
      //   child: Container(
      //     child: Consumer<MessageModel>(
      //       builder: (ctx, messageProvider, _) {
      //         return Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             Row(
      //               children: <Widget>[
      //                 InkWell(
      //                   onTap: () {
      //                     _loadFile(
      //                         Constants.USERS_MESSAGES_IMAGES +
      //                             '${myMessage.img}',
      //                         messageProvider);
      //                     if (messageProvider.currentIcon == 0)
      //                       messageProvider.currentIcon = 1;
      //                     else
      //                       messageProvider.currentIcon = 0;
      //                   },
      //                   child: messageProvider.currentIcon == 0
      //                       ? Icon(
      //                           FontAwesomeIcons.play,
      //                           size: 25,
      //                         )
      //                       : Icon(
      //                           FontAwesomeIcons.pause,
      //                           size: 25,
      //                         ),
      //                 ),
      //               ],
      //             ),
      //             Padding(
      //                 padding: const EdgeInsets.only(left: 50, top: 5),
      //                 child: AutoSizeText(
      //                     '${messageProvider.playerText == '00:00:00' ? '' : messageProvider.playerText}',
      //                     style: TextStyle(fontSize: 12)))
      //           ],
      //         );
      //       },
      //     ),
      //   ),
      // );

      return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isMine
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: AutoSizeText(
                'Question Attachment',
                style: TextStyle(
                  color: isMine ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  // decoration: TextDecoration.underline,
                ),
              ),
            ),
            HtmlWidget(
              '${myMessage.question?.question}',
              textStyle: TextStyle(
                fontSize: 14,
                letterSpacing: 0.5,
                color: isMine ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(
                    () => QuestionDetailScreen(question: myMessage.question!));
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.secondary,
              )),
              child: AutoSizeText(
                'View Question',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  _buildBottomSection() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.circular(8.0 * 4))),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () {
                      // Upload Photo Implementation
                      startGetAndUploadPhoto();
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.image,
                        ),
                      ],
                    )),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    autocorrect: true,
                    maxLines: null,
                    onChanged: _onMessageChanged,
                    // ignore: deprecated_member_use
                    toolbarOptions: ToolbarOptions(
                      paste: true,
                      selectAll: true,
                      copy: true,
                    ),
                    // onChanged: (msg) {},
                    focusNode: _focusNode,

                    keyboardType: TextInputType.multiline,
                    controller: _messageController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type your message",
                    ),
                    autofocus: false,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8, top: 5, bottom: 5),
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () {
              if (messageText.trim() == '') {
                Tools.showErrorToast('Can\'t send empty messages');
              } else {
                _sendMessage();
              }
            },
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Icon(
              FontAwesomeIcons.paperPlane,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  void startGetAndUploadPhoto() async {
    int photo = 2;
    await showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: AutoSizeText('Select Image Source'),
            children: <Widget>[
              SimpleDialogOption(
                child: AutoSizeText('Photo with Camera'),
                onPressed: () {
                  Navigator.pop(ctx);
                  photo = 1;
                },
              ),
              SimpleDialogOption(
                child: AutoSizeText('Image from Gallery'),
                onPressed: () {
                  Navigator.pop(ctx);
                  photo = 0;
                },
              ),
              SimpleDialogOption(
                child: AutoSizeText('Cancel'),
                onPressed: () {
                  Navigator.pop(ctx);
                  photo = 2;
                },
              )
            ],
          );
        });

    if (photo == 2) {
      return;
    }

    ip.XFile? pickedFile = await ip.ImagePicker().pickImage(
      source: photo == 0 ? ip.ImageSource.gallery : ip.ImageSource.camera,
      imageQuality: 50,
    );

    final file = File(pickedFile!.path);

    if (file != null) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: AutoSizeText(
                'Are you sure to send this image ?',
                style: TextStyle(fontSize: 16),
              ),
              content: Image.file(
                file,
                fit: BoxFit.contain,
                width: 120,
                height: 120,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: AutoSizeText('cancel'),
                ),
                TextButton(
                    onPressed: () {
                      startSendImageMessageOrRecord(file);
                      Navigator.of(context).pop();
                    },
                    child: AutoSizeText('Send'))
              ],
            );
          });
    }
  }

  void startSendImageMessageOrRecord(var file) async {
    try {
      String imageUrl = await _api.uploadMessagePhoto(image: file);

      _sendMessage(messageType: 1, img: imageUrl);
    } catch (err) {
      Tools.showErrorToast('Failed to Send Image');
    }
    // var stream = new http.ByteStream(
    //     DelegatingStream.typed(file.openRead()));
    // var length = await file.length();

    // var accessToken = await _storageService
    //     .readValueFromSecureStorage(ACCESS_TOKEN_KEY);
    // var uri =
    //     Uri.parse('$API_ENDPOINT/messages/image-upload');
    // var request = new http.MultipartRequest("POST", uri);
    // var multipartFile = new http.MultipartFile(
    //     'image', stream, length,
    //     filename: Path.basename(file.path));
    // request.files.add(multipartFile);

    // request.headers["Authorization"] =
    //     'Bearer $accessToken';

    // var response = await request.send();
    // response.stream.transform(utf8.decoder).listen(
    //   (value) async {
    //     try {
    //       var jsonResponse = await jsonDecode(value);
    //       ();

    //       var error = jsonResponse['errors'];
    //       if (error == null) {
    //         String imageName = jsonResponse['imageUrl'];

    //         _sendMessage(messageType: 1, img: imageName);
    //       } else {
    //         print('error! ' + jsonResponse);
    //       }
    //     } catch (err) {
    //       print(err);
    //     }
    //   },
    // );
  }

  _sendMessage({int messageType = 0, String? img}) async {
    String messageId = uuid.v1();

    var mainMap = Map<String, Object>();

    mainMap['message'] = messageType == 0
        ? messageText.trim()
        : messageType == 1
            ? 'Send Photo'
            : 'Send Question Attachment';

    mainMap['messageType'] = messageType;

    mainMap['img'] = img!;

    mainMap['sender'] = loggedUser.id!;

    mainMap['senderName'] = loggedUser.name!;

    mainMap['senderPhotoUrl'] = loggedUser.photoUrl!;

    mainMap['topic'] = widget.topicId!;

    mainMap['id'] = messageId;

    mainMap['question'] = widget.questionId!;

    String jsonString = jsonEncode(mainMap);

    socket.emit('newMessage', jsonString);

    if (messageType == 1) {
      // insert image at the top of the list
      setState(() {
        _myMessages.insert(
          0,
          Message(
            id: messageId,
            message: mainMap['message'] as String?,
            messageType: mainMap['messageType'] as int?,
            img: mainMap['img']as String?,
            topic: mainMap['topic']as String?,
            sender: Sender(
              name: loggedUser.name,
              id: loggedUser.id,
              photoUrl: loggedUser.photoUrl,
            ),
          ),
        );

        messageText = '';
        _messageController.text = '';
      });
    } else if (messageType == 2) {
      // Question type
      setState(() {
        _myMessages.insert(
            0,
            Message(
              id: messageId,
              message: mainMap['message'] as String?,
              messageType: mainMap['messageType'] as int?,
              img: null,
              topic: mainMap['topic'] as String?,
              question: Question(
                id: widget.questionId,
                question: widget.questionTitle,
              ),
              sender: Sender(
                name: loggedUser.name,
                id: loggedUser.id,
                photoUrl: loggedUser.photoUrl,
              ),
            ));
        messageText = '';
        _messageController.text = '';
      });
    } else {
      setState(() {
        _myMessages.insert(
            0,
            Message(
              id: messageId,
              message: mainMap['message'] as String?,
              messageType: mainMap['messageType'] as int?,
              img: null,
              topic: mainMap['topic'] as String?,
              sender: Sender(
                name: loggedUser.name,
                id: loggedUser.id,
                photoUrl: loggedUser.photoUrl,
              ),
            ));
        messageText = '';
        _messageController.text = '';
      });
    }
  }
}
