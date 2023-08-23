import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        AppStrings.arabicCode: {
          AppStrings.choseLanguage: 'اختر اللغة',
          AppStrings.arabic: 'العربية',
          AppStrings.english: 'الانجليزية',
          AppStrings.continueWord: 'استمر',
          AppStrings.choseProduct: 'اختر المنتج',
          AppStrings.easySafePayment: 'دفع سهل وآمن',
          AppStrings.fastDelivery: 'توصيل سريع',
          AppStrings.trackYourOrder: 'أتبع طلبك',
          AppStrings.logIn: 'تسجيل الدخول',
          AppStrings.signUp: 'انشاء حساب',
          AppStrings.resetPass: 'اعادى تعيين كلمة السر',
          AppStrings.checkEmail: 'تفقد البريد الإلكتروني',
          AppStrings.checkCode: 'التحقق من الكود',
          AppStrings.welcomeBack: 'أهلا بعودتك',
          AppStrings.welcome: 'اهلا بك',
          AppStrings.enterYourName: 'اكتب اسمك',
          AppStrings.enterYourPhone: 'اكتب رقم الهاتف',
          AppStrings.enterYourEmail: 'اكتب بريدك الإلكتروني',
          AppStrings.enterYourPass: 'اكتب رقمك السري',
          AppStrings.name: 'الاسم',
          AppStrings.phone: 'الهاتف',
          AppStrings.email: 'بريدك الإلكتروني',
          AppStrings.password: 'الرقم السري',
          AppStrings.rememberMe: 'تذكرنى',
          AppStrings.forgetPass: 'نسيت كلمة المرور',
          AppStrings.donHaveAccount: 'ليس لديك حساب',
          AppStrings.allHaveAccount: 'بالفعل لديك حساب',
          //Successfully page
          AppStrings.doneSuccessfully: 'تم بنجاح',
          AppStrings.backToLogin: 'العودة إلى تسجيل الدخول',
          //validation
          AppStrings.notValidUserName: 'اسم مستخدم غير صالح',
          AppStrings.notValidEmail: 'بريد إلكتروني غير صالح',
          AppStrings.notValidPhone: 'هاتف غير صالح',
          AppStrings.cantBeEmpty: 'لا يمكن أن يكون فارغ',
          AppStrings.cantBeMore: 'لا يمكن أن يكون أكثر من',
          AppStrings.cantBeLess: 'لا يمكن أن يكون أقل من',
          //long
          AppStrings.pleaseEnterEmailToVerifyCode:
              'الرجاء إدخال عنوان بريدك الإلكتروني للتحقق من الرمز',
          AppStrings.pleaseEnterCodeToVerify:
              'الرجاء إدخال الرمز الرقمي المرسل إلى ',
          AppStrings.filInformation: 'املأ المعلومات لإنشاء حساب جديد',
          AppStrings.onBoardingOne:
              'لدينا اكتر من ١٠٠ الف منتج اختر منتجك من متجرنا التجاري',
          AppStrings.signInWithEmailAndPass:
              'سجل الدخول بالبريد الالكتروني \n او باستخدام منصات التواصل الاجتماعي',
        },
        AppStrings.englishCode: {
          AppStrings.choseLanguage: 'Chose Language',
          AppStrings.arabic: 'Arabic',
          AppStrings.english: 'English',
          AppStrings.continueWord: 'Continue',
          AppStrings.choseProduct: 'Choose Product',
          AppStrings.easySafePayment: 'Easy & Safe payment',
          AppStrings.fastDelivery: 'Fast Delivery',
          AppStrings.trackYourOrder: 'Track your order',
          AppStrings.logIn: 'Login',
          AppStrings.signUp: 'Sign Up',
          AppStrings.resetPass: 'Reset password',
          AppStrings.checkEmail: 'Check Email',
          AppStrings.checkCode: 'Check Code',
          AppStrings.welcomeBack: 'Welcome Back',
          AppStrings.welcome: 'Welcome',
          AppStrings.forgetPass: 'Forget Password',
          AppStrings.enterYourName: 'Enter Your Name',
          AppStrings.enterYourPhone: 'Enter Your Phone',
          AppStrings.enterYourEmail: 'Enter Your Email',
          AppStrings.enterYourPass: 'Enter Your Password',
          AppStrings.name: 'Name',
          AppStrings.phone: 'Phone',
          AppStrings.email: 'Email',
          AppStrings.password: 'Password',
          AppStrings.rememberMe: 'Remember Me',
          AppStrings.donHaveAccount: 'don\'t have an account',
          AppStrings.allHaveAccount: 'do you have an account',
          //Successfully page
          AppStrings.doneSuccessfully: 'done successfully',
          AppStrings.backToLogin: 'Back to login', //العودة إلى تسجيل الدخول
          //validation
          AppStrings.notValidUserName: 'not valid user name',
          AppStrings.notValidEmail: 'not valid email',
          AppStrings.notValidPhone: 'not valid phone',
          AppStrings.cantBeEmpty: 'Can\'t be empty',
          AppStrings.cantBeMore: 'Can\'t be more than',
          AppStrings.cantBeLess: 'Can\'t be less than',
          //long
          AppStrings.onBoardingOne:
              'We have 100k+ products \n choose your product from our \n commerce shop',
          AppStrings.pleaseEnterEmailToVerifyCode:
              'Please Enter your email address to verify code',
          AppStrings.pleaseEnterCodeToVerify:
              'Please enter the digital code sent to ',
          AppStrings.signInWithEmailAndPass:
              'Sign in with email And password \n or with social media',
          AppStrings.filInformation:
              'Fill the the information to create a new account',
        },
      };
}

class AppStrings {
  //url google maps
  static const String apiGoogleMaps =
      'https://www.google.com/maps/search/?api=1&query=';
  //
  //***************************Api***************************
  static const String serverUsers =
      "https://starboard-knee.000webhostapp.com/resturant/users";
  static const String localHost = 'http://10.0.2.2/magdy';
  //***************************users***************************
  //pass
  static const String apiChangePassword = '$serverUsers/pass/change_pass.php';
  static const String apiResetCode = '$serverUsers/pass/reset_code.php';
  static const String apiSendResetCode =
      '$serverUsers/pass/send_reset_code.php';
  //sign
  static const String apiAvtiveCode = '$serverUsers/sign/avtive_code.php';
  static const String apiSignUp = '$serverUsers/sign/signup.php';
  //login
  static const String apiLogin = '$serverUsers/login.php';

//***************************main cat***************************
  static const String serverCat =
      'https://starboard-knee.000webhostapp.com/fym/cat_main';
  static const String apiViewCat = '$serverCat/control/view_all.php';
  static const String apiViewCatImage = '$serverCat/CAT_MAIN_IMAGES';

//***************************sub cat***************************
  static const String serverSubCat =
      'https://starboard-knee.000webhostapp.com/fym/cat_sub';

  static const String apiViewSubCat = '$serverSubCat/control/view_by.php';
  static const String apiViewSubCatImage = '$serverSubCat/CAT_SUB_IMAGES';
//***************************places***************************
  static const String serverPlace =
      'https://starboard-knee.000webhostapp.com/fym/places';

  static const String apiViewPlaces = '$serverPlace/control/view_by.php';
  static const String apiViewPlacesByMain =
      '$serverPlace/control/view_by_main.php';

  static const String apiViewImportantPlaces =
      '$serverPlace/control/view_important.php';

  static const String apiViewPlaceComments =
      'https://starboard-knee.000webhostapp.com/fym/comments/control/view_place_comments.php';

  static const String apiViewPlaceLogoImage = '$serverPlace/images';
  static const String apiGetPlaceImagesName =
      '$serverPlace/control_images/view_by.php';
  static const String apiGetPlaceMenuImagesName =
      //https://starboard-knee.000webhostapp.com/fym/places
      '$serverPlace/control_images/view_menu.php';
  static const String apiViewPlaceImages = '$serverPlace/list_images';

  //https://starboard-knee.000webhostapp.com/fym/places
//***************************keys fo shared pref***************************
//
//***************************users
  //logedin or confirmed code
  static const String keyUserId = 'keyUserId';
  static const String keyUserName = 'keyUserUsers';
  static const String keyUserPhone = 'keyUserPhone';
  static const String keyUserEmail = 'keyUserEmail';
  static const String keyUserPassword = 'keyUserPassword';
  //sigup
  static const String keyEmailPasswordReset = 'keyEmailPasswordReset';
  static const String keyEmailValidate = 'keySignUpEmail';
  //
//***************************Meals
  static const String keyMealsTitle = 'keyMealsTitle';
  static const String keyMealsContent = 'keyMealsContent';
  static const String keyNotFirst = 'keyNotFirst';
//
//***************************validation
  static const String validateUserName = 'name';
  static const String validateEmail = 'email';
  static const String validatePhone = 'phone';
  static const String validatePassword = 'password';
  static const String validateAdmin = 'admin';
  static const String validateAdminNum = 'adminNum';

  //Code
  static const String arabicCode = 'ar';
  static const String englishCode = 'en';

  //public
  static const String tapsImage = 'صور';
  static const String tapsMenu = 'المنيو';
  static const String tapsComments = 'التقييم';
  static const String tapsDetails = 'البيانات';
  static const String placeDetailsLocation = 'المكان على الخريطة';
  //main screen
  static const String mainTapHome = 'الرئيسية';
  static const String mainTapShop = 'السوق';
  static const String mainTapNews = 'الاخبار';
  static const String mainTapSetting = 'الاعدادات';

  static const String choseLanguage = 'Chose Language';
  static const String arabic = 'arabic';
  static const String english = 'english';
  static const String continueWord = 'Continue';
  static const String choseProduct = 'Choose Product';
  static const String easySafePayment = 'Easy & Safe payment';
  static const String fastDelivery = 'Fast Delivery';
  static const String trackYourOrder = 'Track your order';
  static const String logIn = 'Login';
  static const String signUp = 'Sign Up';
  static const String resetPass = 'Reset Password';
  static const String checkEmail = 'Check Email';
  static const String checkCode = 'Check Code';
  static const String welcomeBack = 'Welcome Back';
  static const String welcome = 'Welcome';
  static const String forgetPass = 'Forget Password';
  static const String name = 'Name';
  static const String phone = 'Phone';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String enterYourName = 'Enter Your Name';
  static const String enterYourPhone = 'Enter Your Phone';
  static const String enterYourEmail = 'Enter Your Email';
  static const String enterYourPass = 'Enter Your Password';
  static const String rememberMe = 'Remember Me';
  static const String donHaveAccount = 'don\'t have an account';
  static const String allHaveAccount = 'do you have an account';
  static const String doneSuccessfully = 'done successfully';
  static const String backToLogin = 'Back to login'; //العودة إلى تسجيل الدخول

  //validation
  static const String notValidUserName = 'not valid user name';
  static const String notValidEmail = 'not valid email';
  static const String notValidPhone = 'not valid phone';
  static const String cantBeEmpty = 'Can\'t be empty';
  static const String cantBeMore = 'Can\'t be more than';
  static const String cantBeLess = 'Can\'t be less than';

  static const String onBoardingOne =
      'We have 100k+ products \n choose your product from our \n commerce shop';
  static const String pleaseEnterEmailToVerifyCode =
      'Please Enter your email address to verify code';
  static const String pleaseEnterCodeToVerify =
      'Please enter the digital code sent to ';
  static const String signInWithEmailAndPass =
      'Sign in with email And password or with social media';
  static const String filInformation =
      'Fill the the information to create a new account';
}
