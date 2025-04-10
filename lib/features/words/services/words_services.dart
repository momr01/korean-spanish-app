import 'dart:convert';

import 'package:korean_spanish_app/constants/error_handling.dart';
import 'package:korean_spanish_app/constants/global_variables.dart';
import 'package:korean_spanish_app/constants/navigator_keys.dart';
import 'package:korean_spanish_app/constants/utils.dart';
import 'package:korean_spanish_app/models/word/word.dart';
import 'package:http/http.dart' as http;

class WordsServices {
  Future<List<Word>> fetchWords() async {
    // final userProvider = Provider.of<UserProvider>(
    //     NavigatorKeys.navKey.currentContext!,
    //     listen: false);
    List<Word> wordsList = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/words/getAll'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        //'x-auth-token': userProvider.user.token
      });

      httpErrorHandle(
          response: res,
          context: NavigatorKeys.navKey.currentContext!,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              wordsList.add(Word.fromJson(jsonDecode(res.body)[i]));
              //debugPrint(jsonDecode(res.body)[i]);
            }
          });
    } catch (e) {
      showSnackBar(NavigatorKeys.navKey.currentContext!, e.toString());
    }
    return wordsList;
  }

  // Future<void> addCategory({
  //   required String nameCategory,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(
  //       NavigatorKeys.navKey.currentContext!,
  //       listen: false);

  //   Map body = {'name': nameCategory};

  //   try {
  //     http.Response res = await http.post(Uri.parse('$uri/api/categories/add'),
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': userProvider.user.token
  //         },
  //         body: jsonEncode(body));

  //     httpErrorHandle(
  //         response: res,
  //         context: NavigatorKeys.navKey.currentContext!,
  //         onSuccess: () {
  //           successModal(
  //               context: NavigatorKeys.navKey.currentContext!,
  //               description: 'La categoría se creó correctamente.',
  //               // onPressed: () => Navigator.pushNamedAndRemoveUntil(
  //               //     context, BottomBar.routeName, arguments: 1, (route) => true),
  //               // onPressed: () => Navigator.popUntil(
  //               //     NavigatorKeys.navKey.currentContext!,
  //               //     ModalRoute.withName(
  //               //       CategoriesScreen.routeName,
  //               //     )));
  //               onPressed: () => fromSuccessToCategoryScreen(
  //                   NavigatorKeys.navKey.currentContext!));
  //         });
  //   } catch (e) {
  //     showSnackBar(NavigatorKeys.navKey.currentContext!, e.toString());
  //   }
  // }

  // Future<void> editCategory(
  //     {required String categoryName, required String categoryId}) async {
  //   final userProvider = Provider.of<UserProvider>(
  //       NavigatorKeys.navKey.currentContext!,
  //       listen: false);

  //   Map body = {
  //     'name': categoryName,
  //   };

  //   try {
  //     http.Response res = await http.put(
  //         Uri.parse(
  //             '$uri/api/categories/editCategory/$categoryId?user=${userProvider.user.id}'),
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': userProvider.user.token
  //         },
  //         body: jsonEncode(body));

  //     httpErrorHandle(
  //         response: res,
  //         context: NavigatorKeys.navKey.currentContext!,
  //         onSuccess: () {
  //           successModal(
  //               context: NavigatorKeys.navKey.currentContext!,
  //               description: 'La categoría se modificó correctamente.',
  //               // onPressed: () => fromSuccessUpdateToPaymentDetails(
  //               //     NavigatorKeys.navKey.currentContext!, payment.id)
  //               // onPressed: () => Navigator.popUntil(
  //               //     NavigatorKeys.navKey.currentContext!,
  //               //     ModalRoute.withName(
  //               //       CategoriesScreen.routeName,
  //               //     ))
  //               onPressed: () => fromSuccessToCategoryScreen(
  //                   NavigatorKeys.navKey.currentContext!));
  //         });
  //   } catch (e) {
  //     showSnackBar(NavigatorKeys.navKey.currentContext!, e.toString());
  //   }
  // }

  // Future<void> disableCategory(
  //     {
  //     //required BuildContext context,
  //     required String categoryId}) async {
  //   final userProvider = Provider.of<UserProvider>(
  //       NavigatorKeys.navKey.currentContext!,
  //       listen: false);

  //   try {
  //     http.Response res = await http.put(
  //         Uri.parse('$uri/api/categories/disableCategory/$categoryId'),
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': userProvider.user.token
  //         });

  //     httpErrorHandle(
  //         response: res,
  //         //context: context,
  //         context: NavigatorKeys.navKey.currentContext!,
  //         onSuccess: () {
  //           successModal(
  //               // context: context,
  //               context: NavigatorKeys.navKey.currentContext!,
  //               description: 'La categoría se eliminó correctamente.',
  //               onPressed: () => Navigator.popUntil(
  //                   NavigatorKeys.navKey.currentContext!,
  //                   ModalRoute.withName(
  //                     CategoriesScreen.routeName,
  //                   )));
  //         });
  //   } catch (e) {
  //     // showSnackBar(context, e.toString());
  //     showSnackBar(NavigatorKeys.navKey.currentContext!, e.toString());
  //   }
  // }
}
