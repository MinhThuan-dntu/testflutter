/*
Chuoi la mot tap hop ki tu UTF-16.
*/

void main(){
  var s1 = 'Vu Minh Thuan';
  var s2 = "VMT";

// chen gia tri cua mot bieu thuc , bien vao trong chuoi: ${...}
double diemtoan = 9.5;
double diemvan = 7.5;
var s3 = 'Xin chao $s1, ban da dat tong diem la: ${diemtoan+diemvan} ';
print (s3); 

// tao ra chuoi nam o nhieu dong 
var s4 = '''
    dong 1 
    dong 2
    dong 3 
 ''';   

 var s5 = """
    dong 1 
    dong 2
    dong 3 
 """;   

 var s6 = 'Day la mot doan \n van ban!';
 print(s6);

 var s7 = r'Day la mot doan \n van ban!'; //raw
 print(s7);

 var s8 = "Chuoi 1 " + "Chuoi 2 ";
 print(s8);

 var s9 = 'Chuoi '
          "nay "
          "la "
          "Mot chuoi ";
  print(s9);

}