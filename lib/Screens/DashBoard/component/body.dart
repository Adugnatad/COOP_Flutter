import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Transfer/balanceScreen.dart';
import 'package:flutter_auth/Screens/AirTime/airtimeScreen.dart';
import 'package:flutter_auth/Screens/Profile/profileScreen.dart';
import 'package:flutter_auth/icons.dart';

class MakeDashboardItems extends StatefulWidget {
  // const MakeDashboardItems({Key? key}) : super(key: key);
  final String username;
  MakeDashboardItems(this.username);

  @override
  _MakeDashboardItemsState createState() => _MakeDashboardItemsState(username);
}

class _MakeDashboardItemsState extends State<MakeDashboardItems> {
  final String username;
  _MakeDashboardItemsState(this.username);

  Card makeDashboardItem(String title, int index, Widget widget) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromRGBO(0, 173, 239, 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 3,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BalanceScreen(username);
                  },
                ),
              );
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return profileScreen(username);
                  },
                ),
              );
            }
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AirtimeScreen(username);
                  },
                ),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 10),
              Center(child: widget),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildbalanceIcon() {
    return Icon(
      MyFlutterApp.balance,
      size: 60,
      color: Colors.white,
    );
  }

  Widget _buildmoneyIcon() {
    return Icon(
      MyFlutterApp.money_transfer,
      size: 70,
      color: Colors.white,
    );
  }

  Widget _buildairtimeIcon() {
    return Icon(
      MyFlutterApp.airtime,
      size: 60,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 173, 239, .3),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text("Thank you for banking with us",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 173, 239, 1),
                        )),
                    SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          makeDashboardItem("Transfer Money", 0, _buildmoneyIcon()),
          makeDashboardItem("View Balance", 1, _buildbalanceIcon()),
          makeDashboardItem("Buy Airtime", 2, _buildairtimeIcon()),
        ],
      ),
    );
  }
}
