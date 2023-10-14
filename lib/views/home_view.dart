import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../services/generate_image.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_image.dart';
import '../helper/colors.dart';
import '../widgets/custom_text_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  var textController = TextEditingController();
  late AnimationController controller;
  bool isLoading = false;
  bool showImage = false;
  Uint8List? byteImage;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return (width <= 800) ? buildUI(width) : buildUIWeb(width, height);
  }

  Widget buildUIWeb(double width, double height) {
    return Row(
      children: [
        Flexible(
          child: Image.asset(
            'assets/ai_back.jpg',
            height: height,
            fit: BoxFit.cover,
          ),
        ),
        Flexible(child: buildUI(width)),
      ],
    );
  }

  Widget buildUI(double width) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: blackBright,
      progressIndicator: CircularProgressIndicator(
        color: purpleBright,
        strokeWidth: 6.0,
      ),
      child: Scaffold(
        backgroundColor: blackBright,
        appBar: customAppBar(),
        body: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                Flexible(
                  child: CustomTextField(
                    textController: textController,
                    onFieldSubmitted: sendRequestToImageGenerator,
                  ),
                ),
                CustomButton(
                  width: 60,
                  height: 50,
                  colors: [purpleBright, purpleBright],
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onTap: () {
                    sendRequestToImageGenerator(textController.text);
                  },
                ),
              ],
            ),
            const Spacer(),
            showImage
                ? Image.memory(
                    byteImage!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.fill,
                  )
                : CustomImage(
                    size: 300,
                    imagePath: 'assets/ai.jpg',
                    animation: isLoading
                        ? Tween(
                            end: 0.5,
                            begin: 1.0,
                          ).animate(controller)
                        : null,
                  ),
            const Spacer(),
            CustomButton(
              width: 270,
              height: 60,
              colors: [
                cyan,
                purpleBright2,
                purpleBright,
              ],
              child: const Text(
                'DOWENLOAD IMAGE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () {
                if (byteImage != null) {
                  ImageGallerySaver.saveImage(
                    byteImage!,
                    name: textController.text,
                  );
                  customMessage(Colors.green, 'The Image Was Saved');
                } else {
                  customMessage(Colors.red, 'There Is No Image To Download');
                }
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void sendRequestToImageGenerator(String text) async {
    if (text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await GenerateImage().generateImage(text: text).then((value) {
        setState(() {
          isLoading = false;
          showImage = true;
          byteImage = value;
        });
      }).onError((error, _) {
        setState(() {
          isLoading = false;
        });
        customMessage(Colors.red, 'No Internet Connection');
      });
    } else {
      customMessage(Colors.red, 'Please Enter Text To Covert Into Image');
    }
  }

  void customMessage(Color color, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          title,
        ),
      ),
    );
  }
}
