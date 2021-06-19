import 'package:add_user/src/models/user.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _form1 = GlobalKey<FormState>();
  final _form2 = GlobalKey<FormState>();

  bool _proceed = false;
  bool _isComplete = false;
  bool _showResult = false;
  String? order;

  int _totalUsers = 0;
  List<User> userList = [];

  String _name = '';
  String _email = '';
  int _age = 0;

  void _setTotalUsers(value) {
    print('value: $value');
    setState(() {
      if (value == '') {
        _totalUsers = 0;
      } else {
        _totalUsers = int.parse(value);
      }
    });
    print('totalUsers: $_totalUsers');
  }

  void _onConfirm() {
    FocusScope.of(context).unfocus();

    final valid = _form1.currentState!.validate();
    if (!valid) {
      return;
    }

    setState(() {
      _proceed = true;
    });
  }

  void _next() {
    FocusScope.of(context).unfocus();

    final valid = _form2.currentState!.validate();
    if (!valid) {
      return;
    }

    if (userList.length == _totalUsers) {
      return;
    }

    User user = User(
      name: _name,
      email: _email,
      age: _age,
      id: userList.length + 1,
    );

    userList.add(user);

    print(userList);

    _form2.currentState!.reset();

    if (userList.length == _totalUsers) {
      setState(() {
        _isComplete = true;
      });
    }
  }

  void _ascendingSelected() {
    for (var i = 0; i < userList.length; i++) {
      userList.sort((a, b) => a.age!.compareTo(b.age!));
    }
    print('sorted List: $userList');

    setState(() {
      order = 'Ascending order';
      _showResult = true;
    });
  }

  void _descendingSelected() {
    for (var i = 0; i < userList.length; i++) {
      userList.sort((b, a) => a.age!.compareTo(b.age!));
    }
    print('sorted List: $userList');

    setState(() {
      order = 'Descending order';
      _showResult = true;
    });
  }

  void _alphabeticalSelected() {
    for (var i = 0; i < userList.length; i++) {
      userList.sort((a, b) => a.name!.compareTo(b.name!));
    }
    print('sorted List: $userList');

    setState(() {
      order = 'Alphabetical order';
      _showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Users'),
        ),
        body: SafeArea(
          child: !_showResult
              ? Center(
                  child: !_isComplete
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[100],
                              ),
                              child: !_proceed
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'How many entries do you want to make?',
                                          style: TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                        if (_totalUsers != 0)
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(_totalUsers.toString(),
                                                style: TextStyle(fontSize: 24)),
                                          ),
                                        Form(
                                          key: _form1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                _setTotalUsers(value);
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Enter some value';
                                                }
                                                return null;
                                              },
                                              style: TextStyle(fontSize: 18),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            _onConfirm();
                                          },
                                          child: Text(
                                            'Confirm',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                Size(double.infinity, 50),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            elevation: 0,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            'Enter Details of user ${userList.length + 1}',
                                            style: TextStyle(fontSize: 20)),
                                        Form(
                                          key: _form2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                  decoration: InputDecoration(
                                                      labelText: 'Name'),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _name = value;
                                                    });
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter name';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(height: 20),
                                                TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _email = value;
                                                    });
                                                  },
                                                  validator: (value) {
                                                    bool emailValid = RegExp(
                                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(
                                                            value.toString());

                                                    if (value!.isEmpty) {
                                                      return 'Enter email';
                                                    }
                                                    if (!emailValid) {
                                                      return 'Enter Valid Email';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: 'Email'),
                                                ),
                                                SizedBox(height: 20),
                                                TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      labelText: 'Age'),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value == '') {
                                                        _age = 0;
                                                      } else {
                                                        _age = int.parse(value);
                                                      }
                                                    });
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter age';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(height: 40),
                                                ElevatedButton(
                                                  onPressed: _next,
                                                  child: Text(
                                                    'Next',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    minimumSize: Size(
                                                        double.infinity, 50),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                    elevation: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue[100],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Sort by?',
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    _alphabeticalSelected();
                                  },
                                  child: Text(
                                    'Alphabetical order',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 0,
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    _ascendingSelected();
                                  },
                                  child: Text(
                                    'Ascending order (age)',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 0,
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    _descendingSelected();
                                  },
                                  child: Text(
                                    'Descending order (age)',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            order.toString(),
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: userList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue[100],
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Name: ${userList[index].name}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        'Email: ${userList[index].email}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        'Age: ${userList[index].age}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        'Id: ${userList[index].id}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
