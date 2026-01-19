import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/screens/home.dart';
import 'package:holbegram/screens/signup_screen.dart';
import 'package:holbegram/widgets/text_field.dart';

// Login screen wrapper that accepts controllers from the caller.
class LoginScreen extends StatefulWidget {
  // Controller for the email input, owned by the caller or created by default.
  final TextEditingController emailController;
  // Controller for the password input, owned by the caller or created by default.
  final TextEditingController passwordController;
  // Initial visibility flag for password text; default is true per requirement.
  final bool _passwordVisible;

  LoginScreen({
    super.key,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool passwordVisible = true,
  })  : emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController(),
        _passwordVisible = passwordVisible;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    widget.passwordController.dispose();
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
                      onPressed: () async {
                        // Attempt login and show feedback on success.
                        final String result = await AuthMethode().login(
                          email: widget.emailController.text,
                          password: widget.passwordController.text,
                        );

                        if (!mounted) {
                          return;
                        }

                        if (result == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login')),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Help text section below the login form.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Forgot your login details? '),
                Text(
                  'Get help logging in',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // Spacer placeholder as required by the instructions.
            Flexible(
              flex: 0,
              child: Container(),
            ),
            const SizedBox(height: 24),
            const Divider(thickness: 2),
            // Signup prompt with a highlighted action.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account "),
                  TextButton(
                    onPressed: () {
                      // Navigate to the sign up page.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(218, 226, 37, 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Divider row with a centered OR label.
            Row(
              children: const [
                Flexible(child: Divider(thickness: 2)),
                Text(' OR '),
                Flexible(child: Divider(thickness: 2)),
              ],
            ),
            const SizedBox(height: 10),
            // Google sign-in row with a network image placeholder.
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 8),
                const Text('Sign in with Google'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
