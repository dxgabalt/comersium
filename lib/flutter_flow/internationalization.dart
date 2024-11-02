import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es', 'de', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
    String? deText = '',
    String? arText = '',
  }) =>
      [enText, esText, deText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // loginPage
  {
    'o07j3mgv': {
      'en': 'Bienvenido',
      'ar': 'البدء',
      'de': 'Loslegen',
      'es': 'Empezar',
    },
    'fzxvw3mu': {
      'en': 'Inicie sesión con sus credenciales ',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea tu cuenta a continuación.',
    },
    'a9j78va9': {
      'en': 'Ingresa tu correo',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'i7f18cve': {
      'en': '',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'wztjmbn8': {
      'en': 'Ingresa tu contraseña',
      'ar': 'كلمة المرور',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'lw1jpm1f': {
      'en': '',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    'm2xyjvuf': {
      'en': 'Cambiar Contraseña',
      'ar': 'هل نسيت كلمة السر؟',
      'de': 'Passwort vergessen?',
      'es': 'Cambiar Contraseña',
    },
    'qbmoi1av': {
      'en': 'Ingresar',
      'ar': 'تسجيل الدخول',
      'de': 'Anmeldung',
      'es': 'Ingresar',
    },
    'cjqb8ial': {
      'en': 'No tienes una cuenta?',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': '¿No tienes una cuenta?',
    },
    'a0iimirx': {
      'en': 'Registrate',
      'ar': 'ليس لديك حساب؟',
      'de': 'Sie haben kein Konto?',
      'es': 'Registrate',
    },
    '1zqiw31h': {
      'en': 'Registrar Negocio',
      'ar': 'تواصل كضيف',
      'de': 'Als Gast fortfahren',
      'es': 'Continua como invitado',
    },
    'tggm6god': {
      'en': 'Sign up with Google',
      'ar': '',
      'de': '',
      'es': 'Accede con Google',
    },
    'cpoot9qw': {
      'en': 'Sign up with Facebook',
      'ar': '',
      'de': '',
      'es': 'Accede con Facebook',
    },
    '2bb3vct7': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // registerAccount
  {
    'gpokmd81': {
      'en': 'Registrate',
      'ar': 'البدء',
      'de': 'Loslegen',
      'es': 'Registrate',
    },
    'oitrrwgg': {
      'en': 'Crea una cuenta con nosotros',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'de': 'Erstellen Sie unten Ihr Konto.',
      'es': 'Crea una cuenta con nosotros',
    },
    'gcwdqm4g': {
      'en': 'Correo',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Correo',
    },
    'iam0xgwx': {
      'en': 'Numero Celular',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Numero Celular',
    },
    'wl0pw4dt': {
      'en': 'Nombre de usuario',
      'ar': '',
      'de': '',
      'es': 'Nombre de usuario',
    },
    'bs29gxsq': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'sshrtx25': {
      'en': 'Numero Celular',
      'ar': '',
      'de': '',
      'es': 'Numero Celular',
    },
    'n3r0dppv': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bqv15dcf': {
      'en': 'Contraseña',
      'ar': 'كلمة المرور',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'joih97mn': {
      'en': '',
      'ar': 'ادخل رقمك السري...',
      'de': 'Geben Sie Ihr Passwort ein...',
      'es': 'Ingresa tu contraseña...',
    },
    '248uvhth': {
      'en': 'Confirmar contraseña',
      'ar': '',
      'de': '',
      'es': 'Confirmar contraseña',
    },
    'hjpjmdgi': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'me4pa73d': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'o7zch4b5': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'yd21naau': {
      'en': 'Nombre de usuario requerido',
      'ar': '',
      'de': '',
      'es': '',
    },
    'vnekarmi': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'm75hrklr': {
      'en': 'Numero personal requerido',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rv9qxsi0': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jgvumc5l': {
      'en': 'Contraseña requerida',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4mczu68w': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ceccebtg': {
      'en': 'Repita la contraseña',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1pb5z7cy': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    '5kmjfwsk': {
      'en': 'Registrate',
      'ar': 'إنشاء حساب',
      'de': 'Benutzerkonto erstellen',
      'es': 'Crear una cuenta',
    },
    '9ssznj0g': {
      'en': '¿Tienes una cuenta?',
      'ar': 'هل لديك حساب؟',
      'de': 'Sie haben bereits ein Konto?',
      'es': '¿Ya tienes una cuenta?',
    },
    '3ugmx2zp': {
      'en': 'Registrate con google',
      'ar': 'تواصل كضيف',
      'de': 'Als Gast fortfahren',
      'es': 'Continua como invitado',
    },
    '6cwwsnee': {
      'en': 'Continue as Guest',
      'ar': '',
      'de': '',
      'es': '',
    },
    'momge5oj': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // completeProfile
  {
    'yhcaf7r2': {
      'en': 'Completar Perfil',
      'ar': 'الملف الشخصي الكامل',
      'de': 'Vollständiges Profil',
      'es': 'Perfil completo',
    },
    'r6npjsue': {
      'en': 'Subir foto',
      'ar': 'قم بتحميل صورة لنا للتعرف عليك بسهولة.',
      'de':
          'Laden Sie ein Foto hoch, damit wir Sie leicht identifizieren können.',
      'es': 'Sube una foto para que te identifiquemos fácilmente.',
    },
    'sdptn7dd': {
      'en': 'Nombre',
      'ar': 'اسمك',
      'de': 'Dein Name',
      'es': 'Tu nombre',
    },
    'n636qnrx': {
      'en': 'Numero de telefono',
      'ar': 'عمرك',
      'de': 'Dein Alter',
      'es': 'Numero de telefono',
    },
    's7yvjzbs': {
      'en': 'i.e. 34',
      'ar': 'أي 34',
      'de': 'dh 34',
      'es': 'es decir, 34',
    },
    '72ii0waq': {
      'en': 'Descripción',
      'ar': 'لقبك',
      'de': 'Dein Titel',
      'es': 'Tu título',
    },
    'pf8glhkg': {
      'en': 'Ingresa una breve descripción',
      'ar': 'ماهوموقعك؟',
      'de': 'Wo befinden Sie sich?',
      'es': '¿Cual es tu posicion?',
    },
    'hbhd3bdt': {
      'en': 'Actualizar perfil',
      'ar': 'الملف الشخصي الكامل',
      'de': 'Vollständiges Profil',
      'es': 'Actualizar perfil',
    },
    'w75dikic': {
      'en': 'Saltar Paso',
      'ar': 'تخطي في الوقت الراهن',
      'de': 'Für jetzt überspringen',
      'es': 'Saltar por ahora',
    },
    '1eac148w': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ew7dbn3s': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jhhlgzk5': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4k3jnl38': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // forgotPassword
  {
    'g416xg9f': {
      'en': 'Forgot Password',
      'ar': 'هل نسيت كلمة السر',
      'de': 'Passwort vergessen',
      'es': 'Has olvidado tu contraseña',
    },
    'xaiad71o': {
      'en':
          'Enter the email associated with your account and we will send you a verification code.',
      'ar': 'أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رمز التحقق.',
      'de':
          'Geben Sie die mit Ihrem Konto verknüpfte E-Mail-Adresse ein und wir senden Ihnen einen Bestätigungscode.',
      'es':
          'Introduce el correo electrónico asociado a tu cuenta y te enviaremos un código de verificación.',
    },
    'u4nuk910': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    '37kotxi0': {
      'en': '',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'hiwpaze1': {
      'en': 'send',
      'ar': 'أرسل رابط إعادة التعيين',
      'de': 'Zurücksetzen-Link senden',
      'es': 'Enviar enlace de reinicio',
    },
    '598b8d3m': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // onboarding
  {
    'i8hl2uua': {
      'en': 'Bienvenida',
      'ar': 'إنشاء الميزانيات',
      'de': 'Erstellen Sie Budgets',
      'es': 'Crear presupuestos',
    },
    'hxtwax0y': {
      'en': 'Guia de onboarding de la app',
      'ar':
          'قم بإنشاء ميزانيات يمكنك ربط المعاملات بها أيضًا من أجل التتبع السهل.',
      'de':
          'Erstellen Sie Budgets, mit denen Sie auch Transaktionen verknüpfen können, um sie einfach nachverfolgen zu können.',
      'es':
          'Cree presupuestos en los que también pueda vincular transacciones para facilitar el seguimiento.',
    },
    'mjy3ljln': {
      'en': 'Keep Track of Spending',
      'ar': 'تتبع الإنفاق',
      'de': 'Behalten Sie die Ausgaben im Auge',
      'es': 'Mantenga un registro de los gastos',
    },
    'uf9k1spp': {
      'en':
          'Easily add transactions and associate them with budgets that have been created.',
      'ar': 'أضف المعاملات بسهولة وربطها بالميزانيات التي تم إنشاؤها.',
      'de':
          'Fügen Sie ganz einfach Transaktionen hinzu und verknüpfen Sie sie mit erstellten Budgets.',
      'es':
          'Agregue fácilmente transacciones y asócielas con los presupuestos que se han creado.',
    },
    '9c4outzf': {
      'en': 'Budget Analysis',
      'ar': 'تحليل الميزانية',
      'de': 'Budgetanalyse',
      'es': 'Análisis de presupuesto',
    },
    'q30ina4f': {
      'en': 'Know where your budgets are and how they can be adjusted.',
      'ar': 'تعرف على مكان ميزانياتك وكيف يمكن تعديلها.',
      'de': 'Wissen, wo Ihre Budgets sind und wie sie angepasst werden können.',
      'es': 'Sepa dónde están sus presupuestos y cómo se pueden ajustar.',
    },
    'ypt7b97g': {
      'en': 'Continuar',
      'ar': 'إنشاء ميزانيتك',
      'de': 'Erstellen Sie Ihr Budget',
      'es': 'Crea tu presupuesto',
    },
    'oo0kk9qe': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // changePassword
  {
    'l5iggwaz': {
      'en': 'Cambiar Contraseña',
      'ar': 'تغيير كلمة المرور',
      'de': 'Kennwort ändern',
      'es': 'Cambia la contraseña',
    },
    '2b97u8y5': {
      'en':
          'Ingrese el correo electrónico asociado con su cuenta y le enviaremos un enlace para restablecer su contraseña.',
      'ar':
          'أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رابطًا لإعادة تعيين كلمة المرور الخاصة بك.',
      'de':
          'Geben Sie die mit Ihrem Konto verknüpfte E-Mail-Adresse ein und wir senden Ihnen einen Link zum Zurücksetzen Ihres Passworts.',
      'es':
          'Ingrese el correo electrónico asociado con su cuenta y le enviaremos un enlace para restablecer su contraseña.',
    },
    'ajy1c3r9': {
      'en': 'Correo Electrónico',
      'ar': 'عنوان البريد الالكترونى',
      'de': 'E-Mail-Addresse',
      'es': 'Dirección de correo electrónico',
    },
    'hsqfoxya': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني ...',
      'de': 'Geben sie ihre E-Mail Adresse ein...',
      'es': 'Introduce tu correo electrónico...',
    },
    'if4pz6lm': {
      'en': 'Confirmar Correo',
      'ar': 'أرسل رابط إعادة التعيين',
      'de': 'Zurücksetzen-Link senden',
      'es': 'Enviar enlace de reinicio',
    },
    '5tvk9lv0': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // notificationsSettings
  {
    'sc4ff4ce': {
      'en': 'Notifications',
      'ar': 'إشعارات',
      'de': 'Benachrichtigungen',
      'es': 'Notificaciones',
    },
    'r72zvrv5': {
      'en':
          'Choose what notifcations you want to recieve below and we will update the settings.',
      'ar': 'اختر الإشعارات التي تريد تلقيها أدناه وسنقوم بتحديث الإعدادات.',
      'de':
          'Wählen Sie unten aus, welche Benachrichtigungen Sie erhalten möchten, und wir aktualisieren die Einstellungen.',
      'es':
          'Elija qué notificaciones desea recibir a continuación y actualizaremos la configuración.',
    },
    'gjygkr0n': {
      'en': 'Push Notifications',
      'ar': 'دفع الإخطارات',
      'de': 'Mitteilungen',
      'es': 'Notificaciones push',
    },
    '3y3yhxbk': {
      'en':
          'Receive Push notifications from our application on a semi regular basis.',
      'ar': 'تلقي إشعارات من تطبيقنا على أساس شبه منتظم.',
      'de':
          'Erhalten Sie regelmäßig Push-Benachrichtigungen von unserer Anwendung.',
      'es':
          'Reciba notificaciones Push de nuestra aplicación de forma semi regular.',
    },
    'ci8ghkcc': {
      'en': 'Push Notifications',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2ij5g20v': {
      'en':
          'Receive Push notifications from our application on a semi regular basis.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gin9u61n': {
      'en': 'Push Notifications',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0sp82d0l': {
      'en':
          'Receive Push notifications from our application on a semi regular basis.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'isgrgbfs': {
      'en': 'Save Changes',
      'ar': 'حفظ التغييرات',
      'de': 'Änderungen speichern',
      'es': 'Guardar cambios',
    },
    'a96mlyeh': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // privacyPolicy
  {
    'alczfiiy': {
      'en': 'Privacy Policy',
      'ar': 'سياسة الخصوصية',
      'de': 'Datenschutz-Bestimmungen',
      'es': 'Políticas de privacidad',
    },
    'fvsfg5on': {
      'en': 'How Comersium Use Your Data',
      'ar': 'كيف نستخدم بياناتك',
      'de': 'Wie wir Ihre Daten verwenden',
      'es': 'Cómo usamos sus datos',
    },
    'nbiyrnzl': {
      'en':
          'At Comersium, your privacy is a priority. We are committed to protecting your personal information and being transparent about how we use your data. This document outlines the types of data we collect, how we use it, and your rights regarding your personal information.',
      'ar':
          'Lorem ipsum dolor sit amet، consectetur adipiscing elit، sed do eiusmod tempor incidunt ut labore et dolore magna aliqua. Accumsan sit amet nulla facilisi morbi tempus. غير consectetur a erat nam. دونك ألتريسيس تينسيدونت قوس غير مخادع. Velit sed ullamcorper morbi tincidunt. Molestie a iaculis في erat pellentesque adipiscing. موريس نونك كونيج سيرة ذاتية. Nisl tincidunt eget nullam non nisi. Faucibus nisl tincidunt eget nullam non nisi est. Leo duis ut diam quam nulla. Euismod lacinia في quis risus sed vulputate odio. فيليت كريمينسيم sodales ut eu sem سيرة ذاتية صحيحة justo eget. Risus feugiat في ما قبل ميتوس. Leo vel orci porta non pulvinar neque laoreet suspension interdum. Suscipit Tellus mauris a Diam Maecenas Sed enim ut sem. SEM السيرة الذاتية الصحيحة justo eget magna fermentum iaculis eu. لاسينيا في quis risus sed. Faucibus purus في ماسا مؤقت. ليو بقطر سوليتودين معرف مؤقت الاتحاد الأوروبي. Nisi scelerisque eu ultrices السيرة الذاتية موصل. Vulputate كريم معلق في وقت مبكر. Enim neque volutpat ac tincidunt vitae semper quis. Ipsum dolor sit amet consectetur adipiscing elit. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Sed sed risus Préium quam vulputate. Elit pellentesque موطن morbi tristique senectus et. Viverra maecenas accumsan lacus vel facilisis volutpat est. sit amet mattis vulputate enim nulla. Nisi lacus sed viverra Tellus في العادة السيئة. اجلس أميت ريسوس نولام إيجيت فيليس إيجيت نونك لوبورتيز. Pretium lectus quam id leo in vitae. Adipiscing Diam donec adipiscing tristique. كومودو سيد egestas egestas fringilla. Ipsum dolor sit amet consectetur adipiscing. Ipsum dolor sit amet consectetur adipiscing النخبة pellentesque المعيشية morbi. مونتيس ناسيتور ريديكولوس موس موريس. Ut etiam sit amet nisl purus in. Arcu ac Ornare suspendisse sed nisi lacus sed viverra.',
      'de':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Accumsan sit amet nulla facilisi morbi tempus. Non consectetur a erat nam. Donec ultrices tincidunt arcu non sodales. Velit sed ullamcorper morbi tincidunt. Molestie a iaculis bei erat pellentesque adipiscing. Mauris nunc congue nisi vitae. Nisl tincidunt eget nullam non nisi. Faucibus nisl tincidunt eget nullam non nisi est. Leo duis ut diam quam nulla. Euismod lacinia at quis risus sed vulputate odio. Velit dignissim sodales ut eu sem integer vitae justo eget. Risus feugiat in ante metus. Leo vel orci porta non pulvinar neque laoreet suspendisse interdum. Suscipit tellus mauris a diam maecenas sed enim ut sem. Sem integer vitae justo eget magna fermentum iaculis eu. Lacinia bei quis risus sed. Faucibus purus in massa tempor. Leo a diam sollicitudin tempor id eu. Nisi scelerisque eu ultrices vitae auctor. Vulputate dignissim suspendisse in est ante in. Enim neque volutpat ac tincidunt vitae semper quis. Ipsum dolor sit amet consectetur adipiscing elit. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Sed sed risus pretium quam vulputate. Elit pellentesque habitant morbi tristique senectus et. Viverra maecenas accumsan lacus vel facilisis volutpat est. Sit amet mattis vulputate enim nulla. Nisi lacus sed viverra tellus in hac habitasse. Sit amet risus nullam eget felis eget nunc lobortis. Pretium lectus quam id leo in vitae. Adipiscing diam donec adipiscing tristique. Commodo sed egestas egestas fringilla. Ipsum dolor sit amet consectetur adipiscing. Ipsum dolor sit amet consectetur adipiscing elit pellentesque habitant morbi. Montes nascetur ridiculus mus mauris. Ut etiam sit amet nisl purus in. Arcu ac tortor dignissim convallis aenean et tortor at. Ornare suspendisse sed nisi lacus sed viverra.',
      'es':
          'En Comersium, su privacidad es una prioridad. Nos comprometemos a proteger su información personal y a ser transparentes sobre cómo utilizamos sus datos. Este documento describe los tipos de datos que recopilamos, cómo los utilizamos y sus derechos en relación con su información personal.',
    },
    'hkhk60sj': {
      'en':
          'Data We Collect\n\nPersonal Information: When you register for an account, we collect information such as your name, email address, phone number, and physical address.\n\nBusiness Information: If you register a business on our platform, we collect details about your business, including its name, address, contact information, and description.\n\nImages: If you upload images for your business profile or services, we collect and store those images.\n\nLocation Data: We may collect your location data to provide location-based services, such as showing nearby businesses.\n\nUsage Data: We collect information on how you interact with the app, such as the features you use, the pages you visit, and the time you spend on the app.\n\nDevice Information: We collect information about the device you use to access our app, including IP address, device type, and operating system.\n\n2. How We Use Your Data\n\nTo Provide and Improve Our Services: We use your data to operate and improve the Comersium app. This includes personalizing your experience, responding to your requests, and providing customer support.\n\nBusiness Listings: If you register a business, we use your data to create and display your business profile to other users.\n\nCommunication: We use your contact information to send you important updates, promotional offers, and notifications related to your account and the app.\n\nLocation-Based Services: We use your location data to provide relevant business listings and enhance your user experience.\n\nAnalytics: We use usage data and device information to analyze trends, monitor the app’s performance, and improve our services.\n\nSecurity: We use your data to detect and prevent fraudulent activities, ensure the safety of your account, and comply with legal obligations.\n\n3. Sharing Your Data\n\nWith Other Users: Your business information and any public data, such as reviews and ratings, may be visible to other users of the app.\n\nWith Third Parties: We may share your data with third-party service providers who help us operate the app, such as cloud hosting providers, payment processors, and analytics services. These third parties are required to protect your data and use it only for the purposes we specify.\n\nFor Legal Reasons: We may disclose your data if required by law or if we believe that such action is necessary to comply with legal obligations, protect our rights, or ensure the safety of our users.\n\n4. Your Rights\n\nAccess: You have the right to access the personal data we hold about you. You can request a copy of your data by contacting us.\n\nCorrection: If you believe that any of your personal information is inaccurate or incomplete, you can request that we correct or update it.\n\nDeletion: You have the right to request the deletion of your personal data. We will honor your request, subject to any legal obligations we may have.\n\nOpt-Out: You can opt-out of receiving promotional communications from us by following the unsubscribe instructions in the emails we send you.\n\n5. Data Security\n\nWe take reasonable measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction. However, no data transmission over the internet or electronic storage method is 100% secure. Therefore, we cannot guarantee absolute security.\n\n6. Changes to This Policy\n\nWe may update this policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify you of any significant changes by posting the new policy in the app or by other means.',
      'ar': '',
      'de': '',
      'es':
          'Datos que recopilamos\n\nInformación personal: cuando se registra para una cuenta, recopilamos información como su nombre, dirección de correo electrónico, número de teléfono y dirección física.\n\nInformación comercial: si registra una empresa en nuestra plataforma, recopilamos detalles sobre su empresa, incluido su nombre, dirección, información de contacto y descripción.\n\nImágenes: si carga imágenes para su perfil o servicios comerciales, recopilamos y almacenamos esas imágenes.\n\nDatos de ubicación: podemos recopilar sus datos de ubicación para proporcionar servicios basados ​​en la ubicación, como mostrar empresas cercanas.\n\nDatos de uso: recopilamos información sobre cómo interactúa con la aplicación, como las funciones que usa, las páginas que visita y el tiempo que pasa en la aplicación.\n\nInformación del dispositivo: recopilamos información sobre el dispositivo que usa para acceder a nuestra aplicación, incluida la dirección IP, el tipo de dispositivo y el sistema operativo.\n\n2. Cómo usamos sus datos\n\nPara proporcionar y mejorar nuestros servicios: utilizamos sus datos para operar y mejorar la aplicación Comersium. Esto incluye personalizar tu experiencia, responder a tus solicitudes y brindar atención al cliente.\n\nListados de empresas: si registras una empresa, usamos tus datos para crear y mostrar tu perfil comercial a otros usuarios.\n\nComunicación: usamos tu información de contacto para enviarte actualizaciones importantes, ofertas promocionales y notificaciones relacionadas con tu cuenta y la aplicación.\n\nServicios basados ​​en la ubicación: usamos tus datos de ubicación para proporcionar listados de empresas relevantes y mejorar tu experiencia de usuario.\n\nAnálisis: usamos datos de uso e información del dispositivo para analizar tendencias, monitorear el rendimiento de la aplicación y mejorar nuestros servicios.\n\nSeguridad: usamos tus datos para detectar y prevenir actividades fraudulentas, garantizar la seguridad de tu cuenta y cumplir con las obligaciones legales.\n\n3. Compartir tus datos\n\nCon otros usuarios: Tu información comercial y cualquier dato público, como reseñas y calificaciones, pueden ser visibles para otros usuarios de la aplicación.\n\nCon terceros: Podemos compartir tus datos con proveedores de servicios externos que nos ayudan a operar la aplicación, como proveedores de alojamiento en la nube, procesadores de pagos y servicios de análisis. Estos terceros deben proteger tus datos y utilizarlos solo para los fines que especificamos.\n\nPor motivos legales: Podemos divulgar tus datos si lo exige la ley o si creemos que dicha acción es necesaria para cumplir con las obligaciones legales, proteger nuestros derechos o garantizar la seguridad de nuestros usuarios.\n\n4. Tus derechos\n\nAcceso: Tienes derecho a acceder a los datos personales que tenemos sobre ti. Puedes solicitar una copia de tus datos poniéndote en contacto con nosotros.\n\nCorrección: Si crees que alguno de tus datos personales es inexacto o está incompleto, puedes solicitar que lo corrijamos o actualicemos.\n\nEliminación: Tienes derecho a solicitar la eliminación de tus datos personales. Respetaremos su solicitud, sujeto a cualquier obligación legal que podamos tener.\n\nDarse de baja: puede darse de baja para no recibir comunicaciones promocionales nuestras siguiendo las instrucciones para darse de baja en los correos electrónicos que le enviamos.\n\n5. Seguridad de los datos\n\nTomamos medidas razonables para proteger su información personal del acceso, alteración, divulgación o destrucción no autorizados. Sin embargo, ninguna transmisión de datos a través de Internet o método de almacenamiento electrónico es 100% segura. Por lo tanto, no podemos garantizar una seguridad absoluta.\n\n6. Cambios a esta política\n\nPodemos actualizar esta política de vez en cuando para reflejar cambios en nuestras prácticas o por otras razones operativas, legales o regulatorias. Le notificaremos sobre cualquier cambio significativo publicando la nueva política en la aplicación o por otros medios.',
    },
    'oks4x95o': {
      'en': 'Home',
      'ar': 'مسكن',
      'de': 'Heim',
      'es': 'Casa',
    },
  },
  // LogoWall
  {
    'd2ya5nyy': {
      'en': 'Inicio',
      'ar': '',
      'de': '',
      'es': 'Inicio',
    },
  },
  // searchComersiums
  {
    '2h8nto9u': {
      'en': 'Comersium ™',
      'ar': '',
      'de': '',
      'es': 'Comersium ™',
    },
    'afwcuhz0': {
      'en': 'Busca cualquier negocio...',
      'ar': '',
      'de': '',
      'es': 'Busca cualquier negocio...',
    },
    'wis6xwfz': {
      'en': 'Todos',
      'ar': '',
      'de': '',
      'es': 'Todos',
    },
    'paidhval': {
      'en': 'restaurantes',
      'ar': '',
      'de': '',
      'es': 'restaurantes',
    },
    '9w6gsny8': {
      'en': 'clinicas',
      'ar': '',
      'de': '',
      'es': 'clinicas',
    },
    '9scadztd': {
      'en': 'farmacias',
      'ar': '',
      'de': '',
      'es': 'farmacias',
    },
    'wtar96k4': {
      'en': 'distribuidores',
      'ar': '',
      'de': '',
      'es': 'distribuidores',
    },
    'q79hifsa': {
      'en': 'joyerias',
      'ar': '',
      'de': '',
      'es': 'joyerias',
    },
    'ry361uwj': {
      'en': 'Todos',
      'ar': '',
      'de': '',
      'es': 'Todos',
    },
    'u34z93d6': {
      'en': 'Popular Today',
      'ar': '',
      'de': '',
      'es': 'Nuestros Comercios',
    },
    'h1t2bptp': {
      'en': 'Ver mas',
      'ar': '',
      'de': '',
      'es': 'Ver mas',
    },
    'u3dirz7w': {
      'en': 'Ver mas',
      'ar': '',
      'de': '',
      'es': 'Ver mas',
    },
    'sr2ijvdv': {
      'en': 'Buscar',
      'ar': '',
      'de': '',
      'es': 'Buscar',
    },
    '0v5z1z1v': {
      'en': 'Notification',
      'ar': '',
      'de': '',
      'es': 'Notificaciones',
    },
    '0v5z1z2v': {
      'en': 'Chats',
      'ar': '',
      'de': '',
      'es': 'Mensajeria',
    },
  },
  // waitingPage
  {
    'ih7tz64s': {
      'en': 'Esperando verifiacion de su cuenta.',
      'ar': '',
      'de': '',
      'es': 'Esperando verifiacion de su cuenta.',
    },
    'k5zj940s': {
      'en': 'Ingrese a su correo y verifique su cuenta.',
      'ar': '',
      'de': '',
      'es': 'Ingrese a su correo y verifique su cuenta.',
    },
    '0ahckijs': {
      'en': 'Aceptar',
      'ar': '',
      'de': '',
      'es': 'Aceptar',
    },
    'ui1ljm5k': {
      'en': 'Reenviar Correo',
      'ar': '',
      'de': '',
      'es': 'Reenviar Correo',
    },
    'sr9l2lge': {
      'en': 'Confirmacion Pendiente',
      'ar': '',
      'de': '',
      'es': 'Confirmacion Pendiente',
    },
    '2vktcros': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': 'Home',
    },
  },
  // SettingsPage
  {
    'u4guovmd': {
      'en': 'Mi Perfil',
      'ar': '',
      'de': '',
      'es': 'Mi Perfil',
    },
    '0evr2ihm': {
      'en': 'Ajustes de cuenta',
      'ar': '',
      'de': '',
      'es': 'Ajustes de cuenta',
    },
    'vaizm32p': {
      'en': 'Cambiar Contraseña',
      'ar': '',
      'de': '',
      'es': 'Cambiar Contraseña',
    },
    '0a8ikyu7': {
      'en': 'Chat',
      'ar': '',
      'de': '',
      'es': 'Chat',
    },
    'eubl1xd1': {
      'en': 'Cambiar Preferencias',
      'ar': '',
      'de': '',
      'es': 'Cambiar Preferencias',
    },
    'eubl1xd2': {
      'en': 'Editar Perfil',
      'ar': '',
      'de': '',
      'es': 'Editar Perfil',
    },
    'todzsdjf': {
      'en': 'Help',
      'ar': '',
      'de': '',
      'es': 'Ayuda',
    },
    'vt30873q': {
      'en': 'Politicas de Privacidad',
      'ar': '',
      'de': '',
      'es': 'Politicas de Privacidad',
    },
    'b5nywvhr': {
      'en': 'Cerrar Sesion',
      'ar': '',
      'de': '',
      'es': 'Cerrar Sesion',
    },
    '6yjtviwi': {
      'en': 'Ajustes',
      'ar': '',
      'de': '',
      'es': 'Ajustes',
    },
  },
  // RegisterBusiness
  {
    'esiiw2sh': {
      'en': 'Registra tu Negocio',
      'ar': '',
      'de': '',
      'es': 'Registra tu Negocio',
    },
    'j5ri69ky': {
      'en': 'Ingresa todos los datos de tu negocio',
      'ar': '',
      'de': '',
      'es': 'Ingresa todos los datos de tu negocio',
    },
    '5w3r05au': {
      'en': 'Logo de tu negocio',
      'ar': '',
      'de': '',
      'es': 'Logo de tu negocio',
    },
    '013agk4t': {
      'en': 'Portada de tu negocio',
      'ar': '',
      'de': '',
      'es': 'Portada de tu negocio',
    },
    '20imude4': {
      'en': 'Datos Generales',
      'ar': '',
      'de': '',
      'es': 'Datos Generales',
    },
    'aqmjopi7': {
      'en': 'Nombre',
      'ar': '',
      'de': '',
      'es': 'Nombre',
    },
    '2evnv1ry': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ar1zlxjq': {
      'en': 'Contraseña',
      'ar': '',
      'de': '',
      'es': 'Contraseña',
    },
    '6ojpt080': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    't196swju': {
      'en': 'Repita la contraseña',
      'ar': '',
      'de': '',
      'es': 'Repita la contraseña',
    },
    'bq0dxr17': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'braapcns': {
      'en': 'Correo',
      'ar': '',
      'de': '',
      'es': 'Correo',
    },
    '8sfqlb6z': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'oe7866go': {
      'en': 'Numero Celular',
      'ar': '',
      'de': '',
      'es': 'Numero Celular',
    },
    '6xclue7q': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '20jxatqb': {
      'en': 'Direccion',
      'ar': '',
      'de': '',
      'es': 'Direccion',
    },
    'fgk2kuyn': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '7wiv2glv': {
      'en': 'Descripcion',
      'ar': '',
      'de': '',
      'es': 'Descripcion',
    },
    '2wkljl28': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'warq7rtk': {
      'en': 'Selecciona un color',
      'ar': '',
      'de': '',
      'es': 'Selecciona un color',
    },
    '6c6tt3h7': {
      'en': 'Tecnologia',
      'ar': '',
      'de': '',
      'es': 'Tecnologia',
    },
    'uu12ppt3': {
      'en': 'Belleza',
      'ar': '',
      'de': '',
      'es': 'Belleza',
    },
    'avmn1sb5': {
      'en': 'Comida',
      'ar': '',
      'de': '',
      'es': 'Comida',
    },
    'r9xwgt6t': {
      'en': 'Ropa',
      'ar': '',
      'de': '',
      'es': 'Ropa',
    },
    '4prb870h': {
      'en': 'Selecciona una categoria',
      'ar': '',
      'de': '',
      'es': 'Selecciona una categoria',
    },
    'w6j6zhqa': {
      'en': 'Search for an item...',
      'ar': '',
      'de': '',
      'es': '',
    },
    'liij4q4k': {
      'en': 'Registra la ubicaion de tu local',
      'ar': '',
      'de': '',
      'es': 'Registra la ubicaion de tu local',
    },
    'tyno9ubp': {
      'en': 'Redes Sociales',
      'ar': '',
      'de': '',
      'es': 'Redes Sociales',
    },
    'ao8ikn4f': {
      'en': 'Facebook',
      'ar': '',
      'de': '',
      'es': 'Facebook',
    },
    'dq0syjje': {
      'en': 'Link a su facebook',
      'ar': '',
      'de': '',
      'es': 'Link a su facebook',
    },
    'qkfk487g': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'oca2i7yw': {
      'en': 'Instagram',
      'ar': '',
      'de': '',
      'es': 'Instagram',
    },
    'yna9qayd': {
      'en': 'Link a su instagram',
      'ar': '',
      'de': '',
      'es': 'Link a su instagram',
    },
    '7xj8ajx2': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'dr2xrk8x': {
      'en': 'Recursos',
      'ar': '',
      'de': '',
      'es': 'Recursos',
    },
    'lgl3hxki': {
      'en': 'Subir Imagenes',
      'ar': '',
      'de': '',
      'es': 'Subir Imagenes',
    },
    '9w4i4sgv': {
      'en': 'Registrar',
      'ar': '',
      'de': '',
      'es': 'Registrar',
    },
    'ya01fixm': {
      'en': 'Nombre de usuario requerido',
      'ar': '',
      'de': '',
      'es': 'Nombre de usuario requerido',
    },
    'mxe6puq9': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': 'Por favor elige una opcion de la lista',
    },
    'telfb8y9': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': 'Campo requerido',
    },
    '31kyu2mk': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': 'Por favor elige una opcion de la lista',
    },
    'rfiyuw02': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': 'Campo requerido',
    },
    'ba3iznpf': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'exx7h2fi': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'tjydzxve': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1p5werki': {
      'en': 'Numero personal requerido',
      'ar': '',
      'de': '',
      'es': '',
    },
    'chcaq0i2': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'n26n6k8r': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'fp0rvhc9': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4pvb5cd8': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6dokmlpm': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2zs90176': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ninio88y': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'acdy29rl': {
      'en': 'Field is required',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0gyyrvuq': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
    'jfr6u9lt': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // ProfileBusiness
  {
    'dwm9pv9b': {
      'en': '5:30 PM',
      'ar': '',
      'de': '',
      'es': '5:30 PM',
    },
    'vbsjncv9': {
      'en': 'Cierra a las',
      'ar': '',
      'de': '',
      'es': 'Cierra a las',
    },
    'lcwmp8uv': {
      'en': '420',
      'ar': '',
      'de': '',
      'es': '420',
    },
    'molyj30g': {
      'en': 'Clientes felices',
      'ar': '',
      'de': '',
      'es': 'Clientes felices',
    },
    'kqbg1p4c': {
      'en': '1,200',
      'ar': '',
      'de': '',
      'es': '1,200',
    },
    '486vkra4': {
      'en': 'Ventas exitosas',
      'ar': '',
      'de': '',
      'es': 'Ventas exitosas',
    },
    'rw1nsz5a': {
      'en': 'Conocenos',
      'ar': '',
      'de': '',
      'es': 'Conocenos',
    },
    '5fl6ai1t': {
      'en': 'Ubicanos',
      'ar': '',
      'de': '',
      'es': 'Ubicanos',
    },
    '505q8dal': {
      'en': 'Contributes',
      'ar': '',
      'de': '',
      'es': 'Contribuye',
    },
    '0z1j1v5v': {
      'en': 'Write a review',
      'ar': '',
      'de': '',
      'es': 'Escribe una opinión',
    },
    'd3hqw9i9': {
      'en': 'Puedes dejar tu comentario en la seccion de comentarios',
      'ar': '',
      'de': '',
      'es': 'Puedes dejar tu comentario en la seccion de comentarios',
    },
    '0td4kr8o': {
      'en': 'Comentarios',
      'ar': '',
      'de': '',
      'es': 'Comentarios',
    },
    't5rqvxuw': {
      'en': 'Escribe un comentario',
      'ar': '',
      'de': '',
      'es': 'Escribe un comentario',
    },
    'nbsrn83q': {
      'en': 'Powered by',
      'ar': '',
      'de': '',
      'es': 'Powered by',
    },
    'gnoogxc2': {
      'en': 'COMERSIUM™',
      'ar': '',
      'de': '',
      'es': 'COMERSIUM™',
    },
    'wqjjmv2t': {
      'en': 'Profile',
      'ar': '',
      'de': '',
      'es': '',
    },
    'evwpgwl4': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': 'Home',
    },
  },
  // chat_2_Details
  {
    'iryon8i3': {
      'en': 'Group Chat',
      'ar': '',
      'de': '',
      'es': '',
    },
    '643inswq': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // chat_2_main
  {
    '4mdbefjf': {
      'en': 'Below are your chats',
      'ar': '',
      'de': '',
      'es': 'Encuentra tus conversaciones',
    },
    '4wyuivfb': {
      'en': 'Group Chat',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2decl92i': {
      'en': 'My Chats',
      'ar': '',
      'de': '',
      'es': 'Mis Conversaciones',
    },
    'h07uhyuh': {
      'en': '__',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // chat_2_InviteUsers
  {
    '43ozc4gm': {
      'en': 'Chatea con el comercio que desees',
      'ar': '',
      'de': '',
      'es': 'Chatea con el comercio que desees',
    },
    '66k708fo': {
      'en': 'Selected',
      'ar': '',
      'de': '',
      'es': 'Seleccionado',
    },
    'h7mb5btx': {
      'en': 'Lista de Negocios',
      'ar': '',
      'de': '',
      'es': 'Lista de Negocios',
    },
    'xr0vzre2': {
      'en': 'Selecciona un negocio para comunicarte con el',
      'ar': '',
      'de': '',
      'es': 'Selecciona un negocio para comunicarte con el',
    },
    '5585zzm4': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': 'Home',
    },
  },
  // image_Details
  {
    'hubwxgmb': {
      'en': 'Home',
      'ar': '',
      'de': '',
      'es': 'Home',
    },
  },
  // review
  {
    'l6thl1b8': {
      'en': 'Calificaciones',
      'ar': '',
      'de': '',
      'es': 'Calificaciones',
    },
    'm394qha1': {
      'en': '4 de 5 Estrellas',
      'ar': '',
      'de': '',
      'es': '4 de 5 Estrellas',
    },
  },
  // chat_ThreadComponent
  {
    'jweo5x6r': {
      'en': 'Start typing here...',
      'ar': '',
      'de': '',
      'es': 'Empieza a escribir aqui...',
    },
    'nf8t9l1b': {
      'en': 'You must enter a message...',
      'ar': '',
      'de': '',
      'es': '',
    },
    'g3igboi6': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // user_ListSmall
  {
    'rubgik81': {
      'en': 'ME',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // deleteDialog
  {
    'lbr9wo4c': {
      'en': 'Options',
      'ar': '',
      'de': '',
      'es': '',
    },
    'in3v7d0h': {
      'en': 'Invite Users',
      'ar': '',
      'de': '',
      'es': '',
    },
    'y2ifpmju': {
      'en': 'Delete Chat',
      'ar': '',
      'de': '',
      'es': '',
    },
    '1jwbb9ee': {
      'en': 'Confirm Delete',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ga6w4oev': {
      'en': 'You can\'t undo this action.',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ykjce8rx': {
      'en': 'Delete',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
  // Miscellaneous
  {
    'lzyb73wy': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'kx9cdks4': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'efvtwj7k': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'ec5hfa1e': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'q5ljwvfo': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'j4rmwb3h': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '6ah1b18f': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '2kos1hen': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'xie5n43s': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'rxzaip05': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'm2t7wgrr': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'gf5p7081': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'qtjadhsm': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'aox3s4fb': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'l8hv5a7z': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '4pjwb70a': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0xlokf4y': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '8twlwiwt': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'i0zlo1d1': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    't8ll4jms': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '0bq6o3w7': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'bxtxe54s': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'sjuele7o': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '06dte6yj': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    't4xzlq9q': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    '513nj4m0': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
    'a1jxfgju': {
      'en': '',
      'ar': '',
      'de': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
