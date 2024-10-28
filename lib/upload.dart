import 'package:flutter/material.dart';
import 'package:flutter_application_3/api/bookmodel.dart';
import 'package:get/get.dart';
import 'api/booklist.dart';

final BookList bookuploadController = Get.put(BookList());
final TextEditingController titleController = TextEditingController();
final TextEditingController authorController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
final TextEditingController datepublishedController = TextEditingController();
final TextEditingController publisherController = TextEditingController();
final TextEditingController welcomeDescriptionController =
    TextEditingController();

Widget upload() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Upload a Book',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: 'Book Title'),
        ),
        TextField(
          controller: authorController,
          decoration: InputDecoration(labelText: 'Author'),
        ),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(labelText: 'Description'),
          maxLines: 3,
        ),
        TextField(
          controller: datepublishedController,
          decoration: InputDecoration(labelText: 'Date published'),
          maxLines: 1, // Usually date input is single line
        ),
        TextField(
          controller: publisherController,
          decoration: InputDecoration(labelText: 'Publisher'),
          maxLines: 1, // Usually publisher input is single line
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
             int? datepublished;
    try {
      datepublished = int.parse(datepublishedController.text);
    } catch (e) {
      print("Invalid date: ${datepublishedController.text}");
      return; // Exit the function if the conversion fails
    }
            bookuploadController.uploadBook(
                titleController.text,
                authorController.text,
                descriptionController.text,
                datepublished,
                publisherController.text,
                welcomeDescriptionController.text);
            print("Book uploaded!");
          },
          child: Text('Upload'),
        ),
      ],
    ),
  );
}
