import 'package:get_it/get_it.dart';

import './features/todo_manager_features/domain/usecases/add_list.dart' as addListUseCase;
import './features/todo_manager_features/domain/usecases/add_quick_note.dart' as addQuickNoteUseCase;
import './features/todo_manager_features/domain/usecases/dashboard_use_cases.dart' as dashboardUseCase;
import './features/todo_manager_features/domain/usecases/edit_quick_note.dart' as editNoteUseCase;
import './features/todo_manager_features/domain/usecases/edit_list.dart' as editListUseCase;
import './features/todo_manager_features/domain/usecases/edit_list_todo.dart' as editListTodoUseCase;
import 'core/user/user.dart';
import 'features/todo_manager_features/data/datasources/auth_service.dart';
import 'features/todo_manager_features/data/datasources/firestore_interactions.dart';
import 'features/todo_manager_features/data/repositories/auth_repository_impl.dart';
import 'features/todo_manager_features/data/repositories/todo_manager_repository_impl.dart';
import 'features/todo_manager_features/domain/repositories/auth_repository.dart';
import 'features/todo_manager_features/domain/repositories/todo_manager_repository.dart';
import 'features/todo_manager_features/presentation/bloc/add_list_bloc/add_list_bloc.dart';
import 'features/todo_manager_features/presentation/bloc/add_quick_note_bloc/add_quick_note_bloc.dart';
import 'features/todo_manager_features/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'features/todo_manager_features/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'features/todo_manager_features/presentation/bloc/login_bloc/login_bloc.dart';

final sl = GetIt.instance;


Future<void> init() async{
  //bloc
  sl.registerFactory(
    () => AuthBloc(authRepository: sl())
  );
  sl.registerFactory(
    () => LoginBloc(authRepository: sl())
  );
  sl.registerFactory(
    () => DashboardBloc()
  );
  sl.registerFactory(
    () => AddQuickNoteBloc(user: sl(), addQuickNote: sl())
  );
  sl.registerFactory(
    () => AddListBloc(addList: sl(), user: sl())
  );

  //usecases
  sl.registerLazySingleton(() => dashboardUseCase.FetchListTodos(sl()));
  sl.registerLazySingleton(() => dashboardUseCase.FetchQuickNotes(sl()));
  sl.registerLazySingleton(() => dashboardUseCase.FetchLists(sl()));

  sl.registerLazySingleton(() => addListUseCase.AddList(sl()));
  sl.registerLazySingleton(() => addQuickNoteUseCase.AddQuickNote(sl()));

  sl.registerLazySingleton(() => editNoteUseCase.DeleteQuickNote(sl()));
  sl.registerLazySingleton(() => editNoteUseCase.EditQuickNoteTitle(sl()));
  sl.registerLazySingleton(() => editNoteUseCase.SetQuickNoteIsDone(sl()));

  sl.registerLazySingleton(() => editListUseCase.AddListTodo(sl()));
  sl.registerLazySingleton(() => editListUseCase.DeleteList(sl()));
  sl.registerLazySingleton(() => editListUseCase.EditBackgroundColor(sl()));
  sl.registerLazySingleton(() => editListUseCase.EditListTitle(sl()));

  sl.registerLazySingleton(() => editListTodoUseCase.SetListTodoIsDone(sl()));
    


  

  // repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl())
  );
  sl.registerLazySingleton<TodoManagerRepository>(
    () => TodoManagerRepositoryImpl(sl())
  );

  // data sources
  sl.registerLazySingleton(() => FirestoreInteractions());
  sl.registerLazySingleton(() => AuthService());

  //core
  
    sl.registerSingletonAsync<User>( () async => await sl<AuthService>().getCurrentUser());
  
  
  

  //external
}

