import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Text('เนื้อหาหน้าบัญชีของฉัน'),
       ),
    );
  }
}