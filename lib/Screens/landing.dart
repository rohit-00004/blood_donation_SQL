import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Positioned(
              top: 300,
              right: 1,
              left: 2,
              child: Image.asset('assets/images/home1.jpg')),
          Column(
            children: [
              Container(
                height: sz.height * .4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: sz.height * .03,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => const Register())),
                          child: Container(
                            width: sz.width * .8,
                            height: sz.height * .15,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 83, 144, 250),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    "Enroll \nYourself",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/register.png',
                                      height: 100,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sz.height * .02,
                        ),
                        Container(
                          width: sz.width * .8,
                          height: sz.height * .15,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple),
                            color: Colors.purple,
                            // color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  "Total\nregistrations ",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/count.jpg',
                                    height: 100,
                                  )),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: sz.height * .3,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already registered?',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () => {}
                          // Navigator.of(context).push(
                          // MaterialPageRoute(
                          // builder: ((context) => const Login(person: 'user'))))
                          )
                    ],
                  ),
                  TextButton(
                    child: const Text('Admin login',
                        style: TextStyle(fontSize: 15)),
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: ((context) => const Login(person: 'Admin',))));
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }
}
