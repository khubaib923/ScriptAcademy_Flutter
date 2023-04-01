import 'package:flutter/material.dart';
import '../widgets/message_textfield.dart';
import '../widgets/text_emailfield.dart';
import '../widgets/text_namefield.dart';

class ContactScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: const Text("Contact Us", style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold
        ),),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: heightVariable,
          child: Form(
            child: Builder(
                builder: (context) {
                  return Container(
                    margin: EdgeInsets.only(top: heightVariable/10),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        NameField(controller: nameController, title: "Full Name"),
                        Container(
                            margin: EdgeInsets.only(top: heightVariable/50),
                            child: EmailField(controller: emailController, title: "Email Address")
                        ),
                        Container(
                          margin: EdgeInsets.only(top: heightVariable/50),
                          child: MessageField(controller: messageController, title: "Message"),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: heightVariable/25),
                            height: 50,
                            width: widthVariable,
                            child: !isLoading? ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF6CC51D)),
                                shadowColor: MaterialStateProperty.all<Color>(const Color(0xfff5d8e4)),
                              ),
                              onPressed: (){
                                if(Form.of(context)?.validate() ?? false){
                                  //submit();
                                }
                              },
                              child: const Text(
                                "Send",style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: "Poppins",
                                  color: Colors.white
                              ),
                              ),
                            ): const Center(
                              child: CircularProgressIndicator(),
                            )
                        ),
                      ],
                    ),
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}
