
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssl_comerce/view/device_info.dart';
import 'package:ssl_comerce/view/drawer/Details.dart';
import 'package:ssl_comerce/view/drawer/file_list.dart';
import 'package:ssl_comerce/view/drawer/payment_method.dart';
import '../../main.dart';
import '../../provider/drawer_provider.dart';
import '../../provider/theme_provider.dart';
import '../../service/local_storage.dart';
import '../component/app_style.dart';
import '../log_in_screen.dart';
import '../receipt_list_of_a_member_screen.dart';
import 'nav_setting/bank_accountinfo.dart';
import 'nav_setting/cc_info.dart';
import 'nav_setting/setting_screen.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    final drawerProvider=Provider.of<DrawerProvider>(context,listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      child: Drawer(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,

          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 2, child: _buildHeader(context)),
              Expanded(flex: 1, child: _buildFooter(context)),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildFooter(BuildContext context){
    return Container(
    //height: 200,
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //color: Colors.orangeAccent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          leading: Icon(
            Icons.settings,
            color: secondaryColor,
          ),
          title: Text("Setting"),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SettingScreen()));
            //SettingScreen
          },
        ),
        Consumer<ThemeProvider>(
          builder: (context,themeProvider,child){
            return ListTile(
              leading: Icon(
                switchValue?Icons.dark_mode_outlined:Icons.light_mode_outlined,
                color: secondaryColor,
              ),
              title: switchValue?Text("Dark Mode"):Text("Light Mode"),
              trailing: Switch(
                value: switchValue,
                onChanged: (val){
                  //themeProvider.darkTheme = !themeProvider.darkTheme;
                  setState(() {
                    switchValue = val;
                    if(switchValue){
                      MyApp.of(context).changeTheme(ThemeMode.dark);
                      //drawerProvider.setSwitchValue(false);
                      print(switchValue);
                    }
                    else{
                      MyApp.of(context).changeTheme(ThemeMode.light);
                      //drawerProvider.setSwitchValue(true);
                      print(switchValue);
                    }
                  });
                },
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: secondaryColor,
          ),
          title: Text("Log Out"),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  title: Center(child: SizedBox(height: 100,width: 100,child: Image.asset("assets/logout.png"))),
                  content: Text("Are you sure you want to Log Out"),
                  actions: [
                    TextButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text("Yes",style: TextStyle(color: Colors.red),),
                      onPressed: () async{
                        await LocalStorageStore().userDeleteToken();
                        memberId=null;
                        receiptNumber=null;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LogInScreen()),
                                (route) => false);
                      },
                    ),
                  ],
                );
              },
            );
            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Payment_Method()));
          },
        ),
      ],
    ),
  );
  }
}


  Widget _buildHeader(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.payment,
            color: secondaryColor,
          ),
          title: Text("Payment Method"),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Payment_Method()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.receipt_long_outlined,
            color: secondaryColor,
          ),
          title: Text("Receipt List"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ReceiptListOfAMemberScreen()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.file_open_rounded,
            color: secondaryColor,
          ),
          title: Text("File List"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FileList()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.payments,
            color: secondaryColor,
          ),
          title: Text("Payment Status"),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Details()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.notifications,
            color: secondaryColor,
          ),
          title: Text("Notification"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.info_outline,
            color: secondaryColor,
          ),
          title: Text("Device info"),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DeviceInfo()));
          },
        )
      ],
    ),
  );
