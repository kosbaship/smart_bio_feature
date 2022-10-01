import 'package:feature_oriented/app/injection_container.dart';
import 'package:feature_oriented/core/utils/compass.dart';
import 'package:feature_oriented/core/utils/constants.dart';
import 'package:feature_oriented/core/utils/logger.dart';
import 'package:feature_oriented/core/utils/theme.dart';
import 'package:feature_oriented/core/widgets/custom_snak_bar.dart';
import 'package:feature_oriented/feature/home/presentation/page/home.dart';
import 'package:feature_oriented/feature/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _viewNode = FocusNode();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CustomSnackBar? _snackBar;

  /// BioMetric
  LocalAuthentication localAuth = LocalAuthentication();
  String authorized = "Not Authorized";

  Future<bool?> checkAuthenticateAvailability() async {
    try {
      LoggerUtils().makeLoggerInfo("canCheckBiometrics " +
          (await localAuth.canCheckBiometrics).toString());
      LoggerUtils().makeLoggerInfo("isDeviceSupported " +
          (await localAuth.isDeviceSupported()).toString());

      final isCheckingAvailable = await localAuth.canCheckBiometrics;
      final isDeviceSupported = await localAuth.isDeviceSupported();
      return isCheckingAvailable && isDeviceSupported;
    } on PlatformException catch (e) {
      LoggerUtils().makeLoggerError(e.toString());
    }
    setState(() {});
  }

  Future<List<BiometricType>?> _getAvailableBiometrics() async {
    try {
      LoggerUtils().makeLoggerInfo(
          (await localAuth.getAvailableBiometrics()).toString());
      return await localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      LoggerUtils().makeLoggerError(e.toString());
    }
    setState(() {});
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await localAuth.authenticate(
          localizedReason: "Scan your finger print to authenticate",
          useErrorDialogs: false,
          stickyAuth: false,
          biometricOnly: true);
    } on PlatformException catch (e) {
      switch (e.code) {
        case auth_error.notEnrolled:
          LoggerUtils().makeLoggerError(
              "You Have not enrolled any fingerprints on this device.");
          break;
        case auth_error.passcodeNotSet:
          LoggerUtils().makeLoggerError(
              "You Have not enrolled any fingerprints on this device.");
          break;
        case auth_error.notAvailable:
          LoggerUtils().makeLoggerError(
              "This device does not have a Touch ID/fingerprint scanner");
          break;
        case auth_error.otherOperatingSystem:
          LoggerUtils().makeLoggerError("This is not iOS or Android device");
          break;
        case auth_error.lockedOut:
          LoggerUtils().makeLoggerError(
              "Lock out for a few seconds due to too many attempts");
          break;
        case auth_error.permanentlyLockedOut:
          LoggerUtils().makeLoggerError("Disabled due to too many lock outs");
          break;
      }
    }
    if (!mounted) return;

    setState(() {
      authorized =
          authenticated ? "Authorized success" : "Failed to authenticate";
    });
  }

  @override
  void initState() {
    checkAuthenticateAvailability();
    _getAvailableBiometrics();
    super.initState();
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
    _viewNode.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _snackBar = CustomSnackBar(key: const Key("snackbar"), context: context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_viewNode),
      child: Scaffold(
        key: _scaffoldKey,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: CustomColor.statusBarColor,
          ),
          child: _buildBody(context),
        ),
      ),
    );
  }

  BlocProvider<LoginCubit> _buildBody(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isKeyboardOpen = (MediaQuery.of(context).viewInsets.bottom > 0);
    return BlocProvider<LoginCubit>(
      create: (_) => serviceLocator<LoginCubit>(),
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(defaultPagePadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildHeader(isKeyboardOpen),
              const Padding(
                padding: EdgeInsets.only(top: 14),
              ),
              SizedBox(
                width: double.infinity,
                height: 36,
                child: _buildLoginButton(),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 14),
              ),
              ElevatedButton(
                onPressed: _authenticate,
                child: const Text('Biometric Login'),
              ),
              Text("Current State: $authorized"),
              const Padding(
                padding: EdgeInsets.only(top: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isKeyboardOpen) {
    if (!isKeyboardOpen) {
      return Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 74),
          ),
          const SizedBox(
            width: 100,
            height: 100,
            child: Icon(
              Icons.login,
              size: 100,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Text(
            "Login",
            style: CustomTheme.mainTheme.textTheme.subtitle1,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 14),
          ),
        ],
      );
    }
    return const Padding(
      padding: EdgeInsets.only(top: 74),
    );
  }

  BlocConsumer _buildLoginButton() {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoggedState) {
          navAndFinish(
              context,
              HomePage(
                name: state.login.user.username,
              ));
        }

        if (state is ErrorState) {
          _snackBar!.showSnackBar(text: state.message);
        }
      },
      builder: (context, state) {
        if (state is ErrorState) {
          return ElevatedButton(
            onPressed: () {
              context.read<LoginCubit>().signInUser(
                    email: 'hashish',
                    password: 'hashish@2018',
                  );
            },
            child: const Text('Login With Email & Password'),
          );
        } else if (state is LoadingState) {
          return ElevatedButton(
            onPressed: () {},
            child: const CircularProgressIndicator(
              color: CustomColor.white,
            ),
          );
        } else {
          return ElevatedButton(
            onPressed: () {
              context.read<LoginCubit>().signInUser(
                    email: 'hashish',
                    password: 'hashish@2018',
                  );
            },
            child: const Text('Login With Email & Password'),
          );
        }
      },
    );
  }
}
