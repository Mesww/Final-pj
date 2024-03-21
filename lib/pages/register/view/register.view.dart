import 'package:final_pj/pages/map/map.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/pages/login/widget/widget.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';
import 'package:quickalert/quickalert.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getFormRegister = context.watch<Register_provider>();
    final setFormRegister = context.read<Register_provider>();
    final obscure_password = getFormRegister.get_obscure_password_register();
    final obscure_re_password =
        getFormRegister.get_obscure_re_password_register();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Form(
            key: getFormRegister.get_formkey(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ! Text
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Image.asset(
                        'assets/Mae-Fah-Luang-University-2-768x779.png',
                        width: 100,
                      )),
                  Text(
                    'Register',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'Please enter student id and password',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // !form
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      child: TextFormField(
                        controller: getFormRegister.email_register(),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                            hintStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.person),
                            prefixIconColor: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      child: TextFormField(
                        controller: getFormRegister.get_studentid_register(),
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        onSaved: (String? studentID) =>
                            setFormRegister.set_studentID_register(studentID!),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter stundent id';
                          }
                          return null;
                        },
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                            hintStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            hintText: 'StudentID',
                            prefixIcon: Icon(Icons.person),
                            prefixIconColor: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      child: TextFormField(
                        controller: getFormRegister.get_password_register(),
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (String? password) =>
                            setFormRegister.set__password_register(password!),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        obscureText: obscure_password,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Icon(Icons.key_rounded),
                            prefixIconColor: Theme.of(context).primaryColor,
                            suffixIconColor: Theme.of(context).primaryColor,
                            hintStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            hintText: 'Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setFormRegister
                                      .set_obscure_password(!obscure_password);
                                },
                                icon: Icon(obscure_password
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      child: TextFormField(
                        controller: getFormRegister.get_re_password_register(),
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (String? repassword) => setFormRegister
                            .set__re_password_register(repassword!),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter re-password';
                          } else if (value !=
                              getFormRegister.get_password_register().text) {
                            return 'Password not match';
                          }
                          return null;
                        },
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        obscureText: obscure_re_password,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Icon(Icons.key_rounded),
                            prefixIconColor: Theme.of(context).primaryColor,
                            suffixIconColor: Theme.of(context).primaryColor,
                            hintStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            hintText: 'Re-Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setFormRegister.set_obscure_re_password(
                                      !obscure_re_password);
                                },
                                icon: Icon(obscure_re_password
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // !submit button
                  GestureDetector(
                    onTap: () {
                      if (getFormRegister
                          .get_formkey()
                          .currentState!
                          .validate()) {
                        getFormRegister.get_formkey().currentState!.save();
                        setFormRegister.signupUser(context);
                        getFormRegister.get_formkey().currentState!.reset();

                        // print(getFormRegister.get_studentID_register());
                        // AlertDialog(
                        //     content:
                        //         Text(getFormRegister.get_studentID_register()));
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
