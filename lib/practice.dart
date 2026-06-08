
void main(){
  print('Welcome to Dart!');
  var listItems=[10,20,30,40,50];
  listItems.add(70);
  listItems.replaceRange(0, 2, [1,2,3]);
  print(listItems.reversed);
  var items=[];
  items.add('Shawana Awan');
  items.addAll(listItems);
  items.insert(3, 'Mujtaba');
  items.insertAll(4, listItems);
  items[3]= 'Mustafa';
  print(items);

 // var myC= myClass();
  //myC.printName("Shawana"); //Function calling
  //
  //
  //myC.printName('Memoona Akram');
  /*print(myC.Add());
}
class myClass{
  //void printName(String name){//declaration
    //print(name);

  int Add(){
    int a=5, b=5;
  int sum= a+b;
  return sum;
}*/
}