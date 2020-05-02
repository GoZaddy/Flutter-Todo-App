import 'package:get_it/get_it.dart';
import 'package:todo_app/core/viewmodels/all_lists_model.dart';
import 'package:todo_app/core/viewmodels/all_quick_notes_models.dart';
import 'package:todo_app/core/viewmodels/list_bottom_sheet_model.dart';
import 'package:todo_app/core/viewmodels/list_to_do_model.dart';
import 'package:todo_app/core/viewmodels/list_widget_model.dart';
import 'package:todo_app/core/viewmodels/login_model.dart';
import 'package:todo_app/core/viewmodels/quick_note_widget_model.dart';


GetIt locator = GetIt.instance;

void setUpLocator(){
  locator.registerFactory(() => AllQuickNotesModel());
  locator.registerFactory(() => AllListsModel());
  locator.registerFactory(() => ListModel());
  locator.registerFactory(() => ListBottomSheetModel());
  locator.registerFactory(() => QuickNoteModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => ListToDoModel());

}