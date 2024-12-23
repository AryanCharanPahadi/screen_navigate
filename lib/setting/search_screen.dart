import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screen_navigate/setting/tab_button.dart';

import 'chat_item.dart';
import 'date_header.dart';
import 'inbox.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Widget> _filteredItems = [];
  final List<String> _recentSearches = [];

  // Sample data from ChatInbox (for demo purposes; replace with real data)
  final Map<int, List<Widget>> chatItemsPerTab = {
    0: [
      const DateHeader(date: 'Dec 7th'),
      const ChatItem(
        name: 'Shalu',
        message: 'Ears',
        time: '3:17 PM',
        status: 'Expired',
      ),
      const ChatItem(
        name: 'Anjali Velhankar',
        message: 'It seems you haven\'t responded in a',
        time: '1:37 PM',
        status: 'Expired',
      ),
    ],
    1: [
      const DateHeader(date: 'Dec 6th'),
      const ChatItem(
        name: 'Tsering Palmo',
        message: 'It seems you haven\'t responded in a',
        time: '11:24 AM',
        status: 'Active Chats',
      ),
      const ChatItem(
        name: 'Jigmat Palmo',
        message: 'Grade 3',
        time: '12:33 PM',
        status: 'Active Chats',
      ),
    ],
    2: [
      const DateHeader(date: 'Dec 5th'),
      const ChatItem(
        name: 'Sonam',
        message: 'Hello, how are you?',
        time: '10:00 AM',
        status: 'Broadcast',
      ),
      const ChatItem(
        name: 'Tashi',
        message: 'Thank you!',
        time: '9:30 AM',
        status: 'Broadcast',
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _showLoader();
  }

  void _showLoader() async {
    // Show the loader initially
    setState(() {
      _isLoading = true;
    });

    // Wait for 5 seconds
    await Future.delayed(const Duration(seconds: 2));

    // After 5 seconds, hide the loader and fetch contacts
    setState(() {
      _isLoading = false;
    });
  }

  bool _isLoading = false;

  void _filterResults(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredItems = [];
      });
      return;
    }

    // Flatten all chat items into a single list
    List<Widget> allChatItems =
        chatItemsPerTab.values.expand((list) => list).toList();

    // Filter based on the query
    List<Widget> matches = allChatItems.where((item) {
      if (item is ChatItem) {
        return item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.message.toLowerCase().contains(query.toLowerCase()) ||
            item.status.toLowerCase().contains(query.toLowerCase());
      }
      return false;
    }).toList();

    setState(() {
      _filteredItems = matches.isNotEmpty
          ? matches
          : [
              const Text("No match found", style: TextStyle(color: Colors.grey))
            ];
    });
  }

  void _onSearchComplete() {
    String searchText = _searchController.text.trim();
    if (searchText.isNotEmpty && !_recentSearches.contains(searchText)) {
      setState(() {
        _recentSearches.add(searchText);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = _searchController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.green,
            ))
          : SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button and Search Bar
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            kIsWeb
                                ? Icons
                                    .arrow_back // Web uses standard back arrow
                                : Platform.isIOS
                                    ? Icons
                                        .arrow_back_ios // iOS-specific back arrow
                                    : Icons
                                        .arrow_back, // Default back arrow for other platforms
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChatInbox()),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              _filterResults(value);
                            },
                            onEditingComplete: _onSearchComplete,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTabButtons(
                          initialSelectedIndex:
                              0, // Initially "All chats" is selected
                          tabs: const [
                            'All messages',
                            'Whatsapp Name or Phone',
                          ], // Add more tabs here
                          onTabSelected: (index) {
                            // Handle tab selection
                            if (kDebugMode) {
                              print('Selected Tab Index: $index');
                            }
                            // You can trigger different actions based on the selected tab here
                          },
                        ),
                      ],
                    ),

                    // Recent Search Section Title (visible only if not searching)
                    if (!isSearching) ...[
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.history,
                              color: Colors.grey[400],
                            ),
                          ),
                          Text(
                            'Recent search',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // List of Recent Searches
                      ..._recentSearches.map((search) => ListTile(
                            title: Text(search),
                            onTap: () {
                              _searchController.text = search;
                              _filterResults(search);
                            },
                          )),
                    ],

                    const SizedBox(height: 10),

                    // Results Section
                    Expanded(
                      child: ListView(
                        children: _filteredItems,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
