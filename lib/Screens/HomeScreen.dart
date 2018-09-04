import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  SearchState createState() => new SearchState();
}

class SearchState extends State<HomeScreen> {
  Widget appBarTextView = new Text(
    "SearchView",
    style: new TextStyle(color: Colors.black),
  );
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.black,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController searchView = TextEditingController();
  List<String> searchlist;
  bool isSearching;
  String searchString = "";

  SearchState() {
    searchView.addListener(() {
      if (searchView.text.isEmpty) {
        setState(() {
          isSearching = false;
          searchString = "";
        });
      } else {
        setState(() {
          isSearching = true;
          searchString = searchView.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isSearching = false;
    init();
  }

  void init() {
    searchlist = List();
    searchlist.add("Andaman and Nicobar Islands");
    searchlist.add("Andhra Pradesh");
    searchlist.add("Arunachal Pradesh");
    searchlist.add("UP");
    searchlist.add("Punjab");
    searchlist.add("Bihar");
    searchlist.add("Chandigarh");
    searchlist.add("Delhi");
    searchlist.add("Haryana");
    searchlist.add("Himachal Pradesh");
    searchlist.add("Kerala");
    searchlist.add("Mizoram");
    searchlist.add("Nagaland");
    searchlist.add("Rajasthan");
    searchlist.add("Sikkim");
    searchlist.add("Tamil Nadu");
    searchlist.add("Uttaranchal");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context),
      body: new ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: isSearching ? _buildSearchList() : _buildList(),
      ),
    );
  }

  List<Item> _buildList() {
    return searchlist.map((contact) => Item(contact)).toList();
  }

  List<Item> _buildSearchList() {
    if (searchString.isEmpty) {
      return searchlist.map((contact) => Item(contact)).toList();
    } else {
      List<String> searchList = List();
      for (int i = 0; i < searchlist.length; i++) {
        String name = searchlist.elementAt(i);
        if (name.toLowerCase().contains(searchString.toLowerCase())) {
          searchList.add(name);
        }
      }
      return searchList.map((contact) => Item(contact)).toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTextView,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(
                    Icons.close,
                    color: Colors.black,
                  );
                  this.appBarTextView = TextField(
                    controller: searchView,
                    autofocus: true,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.black)),
                  );
                  searchStart();
                } else {
                  searchEnd();
                }
              });
            },
          ),
        ]);
  }

  void searchStart() {
    setState(() {
      isSearching = true;
    });
  }

  void searchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.black,
      );
      this.appBarTextView = Text(
        "SearchView",
        style: TextStyle(color: Colors.black),
      );
      isSearching = false;
      searchView.clear();
    });
  }
}

class Item extends StatelessWidget {
  final String name;

  Item(this.name);

  @override
  Widget build(BuildContext context) {
    return new ListTile(title: Text(this.name));
  }
}
