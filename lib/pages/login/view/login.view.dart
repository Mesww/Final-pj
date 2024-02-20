import 'package:final_pj/pages/register/view/view.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/pages/login/widget/widget.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';


class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getFormLogin = context.watch<Form_login>();
    final setFormLogin = context.read<Form_login>();
    final obscure_password = getFormLogin.get_obscure_password();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Form(
            key: getFormLogin.get_formkey(),
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
                    'HELLO',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'Welcome to MFU GEMS CAR',
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
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        onSaved: (String? studentID) =>
                            setFormLogin.set_studentID(studentID!),
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
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (String? password) =>
                            setFormLogin.set__password(password!),
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
                                  setFormLogin.set_obscure_password_login(
                                      !obscure_password);
                                },
                                icon: Icon(obscure_password
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
                      if (getFormLogin.get_formkey().currentState!.validate()) {
                        getFormLogin.get_formkey().currentState!.save();
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
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member ? ',
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          // print('test');
                          // registerModel(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterView()));
                        },
                        child: Text(
                          'Register now',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
