import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api/booklist.dart';

final TextEditingController idController = TextEditingController();
final BookList bookuploadController = Get.find<BookList>();
Widget fetchid({required String labelText}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'FETCH BY ID',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        TextField(
          controller: idController,
          decoration: InputDecoration(labelText: labelText),
        ),
        SizedBox(height: 20),
      ElevatedButton(
  onPressed: () async {
    if (idController.text.isNotEmpty) {
      print("Fetching book by ID: ${idController.text}"); // Debugging
      await bookuploadController.fetchBookById(idController.text); // Ensure await here
      idController.clear(); // Clear the input field after fetching
    } else {
      Get.snackbar("Error", "Please enter a valid Book ID");
    }
  },
  child: Text('Fetch'),
),

        SizedBox(height: 20),
        Obx(() {
          if (bookuploadController.isLoading.value) {
            return CircularProgressIndicator();
          }

          final book = bookuploadController.fetchedBook.value;
          if (book == null) {
            return Text("No book found or hasn't been fetched yet.");
          }

          return Card(
            elevation: 4.0,
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.name ?? 'Unknown Title',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Author: ${book.author ?? 'Unknown Author'}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        book.description ?? 'No description available.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        ),
      ],
    ),
  );
}
