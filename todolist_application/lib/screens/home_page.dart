import 'package:flutter/material.dart';
import 'package:namer_app/models/custom_fab.dart';
import 'package:namer_app/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/theme/app_colors.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/widgets/margin_wrapper.dart';
import 'package:namer_app/widgets/task_selection.dart';
import 'package:namer_app/modals/new_task.dart';
import 'package:namer_app/screens/all_page.dart';
import 'package:namer_app/screens/overdue_page.dart';
import 'package:namer_app/screens/scheduled_page.dart';
import 'package:namer_app/screens/today_page.dart';


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    Widget page;
    var appState = context.watch<MyAppState>();
    var appStateProvider = context.watch<TaskProvider>();
    switch(appState.selectedIndex) {
      case 0:
        page = AllPage();
        break;
      case 1:
        page = ScheduledPage();
        break;
      case 2:
        page = TodayPage();
        break;
      case 3:
        page = OverduePage();
        break;
      default:
        throw UnimplementedError('no widget for $appState.selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.generalBackground,
              toolbarHeight: 100,
              title: Container(
                margin: EdgeInsets.symmetric(horizontal:16),
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(
                    'Hello User,', //Metter le nom en ${}
                    style: TextStyle(fontSize: 36,color: AppColors.text),
                    ),
                  appStateProvider.tasks.isNotEmpty
                    ? Text('Some Task today',
                      style: TextStyle(fontSize: 16,color: AppColors.text))
                    : Text('No task today',
                     style: TextStyle(fontSize: 16,color: AppColors.text)),
                  ],
                ),  
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal:40),
                  child: Row(
                    children: [
                      IconButton(
                      icon:const Icon(Icons.notifications,color: AppColors.text),
                       onPressed: () {},
                      ),
                      SizedBox(width:10),
                      IconButton(
                      icon:const Icon(Icons.settings,color: AppColors.text),
                       onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Container(
              color: AppColors.generalBackground,
              child: MarginWrapper(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: GridView.count(
                          primary:true,
                          padding: const EdgeInsets.all(5),
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          children: <Widget>[
                            TaskSelectionCard(
                              title: 'Today',
                              count: '5',
                              icon: Icons.schedule,
                              onPressed : () {
                                setState(() {
                                appState.selectedIndex = 2;
                                });
                              },
                              color: AppColors.pink
                            ),
                            TaskSelectionCard(
                              title: 'Scheduled',
                              count: '3',
                              icon: Icons.timer,
                              onPressed : () {
                                setState(() {
                                appState.selectedIndex = 1;
                                });
                              },
                              color: AppColors.rose,
                            ),
                            TaskSelectionCard(
                              title: 'All',
                              count: '12',
                              icon: Icons.all_inclusive,
                              onPressed : () {
                                setState(() {
                                appState.selectedIndex = 0;
                                });
                              },
                              color: AppColors.periwinkle,
                            ),
                            TaskSelectionCard(
                              title: 'Overdue',
                              count: '4',
                              icon: Icons.update,
                              onPressed : () {
                                setState(() {
                                appState.selectedIndex = 3;
                                });
                              },
                              color: AppColors.lemon,
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: page),
                      
                    ],
                  ),
                ),
            ),
            floatingActionButton: SizedBox(
              width: 200,
              height: 56,
              child: ElevatedButton(
                onPressed: () => dialogBuilder(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colombia,
                  shape: CircleBorder(),
                ),
                  child: Icon(Icons.add, size: 38,color: AppColors.text),
              ),
            ),
            floatingActionButtonLocation: CustomFabLocation(), // ← ICI
          ); 
        }
      );
    }
}