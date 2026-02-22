import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const AddNewBlogPage(),
  );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if(pickedImage != null){
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() { 
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.done_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: image == null? DottedBorder(
                  options: const RoundedRectDottedBorderOptions(
                    radius: Radius.circular(10),
                    color: AppPallete.borderColor, 
                    dashPattern: const [10, 2],
                    strokeCap: StrokeCap.round,
                  ),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 40,
                        ),
                        SizedBox(height: 15,),
                        Text(
                          'Select your image',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  )
                ): ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 10,
                  children: [
                    'Technology',
                    'Business',
                    'Programming',
                    'Entertainment',
                  ].map(
                    (e) => GestureDetector(
                      onTap: (){
                        setState(() {
                          if(selectedTopics.contains(e)){
                            selectedTopics.remove(e);
                          } else {
                            selectedTopics.add(e);
                          }
                        });
                      },
                      child: Chip(
                        label: Text(
                          e,
                          style: TextStyle(
                            color: selectedTopics.contains(e)? Colors.black: Colors.white,
                          ),
                        ),
                        color: selectedTopics.contains(e)? const WidgetStatePropertyAll(AppPallete.gradient2): null,
                        side: selectedTopics.contains(e)? 
                          const BorderSide(
                            color: AppPallete.gradient2
                          )
                        : const BorderSide(
                          color: AppPallete.borderColor
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ),
              const SizedBox(height: 15,),
              BlogEditor(
                controller: titleController, 
                hintText: 'Blog title'
              ),
              const SizedBox(height: 15,),
              BlogEditor(
                controller: contentController, 
                hintText: 'Blog content'
              ),
            ],
          ),
        ),
      ),
    );
  }
}