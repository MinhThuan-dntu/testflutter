void main(){
   int diemToan = 8;
   int diemVan = 7;
   int tongDiem = 0;
   //Cong diem trung binh mon
   tongDiem+=diemToan;
   tongDiem+=diemVan;
   // Tinh trung binh 
   double diemTB = tongDiem /2;
   //Gan diem dat/ khong dat
   String? ketQua;
   ketQua ??='Chua xet';

   if(diemTB >= 5){
    ketQua = 'Dat';
   }
   print('Diem TB : $diemTB');
   print('Ket qua: $ketQua');

}