import 'package:flutter/material.dart';
import 'package:password_manager/Database/database_helper.dart';
import 'package:password_manager/Models/password_model.dart';
import 'ViewPasswordPage.dart';
import 'AddPasswordPage.dart'; // Import the new page

class Vaultpage extends StatefulWidget {
  const Vaultpage({super.key});

  @override
  State<Vaultpage> createState() => _VaultpageState();
}

class _VaultpageState extends State<Vaultpage> {
  bool showSearchBar = false;
  List<PasswordModel> passwords = [];
  List<PasswordModel> filteredPasswords = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPasswords();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchPasswords() async {
    passwords = await DatabaseHelper().getPasswords();
    filteredPasswords = passwords;
    setState(() {});
  }

  void _filterPasswords(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPasswords = passwords;
      } else {
        filteredPasswords = passwords
            .where((password) =>
                password.domain.toLowerCase().contains(query.toLowerCase()) ||
                password.username.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> deletePassword(int id) async {
    await DatabaseHelper().deletePassword(id);
    fetchPasswords();
  }

  Future<void> _handlePasswordCardClick(
      int index, PasswordModel password) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Viewpasswordpage(password: password),
      ),
    );

    if (result == true) {
      fetchPasswords();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Saved Passwords',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showSearchBar = !showSearchBar;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showSearchBar)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: searchController,
                          onChanged: _filterPasswords,
                          decoration: InputDecoration(
                            hintText: 'Search by domain or username...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    Container(
                      height: 700,
                      width: 400,
                      margin: const EdgeInsets.fromLTRB(10, 12, 10, 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: filteredPasswords.isEmpty
                          ? const Center(
                              child: Text(
                                'No passwords found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: filteredPasswords.length,
                              itemBuilder: (context, index) {
                                return _buildListItem(
                                    index, filteredPasswords[index]);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddPasswordPage()),
                  ).then((_) => fetchPasswords());
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(int index, PasswordModel password) {
    return GestureDetector(
      onTap: () {
        _handlePasswordCardClick(index, password);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    password.iconUrl ??
                        'https://via.placeholder.com/48', // Fallback if iconUrl is null
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/logo.png', // Fallback to a local asset if the network image fails
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      password.domain,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      password.username,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                deletePassword(password.id!); // Delete the selected password
              },
            ),
          ],
        ),
      ),
    );
  }
}
