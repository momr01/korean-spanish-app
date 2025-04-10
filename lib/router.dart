import 'package:flutter/material.dart';
import 'package:korean_spanish_app/features/404_not_found/screens/not_found_screen.dart';
import 'package:korean_spanish_app/features/home/screens/home_screen.dart';
import 'package:korean_spanish_app/features/practice/screens/practice_screen.dart';
import 'package:korean_spanish_app/features/practice/screens/spanish_hidden_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case PracticeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PracticeScreen());
    case SpanishHiddenScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SpanishHiddenScreen());
    // case BottomBar.routeName:
    //   int page = routeSettings.arguments as int;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => BottomBar(
    //             page: page,
    //           ));
    // case PaymentDetailsScreen.routeName:
    //   String paymentId = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => PaymentDetailsScreen(
    //             paymentId: paymentId,
    //           ));
    // case FormEditPayment.routeName:
    //   FormEditPaymentArguments args =
    //       routeSettings.arguments as FormEditPaymentArguments;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => FormEditPayment(
    //             // payment: payment,
    //             payment: args.payment,
    //             names: args.names,
    //             taskCodes: args.taskCodes,
    //           ));
    // case NamesScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const NamesScreen());
    // case FormManageNameScreen.routeName:
    //   FormManageNameArguments args =
    //       routeSettings.arguments as FormManageNameArguments;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => FormManageNameScreen(
    //             name: args.name,
    //             categories: args.categories,
    //             taskCodes: args.taskCodes,
    //           ));
    // case GenerateMainScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const GenerateMainScreen());
    // case GenerateDetailsIndividualScreen.routeName:
    //   List<dynamic> args = routeSettings.arguments as List<dynamic>;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => GenerateDetailsIndividualScreen(
    //             payments: args[0],
    //             title: args[1],
    //             // type: args[2] ?? null,
    //             type: args.length > 2
    //                 ? args[2]
    //                 : "individual", // Solo pasa `type` si existe.
    //           ));
    // case GenerateDetailsGroupsScreen.routeName:
    //   List<dynamic> args = routeSettings.arguments as List<dynamic>;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => GenerateDetailsGroupsScreen(
    //             payments: args[0],
    //             title: args[1],
    //           ));

    // case GenerateInstallmentsFormScreen.routeName:
    //   List<dynamic> args = routeSettings.arguments as List<dynamic>;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => GenerateInstallmentsFormScreen(
    //             totalSelected: args[0],
    //             payments: args[1],
    //           ));
    // case AlertsScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const AlertsScreen());
    // case HistoricalScreen.routeName:
    //   List<HistoricalFilter> args =
    //       routeSettings.arguments as List<HistoricalFilter>;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => HistoricalScreen(
    //             finalFilter: args,
    //           ));
    // case HistoricalDetailsScreen.routeName:
    //   var payment = routeSettings.arguments as Payment;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => HistoricalDetailsScreen(
    //             payment: payment,
    //           ));
    // case HistoricalFilterScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => const HistoricalFilterScreen());
    // case TasksScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const TasksScreen());
    // case CategoriesScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const CategoriesScreen());
    // case GroupsScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const GroupsScreen());
    // case GroupDetailsScreen.routeName:
    //   var group = routeSettings.arguments as Group;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => GroupDetailsScreen(
    //             group: group,
    //           ));
    // case ManageGroupScreen.routeName:
    //   // var group = routeSettings.arguments as Group;
    //   List<dynamic> args = routeSettings.arguments as List<dynamic>;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => ManageGroupScreen(
    //             // group: group,
    //             group: args[0],
    //             namesList: args[1],
    //           ));
    // case ProfileScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const ProfileScreen());
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NotFoundScreen(),
      );
  }
}
