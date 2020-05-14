
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todo_manager_features/data/datasources/auth_service.dart';
import 'package:todo_app/src/features/todo_manager_features/presentation/bloc/add_quick_note_bloc/add_quick_note_bloc.dart' as addNoteBloc;
import 'package:todo_app/src/features/todo_manager_features/presentation/bloc/add_list_bloc/add_list_bloc.dart' as addListBloc;

import './src/injection_container.dart' as di;
import 'src/bloc_delegate.dart';
import 'src/core/user/user.dart';
import 'src/features/todo_manager_features/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'src/features/todo_manager_features/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'src/features/todo_manager_features/presentation/bloc/login_bloc/login_bloc.dart';

import 'src/features/todo_manager_features/presentation/pages/Dashboard.dart';
import 'src/features/todo_manager_features/presentation/pages/Login.dart';
import 'src/features/todo_manager_features/presentation/pages/add_new_list.dart';
import 'src/features/todo_manager_features/presentation/pages/add_quick_note.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocSupervisor.delegate = MyBlocDelegate();
  await di.sl.allReady();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> { 
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = di.sl<AuthBloc>();
    _authBloc.add(AppStarted());
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    
    return BlocProvider.value(
      value: _authBloc,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo App',
            theme: ThemeData(
              primaryColor: Color(0xff657AFF),
              accentColor: Color(0xff4F5578),
              primarySwatch: Colors.blue,
            ),
            home: BlocBuilder(
              bloc: _authBloc,
              builder: (BuildContext context, AuthState authState){
                if(authState is Uninitialised){
                  return BlocProvider<LoginBloc>(
                    create: (context){return di.sl<LoginBloc>();},
                    child: LoginPage()
                  ); 
                }

                else if(authState is AuthAuthenticated){
                  return FutureBuilder(
                    future: di.sl.allReady(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return BlocProvider<DashboardBloc>(
                        create: (context){
                          return di.sl<DashboardBloc>();
                        },
                        child: DashboardScreen(),
                      );
                      }
                      else{
                        return Scaffold(
                          body: Center(
                            child: Container(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }
                      
                    }
                  ); 
                }
                else{
                  return BlocProvider<LoginBloc>(
                    create: (context){return di.sl<LoginBloc>();},
                    child: LoginPage()
                  ); 
                }
              }
            ),
            routes: {
              "/dashboard": (context) =>BlocProvider<DashboardBloc>(
                    create: (context){
                      return di.sl<DashboardBloc>();
                    },
                    child: DashboardScreen(),
                  ),
              "/addQuickNote": (context) => BlocProvider<addNoteBloc.AddQuickNoteBloc>(
                create: (context){return di.sl<addNoteBloc.AddQuickNoteBloc>();},
                child: AddQuickNote()
              ),
              "/addList": (context) => BlocProvider<addListBloc.AddListBloc>(
                create: (context){return di.sl<addListBloc.AddListBloc>();},
                child: AddList()
              ),
              
            },
          ),
        
    );
  }
}

