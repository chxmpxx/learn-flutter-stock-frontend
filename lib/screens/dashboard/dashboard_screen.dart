import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_stock/screens/bottomnav/account/account_screen.dart';
import 'package:flutter_stock/screens/bottomnav/home/home_screen.dart';
import 'package:flutter_stock/screens/bottomnav/notification/notification_screen.dart';
import 'package:flutter_stock/screens/bottomnav/setting/setting_screen.dart';
import 'package:flutter_stock/screens/bottomnav/stock/stock_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // สร้างตัวแปรเก็บชื่อและอีเมลผู้ใช้
  String? nameAccount, emailAccount;

  // สร้าง obj shared preferences
  SharedPreferences? sharedPreferences;

  // สร้างตัวแปร List เก็บรายการหน้าที่ต้องการเปลี่ยนใน Bottom Navigationbar
  int _currentIndex = 0;
  String _title = 'หน้าหลัก';

  @override
  void initState() {
    super.initState();
    _title = 'หน้าหลัก';

    // ตรวจ sharedPreferences ของผู้ใช้
    checkLoginStatus();
  }

  // Check Login Status
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if(sharedPreferences?.getString("storeEmail") == null) {
      // ส่งกลับไปหน้า Login
      Navigator.pushNamed(context, '/login');
    }

    // ถ้าไม่ set ค่าจะไม่ update จะเป็น null
    setState(() {
      nameAccount = sharedPreferences?.getString('storeName');
      emailAccount = sharedPreferences?.getString('storeEmail');
    });
    
  }

  final List<Widget> _children = [
    HomeScreen(),
    StockScreen(),
    NotificationScreen(),
    SettingScreen(),
    AccountScreen()
  ];

  // สร้าง method สำหรับการเปลี่ยนหน้า
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0: _title = 'หน้าหลัก';
          break;
        case 1: _title = 'สต๊อกสินค้า';
          break;
        case 2: _title = 'แจ้งเตือน';
          break;
        case 3: _title = 'ตั้งค่า';
          break;
        case 4: _title = 'ฉัน';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              // เคลียค่าใน shared preferences
              sharedPreferences?.clear();
              Navigator.pushNamed(context, '/login');
            },
            child: Text('ออกจากระบบ', style: TextStyle(color: Colors.white),)
          )
        ],
      ),

      // Drawer menu
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: GestureDetector(
                  onTap: () { },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg'),
                  ),
                ),
                otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () { },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://images.megapixl.com/4707/47075236.jpg'),
                  ),
                )
                ],
                accountName: Text('$nameAccount'), 
                accountEmail: Text('$emailAccount'),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://www.vickyalvearshecter.com/wp-content/uploads/2015/02/2012-06-08_0000066-as-Smart-Object-1-600x400.jpg'),
                    fit: BoxFit.fill
                  )
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('เกี่ยวกับเรา'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/about');
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text('ข้อมูลการใช้งาน'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/term');
                },
              ),
              ListTile(
                leading: Icon(Icons.mail),
                title: Text('ติดต่อทีมงาน'),
                onTap: (){ 
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/contact');
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('ออกจากระบบ'),
                onTap: (){ 
                  // เคลียค่าใน shared preferences
                  sharedPreferences?.clear();
                  Navigator.pushNamed(context, '/login');
                },
              ),
              Divider(color: Colors.green[200],),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('ปิดเมนู'),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        )
      ),
      
      body: _children[_currentIndex],

      // Bottom Navigation bar
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'สต๊อก'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'แจ้งเตือน'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'ตั้งค่า'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'ฉัน')
        ]
      ),

    );
  }
}