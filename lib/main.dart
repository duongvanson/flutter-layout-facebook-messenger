import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());
var _storys = [
  "Dương Sơn",
  "Hải Yến",
  "Huyền Anh",
  "Lan Nguyễn",
  "Hoàng Anh",
  "Dương Sơn",
  "Hải Yến",
  "Sương Tư",
  "Lan Nguyễn",
  "Hoàng Anh"
];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _tabSelect = 0;
  var _title = ["Chat", "Danh bạ"];

  static Widget _item(IconData icon) {
    return IconButton(
        icon: CircleAvatar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey[300],
            child: Icon(
              icon,
              size: 20,
            )),
        color: Colors.black,
        onPressed: () {});
  }

  var _acction = [
    [
      _item(Icons.camera_alt),
      _item(Icons.edit),
    ],
    [_item(Icons.contacts), _item(Icons.add)],
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Facebook Messenger Layout",
      home: Container(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Center(
              child: Stack(
                children: <Widget>[
                  CircleAvatar(),
                  Positioned(
                    right: 0,
                    top: -2,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text("3",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),),
                      ),
                    ),
                  )
                ],
              ),
            ),
            title: Text(
              _title[_tabSelect],
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            actions: _acction[_tabSelect],

          ),
          body: _tabSelect == 0 ? ChatLayout() : ContactLayout(),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    size: 28,
                  ),
                  title: Text("Chat"),
                  activeIcon: Icon(
                    Icons.chat_bubble,
                    size: 28,
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people_outline,
                    size: 28,
                  ),
                  title: Text("Danh bạ"),
                  activeIcon: Icon(
                    Icons.people,
                    size: 28,
                  ))
            ],
            currentIndex: _tabSelect,
            onTap: (tab) {
              _tabSelect = tab;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}

class ChatLayout extends StatelessWidget {
  var _status = [
    Icons.check_circle_outline,
    Icons.check_circle,
    Icons.hdr_weak
  ];
  var _messages = [
    {'name': 'Sơn Dương', 'last': "Hi, cậu", 'status': 0},
    {'name': 'Linh', 'last': "Hi, cậu", 'status': 2},
    {'name': 'Hải Yến', 'last': "Hi, cậu", 'status': 2},
    {'name': 'ICTU', 'last': "Hi, cậu", 'status': 1},
    {'name': 'Long Anh', 'last': "Hi, cậu", 'status': 0}
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[_seach(), _listStory(), _listMessenger()],
    );
  }

  Widget _seach() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Tìm kiếm",
            icon: Icon(
              Icons.search,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _listStory() {
    return Container(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _storys.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 25,
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Text(
                    "Tin của bạn",
                    style: TextStyle(color: Colors.grey[400]),
                  )
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Text(
                          _storys[index - 1].substring(0, 1).toUpperCase()),
                    ),
                  ),
                  Text(_storys[index - 1].split(' ')[1])
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _listMessenger() {
    return Expanded(
      child: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _messages[index]['name'],
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              _messages[index]['last'],
              style: TextStyle(color: Colors.grey),
            ),
            leading: CircleAvatar(
              child: Text(_messages[index]['name'].toString().substring(0, 1)),
            ),
            trailing: Icon(
              _status[_messages[index]['status']],
              color: _messages[index]['status'] == 2
                  ? Colors.blue
                  : Colors.grey[400],
            ),
          );
        },
      ),
    );
  }
}

class ContactLayout extends StatefulWidget {
  @override
  _ContactLayoutState createState() => _ContactLayoutState();
}

class _ContactLayoutState extends State<ContactLayout> {
  var _content = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[_menu(), _content == 0 ? _story() : _active()],
    );
  }

  _menu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        MaterialButton(
          onPressed: () {
            _content = 0;
            setState(() {});
          },
          child: Text("Tin (3)"),
          color: _content == 0 ? Colors.grey[200] : null,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        MaterialButton(
          onPressed: () {
            _content = 1;
            setState(() {});
          },
          child: Text("Đang hoạt động (5)"),
          color: _content == 1 ? Colors.grey[200] : null,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        )
      ],
    );
  }

  Widget _story() {
    return Expanded(
      child: GridView.count(
        padding: EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        children: _storys
            .map((name) => Container(
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 10,
                        left: 10,
                        child: CircleAvatar(
                          child: Text(name.substring(0, 1)),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _active() {
    return Expanded(
      child: ListView.builder(
        itemCount: _storys.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _storys[index],
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Stack(
                children: <Widget>[
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 8,
                          child: Icon(
                            Icons.brightness_1,
                            size: 12,
                            color: Colors.green,
                          )))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}