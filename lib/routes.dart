import 'package:get/get_navigation/src/routes/get_route.dart';
import 'view/screens/bills_in/back/add_back_billin_screen.dart';
import 'view/screens/bills_out/back/add_back_billout_screen.dart';
import 'view/screens/bills_out/show_billout_screen.dart';
import 'view/screens/emp/attend/day_view_screen.dart';
import 'view/screens/emp/attend/emp_month_view_screen .dart';
import 'view/screens/emp/attend/attend_screen.dart';
import 'view/screens/emp/attend/today_screen.dart';
import 'view/screens/emp/attend/month_view_screen.dart';
import 'view/screens/emp/employers/edit_emp_screen.dart';
import 'view/screens/emp/employers/add_emp_screen.dart';
import 'view/screens/emp/employers/search_emp_screen.dart';
import 'view/screens/emp/salery/emp_salery.dart';
import 'view/screens/emp/salery/month_salery_screen.dart';
import 'view/screens/items/add/add_bike_item_screen.dart';
import 'view/screens/items/add/add_fix_item_screen.dart';
import 'view/screens/items/add/add_rent_item_screen.dart';
import 'view/screens/items/add/add_stock_item_screen.dart';
import 'view/screens/items/stock_screen.dart';
import 'view/screens/main/loading_screen.dart';
import 'view/screens/reports/month_reports.dart';
import 'view/screens/users/add_user_screen.dart';
import 'view/screens/users/edit_user_screen.dart';
import 'view/screens/users/login_screen.dart';
import 'view/screens/bills_in/normal/add_billin_screen.dart';
import 'view/screens/bills_in/edit_billIn_screen.dart';
import 'view/screens/reports/reports_billin.dart';
import 'view/screens/bills_in/search_billIn_screen.dart';
import 'view/screens/bills_out/normal/add_billout_screen.dart';
import 'view/screens/bills_out/edit_billout_screen.dart';
import 'view/screens/reports/reports_billout.dart';
import 'view/screens/bills_out/search_billout_screen.dart';
import 'view/screens/items/edit_item_screen.dart';
import 'view/screens/items/search_item_screen.dart';
import 'view/screens/main/main_screen.dart';

import 'view/screens/main/splash_screen.dart';
import 'view/screens/supplires/add_sup_screen.dart';
import 'view/screens/supplires/edit_sup_screen.dart';
import 'view/screens/supplires/search_sup_screen.dart';
import 'view/screens/users/search_user_screen.dart';
import 'view/screens/works/add_payment_screen.dart';
import 'view/screens/works/work_items_screen.dart';
import 'view/screens/works/search_work_screen.dart';
import 'view/screens/works/work_details_screen.dart';

List<GetPage<dynamic>>? getRoutes = [
  //************************main Screens************************
  //splash
  GetPage(
    name: '/',
    page: () => const SplashScreen(),
  ),
  //main Screens
  GetPage(
    name: AppRoutes.mainScreen,
    page: () => MainScreen(),
  ),
  GetPage(
    name: AppRoutes.loadingScreen,
    page: () => LoadingScreen(),
  ),
//
//************************auth Screens************************
  GetPage(
    name: AppRoutes.loginScreen,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: AppRoutes.addUserScreen,
    page: () => AddUserScreen(),
  ),
  GetPage(
    name: AppRoutes.searchUserScreen,
    page: () => SearchUserScreen(),
  ),
  GetPage(
    name: AppRoutes.editUserScreen,
    page: () => EditUserScreen(),
  ),

//************************Menu Screens************************
//items
  GetPage(
    name: AppRoutes.addStockItemsScreen,
    page: () => AddStockItemScreen(),
  ),
  GetPage(
    name: AppRoutes.addBikeItemScreen,
    page: () => AddBikeItemScreen(),
  ),

  GetPage(
    name: AppRoutes.addFixItemScreen,
    page: () => AddFixItemScreen(),
  ),
  GetPage(
    name: AppRoutes.addRentItemScreen,
    page: () => AddRentItemScreen(),
  ),
  GetPage(
    name: AppRoutes.editItemScreen,
    page: () => EditItemScreen(),
  ),
  GetPage(
    name: AppRoutes.searchItemScreen,
    page: () => SearchItems(),
  ),
  GetPage(
    name: AppRoutes.stockScreen,
    page: () => StockScreen(),
  ),
//sup
  GetPage(
    name: AppRoutes.addSupScreen,
    page: () => AddSupScreen(),
  ),
  GetPage(
    name: AppRoutes.searchSupScreen,
    page: () => SearchSupScreen(),
  ),
  GetPage(
    name: AppRoutes.editSupScreen,
    page: () => EditSupScreen(),
  ),
//Employers
  GetPage(
    name: AppRoutes.addEmpScreen,
    page: () => AddEmpScreen(),
  ),
  GetPage(
    name: AppRoutes.searchEmpScreen,
    page: () => SearchEmpScreen(),
  ),
  GetPage(
    name: AppRoutes.editEmpScreen,
    page: () => EditEmpScreen(),
  ),
  // Attend
  GetPage(
    name: AppRoutes.attendScreen,
    page: () => AttendScreen(),
  ),
  GetPage(
    name: AppRoutes.toDayScreen,
    page: () => ToDayScreen(),
  ),
  GetPage(
    name: AppRoutes.monthViewScreen,
    page: () => MonthViewScreen(),
  ),
  GetPage(
    name: AppRoutes.dayViewScreen,
    page: () => DayViewScreen(),
  ),
  GetPage(
    name: AppRoutes.empMonthViewScreen,
    page: () => EmpMonthViewScreen(),
  ),
// salery
  GetPage(
    name: AppRoutes.empSaleryScreen,
    page: () => EmpSaleryScreen(),
  ),
  GetPage(
    name: AppRoutes.monthSaleryScreen,
    page: () => MonthSaleryScreen(),
  ),

//workes
  GetPage(
    name: AppRoutes.workItemsScreen,
    page: () => WorkItemsScreen(),
  ),
  GetPage(
    name: AppRoutes.searchWorkScreen,
    page: () => SearchWorkScreen(),
  ),
  GetPage(
    name: AppRoutes.workDetailsScreen,
    page: () => WorkDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.addWorkPaymentScreen,
    page: () => AddPaymentScreen(),
  ),
  // GetPage(
  //   name: AppRoutes.getWorkPaymentScreen,
  //   page: () => WorkPaymentScreen(),
  // ),

  //
//billIn
  GetPage(
    name: AppRoutes.addBillInScreen,
    page: () => AddBillInScreen(),
  ),
  GetPage(
    name: AppRoutes.editBillInScreen,
    page: () => EditBillInScreen(),
  ),
  GetPage(
    name: AppRoutes.searchBillInScreen,
    page: () => SearchBillInScreen(),
  ),

  GetPage(
    name: AppRoutes.addBackBillInScreen,
    page: () => AddBackBillInScreen(),
  ),
  //billOut
  GetPage(
    name: AppRoutes.addBillOutScreen,
    page: () => AddBillOutScreen(),
  ),
  GetPage(
    name: AppRoutes.editBillOutScreen,
    page: () => EditBillOutScreen(),
  ),
  GetPage(
    name: AppRoutes.showBillOutScreen,
    page: () => ShowBillOutScreen(),
  ),
  GetPage(
    name: AppRoutes.searchBillOutScreen,
    page: () => SearchBillOutScreen(),
  ),

  GetPage(
    name: AppRoutes.addBackBillOutScreen,
    page: () => AddBackBillOutScreen(),
  ),
//reports MonthScreen
  GetPage(
    name: AppRoutes.monthReports,
    page: () => MonthScreen(),
  ),
  GetPage(
    name: AppRoutes.reportBillOutScreen,
    page: () => ReportsBillOutScreen(),
  ),
  GetPage(
    name: AppRoutes.reportBillInScreen,
    page: () => ReportsBillInScreen(),
  ),
];

class AppRoutes {
  static const String splashScreen = '/splashScreen';
//************************main Screens************************
  static const String mainScreen = '/mainScreen';
  static const String loadingScreen = '/loadingScreen';
//items
  static const String addStockItemsScreen = '/addStockItemsScreen';
  static const String addBikeItemScreen = '/addBikeItemScreen';
  static const String addFixItemScreen = '/addFixItemScreen';
  static const String addRentItemScreen = '/addRentItemScreen';
  static const String editItemScreen = '/editItemScreen';
  static const String searchItemScreen = '/searchItemScreen';
  static const String stockScreen = '/stockScreen';
//sup
  static const String addSupScreen = '/addSupScreen';
  static const String searchSupScreen = '/searchSupScreen';
  static const String editSupScreen = '/editSupScreen';
//Employers
  static const String addEmpScreen = '/addEmpScreen';
  static const String searchEmpScreen = '/searchEmpScreen';
  static const String editEmpScreen = '/editEmpScreen';
  static const String attendScreen = '/attendScreen';
  static const String toDayScreen = '/toDayScreen';
  static const String monthViewScreen = '/monthViewScreen';
  static const String dayViewScreen = '/dayViewScreen';
  static const String empMonthViewScreen = '/empMonthViewScreen';
  static const String empSaleryScreen = '/empSaleryScreen';
  static const String monthSaleryScreen = '/monthSaleryScreen';

//workes
  static const String workItemsScreen = '/workItemsScreen';
  static const String searchWorkScreen = '/searchWorkScreen';
  static const String workDetailsScreen = '/workDetailsScreen';
  static const String addWorkPaymentScreen = '/addWorkPaymentScreen';
  // static const String getWorkPaymentScreen = '/getWorkPaymentScreen';
//billIn
  static const String addBillInScreen = '/addBillInScreen';
  static const String searchBillInScreen = '/searchBillInScreen';
  static const String editBillInScreen = '/editBillInScreen';
  static const String addBackBillInScreen = '/addBackBillInScreen';
//billout
  static const String addBackBillOutScreen = '/addBackBillOutScreen';
  static const String addBillOutScreen = '/addBillOutScreen';
  static const String searchBillOutScreen = '/searchBillOutScreen';
  static const String editBillOutScreen = '/editBillOutScreen';
  static const String showBillOutScreen = '/showBillOutScreen';
  //reports
  static const String monthReports = '/monthReports';
  static const String reportBillOutScreen = '/reportBillOutScreen';
  static const String reportBillInScreen = '/reportBillInScreen';

//************************auth Screens************************
  static const String loginScreen = '/login';
  static const String addUserScreen = '/addUserScreen';
  static const String searchUserScreen = '/searchUserScreen';
  static const String editUserScreen = '/editUserScreen';
}
