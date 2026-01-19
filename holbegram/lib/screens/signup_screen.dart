import 'package:flutter/material.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:holbegram/widgets/text_field.dart';

// Sign up screen wrapper that accepts controllers from the caller.
class SignUp extends StatefulWidget {
  // Controller for the email input, owned by the caller or created by default.
  final TextEditingController emailController;
  // Controller for the username input, owned by the caller or created by default.
  final TextEditingController usernameController;
  // Controller for the password input, owned by the caller or created by default.
  final TextEditingController passwordController;
  // Controller for password confirmation input, owned by the caller or created by default.
  final TextEditingController passwordConfirmController;
  // Initial visibility flag for password text; default is true per requirement.
  final bool _passwordVisible;

  SignUp({
    super.key,
    TextEditingController? emailController,
    TextEditingController? usernameController,
    TextEditingController? passwordController,
    TextEditingController? passwordConfirmController,
    bool passwordVisible = true,
  })  : emailController = emailController ?? TextEditingController(),
        usernameController = usernameController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController(),
        passwordConfirmController =
            passwordConfirmController ?? TextEditingController(),
        _passwordVisible = passwordVisible;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Stored locally so UI can toggle password visibility.
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    // Initialize from the widget's default flag.
    _passwordVisible = widget._passwordVisible;
  }

  @override
  void dispose() {
    // Dispose only the controllers passed in, as requested.
    widget.emailController.dispose();
    widget.usernameController.dispose();
    widget.passwordController.dispose();
    widget.passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 28),
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 50,
              ),
            ),
            Image.asset(
              'assets/images/logo.webp',
              width: 80,
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  TextFieldInput(
                    controller: widget.usernameController,
                    ispassword: false,
                    hintText: 'Username',
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: widget.emailController,
                    ispassword: false,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: widget.passwordController,
                    ispassword: !_passwordVisible,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      alignment: Alignment.bottomLeft,
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: widget.passwordConfirmController,
                    ispassword: !_passwordVisible,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      alignment: Alignment.bottomLeft,
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(218, 226, 37, 24),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Have an account '),
                TextButton(
                  onPressed: () {
                    // Navigate to the login page.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(218, 226, 37, 24),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
