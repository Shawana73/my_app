import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Housing Society',
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;
  bool rememberMe = false;

  final TextEditingController cnicController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FCFB),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),

            child: Column(
              children: [

                const SizedBox(height: 60),

                // LOGO
                Container(
                  height: 90,
                  width: 90,

                  decoration: BoxDecoration(
                    color: const Color(0xFF5289AD),
                    borderRadius: BorderRadius.circular(25),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: const Icon(
                    Icons.shield_outlined,
                    color: Colors.white,
                    size: 45,
                  ),
                ),

                const SizedBox(height: 30),

                // HEADING
                Text(
                  "Welcome Back",
                  textAlign: TextAlign.center,

                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF243C4C),
                  ),
                ),

                const SizedBox(height: 10),

                // SUBHEADING
                Text(
                  "Login to access your applicant dashboard",
                  textAlign: TextAlign.center,

                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF698696),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 40),

                // LOGIN CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // CNIC LABEL
                      Text(
                        "CNIC Number",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF243C4C),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // CNIC FIELD
                      TextField(
                        controller: cnicController,
                        keyboardType: TextInputType.number,

                        style: GoogleFonts.poppins(
                          color: const Color(0xFF243C4C),
                          fontSize: 15,
                        ),

                        decoration: InputDecoration(
                          hintText: "35201-1234567-8",

                          hintStyle: GoogleFonts.poppins(
                            color: const Color(0xFFACBCBF),
                            fontSize: 15,
                          ),

                          filled: true,
                          fillColor: const Color(0xFFF4FCFB),

                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: Color(0xFFACBCBF),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: Color(0xFF5289AD),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // PASSWORD LABEL
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF243C4C),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // PASSWORD FIELD
                      TextField(
                        controller: passwordController,
                        obscureText: isPasswordHidden,

                        style: GoogleFonts.poppins(
                          color: const Color(0xFF243C4C),
                          fontSize: 15,
                        ),

                        decoration: InputDecoration(
                          hintText: "Enter your password",

                          hintStyle: GoogleFonts.poppins(
                            color: const Color(0xFFACBCBF),
                            fontSize: 15,
                          ),

                          filled: true,
                          fillColor: const Color(0xFFF4FCFB),

                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),

                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordHidden = !isPasswordHidden;
                              });
                            },

                            icon: Icon(
                              isPasswordHidden
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF698696),
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: Color(0xFFACBCBF),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: Color(0xFF5289AD),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // REMEMBER + FORGOT
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runSpacing: 10,

                        children: [

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Checkbox(
                                value: rememberMe,
                                activeColor: const Color(0xFF5289AD),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),

                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                },
                              ),

                              Text(
                                "Remember me",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF698696),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "Forgot password?",
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF5289AD),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // SIGN IN BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 58,

                        child: ElevatedButton(
                          onPressed: () {},

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5289AD),
                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),

                          child: Text(
                            "Sign In",

                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // DIVIDER
                      Row(
                        children: [

                          const Expanded(
                            child: Divider(
                              color: Color(0xFFACBCBF),
                            ),
                          ),

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12),

                            child: Text(
                              "or",

                              style: GoogleFonts.poppins(
                                color: const Color(0xFF698696),
                                fontSize: 14,
                              ),
                            ),
                          ),

                          const Expanded(
                            child: Divider(
                              color: Color(0xFFACBCBF),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // REGISTER TEXT
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [

                          Text(
                            "Don't have an account? ",
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF698696),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegistrationScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Register Now",
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF5289AD),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // INFO BOX
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF3F8),
                    borderRadius: BorderRadius.circular(18),

                    border: Border.all(
                      color: const Color(0xFFBFD2DE),
                    ),
                  ),

                  child: Text(
                    "Use your registered CNIC number to login and check balloting results",
                    textAlign: TextAlign.center,

                    style: GoogleFonts.poppins(
                      color: const Color(0xFF698696),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

