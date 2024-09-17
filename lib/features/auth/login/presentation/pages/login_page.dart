import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/core/shared/widgets/custome_loading.dart';
import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../../../../core/functions/navigation.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../bloc/login_bloc.dart';
import '../widgets/login_form_widget.dart';
import '../widgets/login_header_widget.dart';
import '../widgets/login_social_media_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginFormState = GlobalKey<FormState>();

  late TextEditingController userEmail;
  late TextEditingController userPassword;
  bool showHiddenPassword = true;
  bool isChecked = false;

  toggolePasswordEvent() {
    setState(() {
      showHiddenPassword = !showHiddenPassword;
    });
  }

  toggoleRememberMeEvent() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  void initState() {
    super.initState();
    userEmail = TextEditingController();
    userPassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    userEmail.dispose();
    userPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginErrorState) {
          THelperFunctions.showSnackBar(
            context: context,
            title: SharedConstants.messageWrongAlertTitle.tr(context),
            message: state.errorMsg,
            type: ContentType.failure,
          );
        } else if (state is LoginSuccessState) {
          if (isChecked) {
            pushNamedAndRemoveUntil(
                context, PagesName.navigationMenuPage, false);
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString("step", "2");
          } else {
            pushNamedAndRemoveUntil(
                context, PagesName.navigationMenuPage, false);
          }
        } else if (state is GoogleLoginErrorState) {
          Navigator.of(context).pop();
          THelperFunctions.showSnackBar(
            context: context,
            title: SharedConstants.messageWrongAlertTitle.tr(context),
            message: state.errorMsg,
            type: ContentType.failure,
          );
          print(state.errorMsg);
        } else if (state is GoogleLoginSuccessState) {
          Navigator.of(context).pop();
          pushNamedAndRemoveUntil(
            context,
            PagesName.navigationMenuPage,
            false,
          );
          
        } else if (state is NoInternetConnectionState) {
          Navigator.of(context).pop();
          THelperFunctions.showSnackBar(
            context: context,
            title: SharedConstants.messageWrongAlertTitle.tr(context),
            message: SharedConstants.messageNoInternetConnection.tr(context),
            type: ContentType.failure,
          );
        } else if (state is GoogleLoginLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Dialog(
              backgroundColor: Colors.transparent,
              child: LoadingWidget(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginHeader(),
                  LoginForm(
                    formKey: loginFormState,
                    userEmail: userEmail,
                    userPassword: userPassword,
                    showHiddenPassword: showHiddenPassword,
                    isChecked: isChecked,
                    onTogglePassword: toggolePasswordEvent,
                    onToggleRememberMe: toggoleRememberMeEvent,
                    onLogin: () {
                      if (loginFormState.currentState!.validate()) {
                        BlocProvider.of<LoginBloc>(context).add(SignInEvent(
                            email: userEmail.text,
                            password: userPassword.text));
                      }
                    },
                    onNavigateToRegister: () => pushNamedAndRemoveUntil(
                      context,
                      PagesName.registerPage,
                      false,
                    ),
                  ),
                  const SocialLoginButtons(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
