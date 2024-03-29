import 'package:flutter/material.dart';
import 'package:flutter_stock/screens/add_product/add_product_screen.dart';
import 'package:flutter_stock/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_stock/screens/drawer/contact/contact_screen.dart';
import 'package:flutter_stock/screens/drawer/term/term_screen.dart';
import 'package:flutter_stock/screens/login/login_screen.dart';

import 'package:flutter_stock/screens/drawer/about/about_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder> {
  "/login": (BuildContext context) => LoginScreen(),
  "/about": (BuildContext context) => AboutScreen(),
  "/contact": (BuildContext context) => ContactScreen(),
  "/term": (BuildContext context) => TermScreen(),
  "/dashboard": (BuildContext context) => DashboardScreen(),
  "/addproduct": (BuildContext context) => AddProduceScreen()
};