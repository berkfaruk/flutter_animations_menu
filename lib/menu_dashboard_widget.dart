// ignore_for_file: unused_field

import 'package:flutter/material.dart';

const TextStyle menuFontStyle = TextStyle(color: Colors.white, fontSize: 20);
const Color backgroundColor = Color(0xFF343442);

class MenuDashboard extends StatefulWidget {
  const MenuDashboard({super.key});

  @override
  State<MenuDashboard> createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  late double screenHeight, screenWidth;
  bool isMenuActive = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _menuOffsetAnimation;
  late Animation<double> _scaleMenuAnimation;
  final Duration _duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(_controller);
    _scaleMenuAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _menuOffsetAnimation = Tween(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            createMenu(context),
            createDashboard(context),
          ],
        ),
      ),
    );
  }

  Widget createMenu(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: ScaleTransition(
        scale: _scaleMenuAnimation,
        child: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dashboard", style: menuFontStyle),
                SizedBox(height: 10),
                Text("Messages", style: menuFontStyle),
                SizedBox(height: 10),
                Text("Utility Bills", style: menuFontStyle),
                SizedBox(height: 10),
                Text("Fund Transfer", style: menuFontStyle),
                SizedBox(height: 10),
                Text("Branches", style: menuFontStyle),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createDashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      top: 0,
      bottom: 0,
      left: isMenuActive ? 0.5 * screenWidth : 0,
      right: isMenuActive ? -0.4 * screenWidth : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius:
              isMenuActive ? BorderRadius.all(Radius.circular(40)) : null,
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.white),
                        onTap: () {
                          setState(() {
                            if (isMenuActive) {
                              _controller.reverse();
                            } else {
                              _controller.forward();
                            }
                            isMenuActive = !isMenuActive;
                          });
                        },
                      ),
                      Text(
                        "My Cards",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Icon(Icons.add_circle_outline, color: Colors.white),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 200,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          color: Colors.blue,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.red,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.green,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Student $index'),
                          trailing: Icon(Icons.add),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: 50)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
