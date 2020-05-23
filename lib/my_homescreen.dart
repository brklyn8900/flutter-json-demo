import 'package:flutter/material.dart';
import 'package:json_practice/users.dart';
import 'services.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<Users> _users;
  bool _loading;

  @override
  void initState() {
    super.initState();
    Services.getUsers().then((user) {
      setState(() {
        _users = user;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _length = _users.length.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : '$_length Users'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, index) {
              Users users = _users[index];

              var splitname = users.name.split(' ');

              var lat = users.address.geo.lat;
              var long = users.address.geo.lng;
              String fInitial = splitname[0].substring(0, 1);
              String sInitial = splitname[1].substring(0, 1);

              String url = 'http://maps.google.com/maps?q=$long,$long';
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: Text('$fInitial$sInitial'),
                ),
                trailing: Text(
                  users.id.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                title: Text(
                  users.name,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Long: $long : Lat: $lat',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  print(url);
                },
              );
            }),
      ),
    );
  }
}
