import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/user/user.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/List.dart';
import '../../domain/usecases/dashboard_use_cases.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/dashboard_bloc/dashboard_bloc.dart';
import '../widgets/all_lists.dart';
import '../widgets/all_quick_notes.dart';
import '../widgets/list_bottom_sheet.dart';
import '../widgets/menu_icon.dart';
import '../widgets/small_button.dart';

class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: Dashboard(
            bloc: BlocProvider.of<DashboardBloc>(context),
            scaffoldKey: _scaffoldKey),
        endDrawer: Container(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 20.0),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Drawer(
            elevation: 0.0,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SmallButton(
                        color: Color(0xff878CAC),
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        children: <Widget>[
                          Text(
                            "+ Add a quick note",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 30.0),
                          SmallButton(
                            icon: Transform.rotate(
                              angle: 45.0,
                              child: Icon(
                                Icons.attach_file,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              print(Navigator);
                              //Navigator.pop(context);
                              await Navigator.popAndPushNamed(
                                  context, "/addQuickNote");
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        children: <Widget>[
                          Text(
                            "+ Add a list",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 30.0),
                          SmallButton(
                            icon: Icon(
                              Icons.insert_drive_file,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await Navigator.popAndPushNamed(
                                  context, "/addList");
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        children: <Widget>[
                          Text(
                            "Sign out",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 30.0),
                          SmallButton(
                            color: Color(0xff878CAC),
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(LoggedOut());
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final DashboardBloc bloc;
  Dashboard({
    this.bloc,
    this.scaffoldKey,
  });

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PersistentBottomSheetController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showBottomSheet(ListEntity list) {
    _controller =
        this.widget.scaffoldKey.currentState.showBottomSheet((context) {
      return ListBottomSheet(
        todoList: list,
        closeBottomSheet: () {
          _closeBottomSheet();
        },
      );
    });
  }

  void _closeBottomSheet() {
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
          EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0, bottom: 20.0),
      shrinkWrap: true,
      children: <Widget>[
        AppBar(
          leading: MenuIcon(),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Hello ${sl<User>().displayName.toString().split(" ")[0]}',
              style: TextStyle(
                  fontSize: 32.0,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w200,
                  color: Theme.of(context).accentColor),
            ),
            SmallButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                this.widget.scaffoldKey.currentState.openEndDrawer();
              },
            )
          ],
        ),
        SizedBox(height: 40.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Quick notes",
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: Theme.of(context).accentColor),
            )
          ],
        ),
        SizedBox(height: 20.0),
        AllQuickNotes(
            allQuickNotesStream:
                sl<FetchQuickNotes>().call(uid: sl<User>().uid)),
        SizedBox(height: 70.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Lists",
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: Theme.of(context).accentColor),
            ),
          ],
        ),
        SizedBox(height: 30.0),
        AllLists(
            allListsStream: sl<FetchLists>().call(uid: sl<User>().uid),
            show: this._showBottomSheet)
      ],
    );
  }
}
