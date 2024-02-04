import 'dart:io';

void main(){
  String input = '';
  do{
    input = getCommand(info: 'Введите строку вида \"8 * 10\": ');
    if(input != 'exit')
      try{
        doOp(input.trim());}
      catch(e){
        stdout.writeln(e.toString());
      }
    else
      stdout.write(input);
  }while(input != 'exit');
}

void noticeErr() {
  stdout.writeln('ERROR');
}

Function select(String char){
  switch(char) {
    case '+':
      return (num a, num b) => a + b;
    case '-':
      return (num a, num b) => a - b;
    case '*':
      return (num a, num b) => a * b;
    case '/':
      return (num a, num b) => a / b;
  }
  return noticeErr;
}

bool checkOp(String comm){
  const a = ['+', '-', '*', '/'];
  var accept = comm.split(' ');
  if(accept.length == 3) {
    var firstN = num.tryParse(accept[0]);
    if(firstN == null)
      return false;
    var sign = accept[1];
    if(!a.contains(sign))
      return false;
    var secondN = num.tryParse(accept[2]);
    if(secondN == null)
      return false;
  }
  return true;
}

void doOp(String command){
  if(checkOp(command) == false){
    noticeErr();
    return;
  }
  else{
    var params = command.split(' ');
    num firstN = num.parse(params[0]);
    num secondN = num.parse(params[2]);

    var op = select(params[1]);
    stdout.write('$command = ' + op(firstN, secondN).toString() + '\n');
  }
}

String getCommand({String info = ''}){
  stdout.write(info);
  String input = stdin.readLineSync()?.trim() ?? 'exit';
  return input;
}
