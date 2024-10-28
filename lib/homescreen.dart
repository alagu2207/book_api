import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api/booklist.dart'; // Ensure you import your BookList controller
import 'upload.dart';
import 'fetch.dart'; // Import your upload widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BookList bookListController = Get.put(BookList());

  int _selectedIndex =
      0; // Track the currently selected index for the BottomNavigationBar

  @override
  void initState() {
    super.initState();
    // Fetch books when the widget is initialized
    bookListController.getBooks();
  }

  // Method to handle navigation when a bottom navigation item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the pages for the bottom navigation
    List<Widget> _pages = [
      _buildHomePage(),
      _buildAnotherPage(), // This will show the upload interface
      _buildProfilePage(), // Example for profile page
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("GetX Material"),
      ),
      body: _pages[_selectedIndex], // Show the currently selected page

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Current selected index
        onTap: _onItemTapped, // Callback for item tap
      ),
    );
  }

  // Home page content
  Widget _buildHomePage() {
    return Obx(() {
      // Check if the books list is empty
      if (bookListController.books.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Loading books..."),
            ],
          ),
        );
      }

      // If books are loaded, display them in a ListView
      return ListView.builder(
        itemCount: bookListController.books.length,
        itemBuilder: (context, index) {
          final book = bookListController.books[index];
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    book.id, // Book title
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    book.name, // Book title
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Author: ${book.author}', // Book author
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    book.description, // Book description
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  // Upload page content
  Widget _buildAnotherPage() {
    return upload(); // Call the upload function to display the upload widget
  }

  // Placeholder for profile page
  Widget _buildProfilePage() {
    return fetchid(labelText: 'labelText');
  }
}
