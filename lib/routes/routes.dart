import 'package:get/get.dart';
import 'package:invoice_generator/view/auth/register/register.dart';
import 'package:invoice_generator/view/intro/intro_1.dart';
import 'package:invoice_generator/view/intro/intro_2.dart';
import 'package:invoice_generator/view/intro/intro_3.dart';
import 'package:invoice_generator/view/screen/Quatation/quatation.dart';
import 'package:invoice_generator/view/screen/bottom/Company_detail/company.dart';
import 'package:invoice_generator/view/screen/bottom/bills.dart';
import 'package:invoice_generator/view/screen/bottom/more.dart';
import 'package:invoice_generator/view/screen/bottom/notes/terms/notes_terms.dart';
import 'package:invoice_generator/view/screen/bottom/parties.dart';
import 'package:invoice_generator/view/screen/bottom/product.dart';

import 'package:invoice_generator/view/screen/bottom/user_profile/user_profile.dart';
import 'package:invoice_generator/view/screen/home.dart';
import '../view/auth/login/login.dart';
import '../view/screen/bottom/signature/signature.dart';
import '../view/screen/invoice/customers/add_customer.dart';
import '../view/screen/invoice/customers/customer_form.dart';
import '../view/screen/invoice/invoice.dart';
import '../view/screen/invoice/product/product.dart';
import '../view/screen/invoice/product/product_add.dart';
import '../view/screen/slplash.dart';

class Routes {
  static const String splashScreen = "/";
  static const String register = "/register";
  static const String intro_1 = "/intro_1";
  static const String intro_2 = "/intro_2";
  static const String intro_3 = "/intro_3";
  static const String login = "/login";
  static const String home = "/home";
  static const String invoice = "/invoice";
  static const String Add_customers = "/Add_customers";
  static const String form_customers = "/form_customert";
  static const String product = "/product";
  static const String product_add = "/product_add";
  static const String bills = "/bills";
  static const String products = "/products";
  static const String parties = "/parties";
  static const String more = "/more";
  static const String quatation = "/quatation";
  static const String company_detail = "/company_detail";
  static const String user_profile = "/user_profile";
  static const String signature = "/signature";
  static const String notes_terms = "/notes_terms";

  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: intro_1, page: () => Intro1(), transition: Transition.fadeIn),
    GetPage(name: intro_2, page: () => Intro2(), transition: Transition.fadeIn),
    GetPage(name: intro_3, page: () => Intro3(), transition: Transition.fadeIn),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: invoice,
      page: () => Invoice(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Add_customers,
      page: () => AddCustomer(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: form_customers,
      page: () => AllCustomers(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: product,
      page: () => Product(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: product_add,
      page: () => ProductAdd.product(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: bills, page: () => Bills(), transition: Transition.fadeIn),
    GetPage(
      name: products,
      page: () => Products(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: parties,
      page: () => Parties(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: more, page: () => More(), transition: Transition.fadeIn),
    GetPage(
      name: quatation,
      page: () => Quatation(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: company_detail,
      page: () => CompanyDetail(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: user_profile,
      page: () => UserProfile(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signature,
      page: () => SignatureScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: notes_terms,
      page: () => NotesTerms(),
      transition: Transition.fadeIn,
    ),
  ];
}
