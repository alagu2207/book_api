import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'bookmodel.dart'; // Ensure you import your BookModel class

class BookList extends GetxController {
  var books = <Welcome>[].obs; // Observable list of books
  var isLoading = true.obs; // Loading state for general use
  var fetchedBook = Rx<Welcome?>(null); // Observable for fetched book by ID

  @override
  void onInit() {
    super.onInit();
    getBooks(); // Initialize by loading all books
  }

  Future<void> getBooks() async {
    isLoading.value = true; // Set loading to true before the request
    try {
      final response = await http.get(Uri.parse(
          "https://671c904e09103098807a79af.mockapi.io/api/booklist?sortBy=id&order=asc"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        books.assignAll(data.map((item) => Welcome.fromJson(item)).toList());
      } else {
        Get.snackbar('Error', 'Failed to load books: ${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3));
      }
    } catch (e) {
      Get.snackbar('Error', 'Error fetching books: $e',
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadBook(String title, String author, String description,
      int datepublished, String publisher, String welcomeDescription) async {
    isLoading.value = true; // Start loading for upload
    final book = Welcome(
      name: title,
      author: author,
      description: description,
      datepublished: datepublished,
      publisher: publisher,
      id: "", // Placeholder; the actual ID should be returned by the server
      welcomeDescription: welcomeDescription,
    );

    try {
      final response = await http.post(
        Uri.parse("https://671c904e09103098807a79af.mockapi.io/api/booklist"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(book.toJson()),
      );

      if (response.statusCode == 201) {
        books.add(book); // Add the new book to the observable list
        Get.snackbar('Notification', 'Book uploaded successfully');
      } else {
        Get.snackbar('Error', 'Failed to upload book: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error uploading book: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBookById(String id) async {
    isLoading.value = true; // Start loading indicator
    fetchedBook.value = null; // Clear previously fetched data
    print("Starting to fetch book...");
    try {
      final response = await http.get(Uri.parse(
          "https://671c904e09103098807a79af.mockapi.io/api/booklist/${Uri.encodeComponent(id)}"));

      print("Response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        fetchedBook.value = Welcome.fromJson(data); // Update fetched book
        Get.snackbar(
            'Notification', "Book fetched: ${fetchedBook.value?.name}");
      } else {
        Get.snackbar('Error', 'Failed to fetch book: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error fetching book: $e');
    } finally {
      isLoading.value = false; // Stop loading indicator
      print("Finished fetching book.");
    }
  }
}
