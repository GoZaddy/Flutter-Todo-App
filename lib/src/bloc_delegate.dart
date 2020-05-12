import 'package:bloc/bloc.dart';
class MyBlocDelegate extends BlocDelegate{

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace){
    super.onError(bloc, error, stackTrace);
    print(error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc,transition);
    print(transition);
  }
  
}