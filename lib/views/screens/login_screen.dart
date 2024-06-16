import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late final AnimationController _firstController;
  late final AnimationController _secondController;
  late final AnimationController _thirdController;
  late final AnimationController _fourthController;
  late final AnimationController _fifthController;
  late final AnimationController _shakeController;

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormFieldState> _emailState = GlobalKey();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormFieldState> _passwordState = GlobalKey();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _firstController = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _shakeController.forward();
          _secondController.forward();
        }
      });
    _shakeController = AnimationController(vsync: this);
    _secondController = AnimationController(
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _thirdController.forward();
        }
      });
    _thirdController = AnimationController(
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _fourthController.forward();
        }
      });
    _fourthController = AnimationController(
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _fifthController.forward();
        }
      });
    _fifthController = AnimationController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _startAnimation();
    });
  }

  @override
  void dispose() {
    _firstController.dispose();
    _shakeController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();
    _fifthController.dispose();
    super.dispose();
  }

  _resetAnimations() {
    _firstController.reset();
    _shakeController.reset();
    _secondController.reset();
    _thirdController.reset();
    _fourthController.reset();
    _fifthController.reset();
  }

  _startAnimation() {
    _firstController.forward();
  }

  String? _validateEmpty(String? value) {
    if (value?.isEmpty ?? true) {
      return "";
    }
    return null;
  }

  _signin() {
    final validateEmail = _emailState.currentState?.validate() ?? false;
    final validatePassword = _passwordState.currentState?.validate() ?? false;

    if (!validateEmail || !validatePassword) {
      return;
    }

    //TODO: 로그인 구현...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewInsets.bottom -
                  MediaQuery.of(context).padding.top,
              maxHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    _resetAnimations();
                    _startAnimation();
                  },
                  child: Image.asset(
                    "assets/images/img_coding_chef_front.png",
                    width: 120,
                  )
                      .animate(
                        autoPlay: false,
                        controller: _firstController,
                      )
                      .fadeIn(begin: 0)
                      .slideY(begin: -1)
                      .animate(
                        autoPlay: false,
                        controller: _shakeController,
                      )
                      .shake(
                        curve: Curves.decelerate,
                        duration: const Duration(milliseconds: 1000),
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    )
                        .animate(
                          autoPlay: false,
                          controller: _fourthController,
                        )
                        .tint(
                          color: const Color(0xff9c27b0),
                        ),
                  ],
                )
                    .animate(
                      autoPlay: false,
                      controller: _thirdController,
                    )
                    .fadeIn(begin: 0)
                    .slideX(begin: -1),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign in to continue",
                      style: TextStyle(
                        color: Color(0xff616161),
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
                    .animate(
                      autoPlay: false,
                      controller: _thirdController,
                    )
                    .slide(
                      begin: const Offset(1, 0),
                      end: const Offset(0, 0),
                    ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    key: _emailState,
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmpty,
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(height: 0),
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xff9e9e9e),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                )
                    .animate(
                      autoPlay: false,
                      controller: _thirdController,
                    )
                    .slideX(begin: -1),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    key: _passwordState,
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    validator: _validateEmpty,
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(height: 0),
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xff9e9e9e),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                )
                    .animate(
                      autoPlay: false,
                      controller: _thirdController,
                    )
                    .slideX(begin: 1),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white),
                    color: const Color(0xffffb74c),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () => _signin(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 32),
                          child: const Icon(Icons.arrow_forward),
                        )),
                  ),
                )
                    .animate(
                      autoPlay: false,
                      controller: _fourthController,
                    )
                    .fadeIn(begin: 0),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: const Text(
                        "Not a member?",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xff616161),
                          fontSize: 16,
                        ),
                      )
                          .animate(
                            controller: _firstController,
                            autoPlay: false,
                          )
                          .slideX(begin: -1),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: const Text(
                        "Register now",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xff2195f3),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                          .animate(
                            controller: _firstController,
                            autoPlay: false,
                          )
                          .slideX(begin: 1),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "Powered by CodingChef",
                      ),
                    )
                        .animate(
                          autoPlay: false,
                          controller: _secondController,
                        )
                        .slideX(begin: 2),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Image.asset(
                          "assets/images/img_coding_chef_back.png",
                          width: 48,
                          height: 48,
                        )
                            .animate(
                              autoPlay: false,
                              controller: _fifthController,
                            )
                            .custom(
                              begin: 0,
                              end: 0.7,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate,
                              builder: (context, value, child) {
                                return ShaderMask(
                                  shaderCallback: (Rect rect) {
                                    return LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: const [
                                        Colors.white,
                                        Colors.white24,
                                        Colors.white,
                                      ],
                                      stops: [0, value, 1],
                                    ).createShader(rect);
                                  },
                                  child: child,
                                );
                              },
                            ),
                      ),
                    )
                        .animate(
                          autoPlay: false,
                          controller: _firstController,
                        )
                        .slideX(begin: 1),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
