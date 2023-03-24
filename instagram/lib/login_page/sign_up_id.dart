import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/login_page/sign_up_pw.dart';

class SignUpId extends StatelessWidget {
  const SignUpId({super.key});

  @override
  Widget build(BuildContext context) {
    String id = '';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Center(
          child: Column(
            children: [
              Text(
                '사용자 이름 선택',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
              ),
              Text(
                '나중에 언제든지 변경할 수 있습니다.',
                style: TextStyle(color: Colors.grey, fontSize: 13.0),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 55.0,
                child: TextFormField(
                  onChanged: (value) {
                    id = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp('[a-zA-Z0-9_@.]'),
                        allow: true)
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '사용자 이름',
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        backgroundColor: Colors.blue[700],
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SignUpPw(id: id),
                          ),
                        );
                      },
                      child: Text(
                        '다음',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
