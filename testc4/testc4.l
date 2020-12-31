%{  #include<stdio.h>
  #include<stdlib.h>
  #include<string.h>
  #include<ctype.h>
  void recover(); 
int value();
struct st
{
  char sm[100];
};
struct st symboltable[100]; 
int sttop=-1;

  struct ac
 {
   char sr;
   int srnum;
 }action[100][50];

struct righthand
{
   char rprod[100];
};

struct prod
{
	int len;
	char lhs[100];
	struct righthand rhs[100];
}production[50];

struct sym
{
   char ss[50];
};

int gotor[100][20];

int stacks[100];
struct sym symbols[100];
int stackstop=-1;
int symbolstop=-1;
int k=0;
int ink;
int errors=0;
int lines=1;
int index, index1;

%}

%%
"main()" ;
[\n] lines++;
"for"   {return 22;}
"while" {return 21;}
"int"   {return 2;}
"float"  {return 3;}
[0-9]([0-9]*) return 6;
"=" return 7;
"+" return 8;
"-" return 9;
"*" return 10;
"/" return 11;
"(" return 12;
")" return 13;
"if" return 14;

"&&" return 15;
"||" return 16;
"{" return 17;
"}" return 18;
"<"|">"|"<="|">=" return 19;
"=="|"!=" return 20;
[a-zA-Z]([a-z_A-Z])* {return value();}
[;]  return 4;
[$] return 5;
. ;

%%
 
main()
{
gotor[2][0]=52;
gotor[49][6]=31;
gotor[33][6]=31;
//gotor[33][0]=16;

//for loop
gotor[71][4]=15;
gotor[71][0]=72;
gotor[72][5]=16;
gotor[72][4]=15;
gotor[72][0]=73;
gotor[75][5]=77;
gotor[73][8]=78;
gotor[79][4]=15;
gotor[79][0]=80;

//while loop
gotor[62][5]=16;
gotor[64][4]=65;
gotor[64][0]=66;
gotor[1][7]=67;

//equal or not equal
gotor[55][5]=56;

//comparing
gotor[53][5]=54;

//if new
gotor[49][0]=2;
gotor[49][4]=15;
gotor[41][4]=15;
gotor[41][0]=2;
gotor[41][6]=31;
gotor[2][6]=52;

//gotor[37][4]=52;

gotor[35][0]=48;
gotor[48][4]=47;
gotor[49][3]=6;
gotor[49][2]=4;
gotor[49][1]=3;
//start recursion

gotor[2][1]=46;
gotor[2][3]=6;
gotor[2][2]=4;
gotor[2][4]=47;
	
//basic
gotor[1][0]=2;
gotor[1][1]=3;
gotor[1][2]=4;
gotor[1][3]=6;
gotor[1][4]=15;
gotor[11][4]=14;

/* add,sub,mul,div */
gotor[1][5]=16;
gotor[11][5]=16;
gotor[19][5]=23;
gotor[20][5]=24;
gotor[21][5]=25;
gotor[22][5]=26;

gotor[27][5]=28;

gotor[1][6]=31;
gotor[33][5]=16;
gotor[35][6]=36;

/* *conflict if **** */
gotor[35][4]=60;
/*  ***** */
gotor[37][5]=38;
gotor[39][5]=40;

gotor[41][7]=42;
gotor[42][4]=45;
gotor[41][3]=6;
gotor[41][2]=4;
gotor[41][1]=3;

production[1].len=1;
strcpy(production[1].lhs,"S");
strcpy(production[1].rhs[1].rprod,"decn");

production[2].len=2;
strcpy(production[2].lhs,"decn");
strcpy(production[2].rhs[1].rprod,"var");
strcpy(production[2].rhs[2].rprod,";");

production[3].len=2;
strcpy(production[3].lhs,"var");
strcpy(production[3].rhs[1].rprod,"dt");
strcpy(production[3].rhs[2].rprod,"IDEN");

production[4].len=1;
strcpy(production[4].lhs,"dt");
strcpy(production[4].rhs[1].rprod,"INT");

production[5].len=1;
strcpy(production[5].lhs,"dt");
strcpy(production[5].rhs[1].rprod,"FLOAT");

production[6].len=1;
strcpy(production[6].lhs,"S");
strcpy(production[6].rhs[1].rprod,"assn");

production[7].len=3;
strcpy(production[7].lhs,"assn");
strcpy(production[7].rhs[1].rprod,"IDEN");
strcpy(production[7].rhs[2].rprod,"=");
strcpy(production[7].rhs[3].rprod,"assn");

/*production[8].len=2;
strcpy(production[8].lhs,"assn");
strcpy(production[8].rhs[1].rprod,"CON");
strcpy(production[8].rhs[2].rprod,";");*/

production[9].len=2;
strcpy(production[9].lhs,"assn");
strcpy(production[9].rhs[1].rprod,"exp");
strcpy(production[9].rhs[2].rprod,";");

production[10].len=3;
strcpy(production[10].lhs,"exp");
strcpy(production[10].rhs[1].rprod,"exp");
strcpy(production[10].rhs[2].rprod,"+");
strcpy(production[10].rhs[3].rprod,"exp");

production[11].len=3;
strcpy(production[11].lhs,"exp");
strcpy(production[11].rhs[1].rprod,"exp");
strcpy(production[11].rhs[2].rprod,"-");
strcpy(production[11].rhs[3].rprod,"exp");

production[12].len=3;
strcpy(production[12].lhs,"exp");
strcpy(production[12].rhs[1].rprod,"exp");
strcpy(production[12].rhs[2].rprod,"*");
strcpy(production[12].rhs[3].rprod,"exp");

production[13].len=3;
strcpy(production[13].lhs,"exp");
strcpy(production[13].rhs[1].rprod,"exp");
strcpy(production[13].rhs[2].rprod,"/");
strcpy(production[13].rhs[3].rprod,"exp");

/*production[10].len=3;
strcpy(production[10].lhs,"temp");
strcpy(production[10].rhs[1].rprod,"exp1");
strcpy(production[10].rhs[2].rprod,"+");
strcpy(production[10].rhs[3].rprod,"exp1");

production[11].len=3;
strcpy(production[11].lhs,"temp");
strcpy(production[11].rhs[1].rprod,"exp1");
strcpy(production[11].rhs[2].rprod,"-");
strcpy(production[11].rhs[3].rprod,"exp1");*/

production[14].len=3;
strcpy(production[14].lhs,"exp");
strcpy(production[14].rhs[1].rprod,"(");
strcpy(production[14].rhs[2].rprod,"exp");
strcpy(production[14].rhs[3].rprod,")");

production[15].len=1;
strcpy(production[15].lhs,"exp");
strcpy(production[15].rhs[1].rprod,"CON");

production[16].len=1;
strcpy(production[16].lhs,"exp");
strcpy(production[16].rhs[1].rprod,"IDEN");

production[17].len=1;
strcpy(production[17].lhs,"S");
strcpy(production[17].rhs[1].rprod,"sel");

production[18].len=5;
strcpy(production[18].lhs,"sel");
strcpy(production[18].rhs[1].rprod,"IF");
strcpy(production[18].rhs[2].rprod,"(");
strcpy(production[18].rhs[3].rprod,"exp");
strcpy(production[18].rhs[4].rprod,")");
strcpy(production[18].rhs[5].rprod,"S");

production[19].len=3;
strcpy(production[19].lhs,"exp");
strcpy(production[19].rhs[1].rprod,"exp");
strcpy(production[19].rhs[2].rprod,"&&");
strcpy(production[19].rhs[3].rprod,"exp");

production[20].len=3;
strcpy(production[20].lhs,"exp");
strcpy(production[20].rhs[1].rprod,"exp");
strcpy(production[20].rhs[2].rprod,"||");
strcpy(production[20].rhs[3].rprod,"exp");

production[21].len=5;
strcpy(production[18].lhs,"sel");
strcpy(production[18].rhs[1].rprod,"IF");
strcpy(production[18].rhs[2].rprod,"(");
strcpy(production[18].rhs[3].rprod,"exp");
strcpy(production[18].rhs[4].rprod,")");
strcpy(production[18].rhs[5].rprod,"exp");

production[22].len=3;
strcpy(production[22].lhs,"S");
strcpy(production[22].rhs[1].rprod,"{");
strcpy(production[22].rhs[2].rprod,"p");
strcpy(production[22].rhs[3].rprod,"}");

production[23].len=3;
strcpy(production[23].lhs,"S");
strcpy(production[23].rhs[1].rprod,"{");
strcpy(production[23].rhs[2].rprod,"S");
strcpy(production[23].rhs[3].rprod,"}");

production[24].len=2;
strcpy(production[24].lhs,"S");
strcpy(production[24].rhs[1].rprod,"S");
strcpy(production[24].rhs[2].rprod,"decn");

production[25].len=2;
strcpy(production[25].lhs,"S");
strcpy(production[25].rhs[1].rprod,"S");
strcpy(production[25].rhs[2].rprod,"assn");

production[26].len=2;
strcpy(production[26].lhs,"S");
strcpy(production[26].rhs[1].rprod,"S");
strcpy(production[26].rhs[2].rprod,"S");

production[27].len=3;
strcpy(production[27].lhs,"exp");
strcpy(production[27].rhs[1].rprod,"exp");
strcpy(production[27].rhs[2].rprod,"COMP");
strcpy(production[27].rhs[3].rprod,"exp");

production[28].len=3;
strcpy(production[28].lhs,"exp");
strcpy(production[28].rhs[1].rprod,"exp");
strcpy(production[28].rhs[2].rprod,"ENQ");
strcpy(production[28].rhs[3].rprod,"exp");

production[29].len=1;
strcpy(production[29].lhs,"S");
strcpy(production[29].rhs[1].rprod,"wloop");

production[30].len=5;
strcpy(production[30].lhs,"wloop");
strcpy(production[30].rhs[1].rprod,"WHILE");
strcpy(production[30].rhs[2].rprod,"(");
strcpy(production[30].rhs[3].rprod,"exp");
strcpy(production[30].rhs[4].rprod,")");
strcpy(production[30].rhs[5].rprod,"S");

production[31].len=7;
strcpy(production[31].lhs,"S");
strcpy(production[31].rhs[1].rprod,"FOR");
strcpy(production[31].rhs[2].rprod,"(");
strcpy(production[31].rhs[3].rprod,"S");
//strcpy(production[31].rhs[4].rprod,";");
strcpy(production[31].rhs[4].rprod,"S");
//strcpy(production[31].rhs[6].rprod,";");
strcpy(production[31].rhs[5].rprod,"incr");
strcpy(production[31].rhs[6].rprod,")");
strcpy(production[31].rhs[7].rprod,"S");

production[32].len=3;
strcpy(production[32].lhs,"incr");
strcpy(production[32].rhs[1].rprod,"IDEN");
strcpy(production[32].rhs[2].rprod,"=");
strcpy(production[32].rhs[3].rprod,"exp");


//start recursion


//basic
action[1][1].sr = 'S';
action[1][1].srnum=8;

action[1][2].sr = 'S';
action[1][2].srnum=9;

action[2][4].sr = 'A';
action[2][4].srnum=-1;

action[4][3].sr = 'S';
action[4][3].srnum=5;

action[6][0].sr = 'S';
action[6][0].srnum=7;

action[3][4].sr = 'R';
action[3][4].srnum=1;

action[3][0].sr = 'R';
action[3][0].srnum=1;

action[5][4].sr = 'R';
action[5][4].srnum=2;

action[5][0].sr = 'R';
action[5][0].srnum=2;

action[7][3].sr = 'R';
action[7][3].srnum=3;

action[8][0].sr = 'R';
action[8][0].srnum=4;

action[9][0].sr = 'R';
action[9][0].srnum=5;

action[1][0].sr = 'S';
action[1][0].srnum=10;

action[11][0].sr = 'S';
action[11][0].srnum=10;

action[10][6].sr = 'S';
action[10][6].srnum=11;

action[10][3].sr = 'R';
action[10][3].srnum=16;

action[15][4].sr = 'R';
action[15][4].srnum=6;

action[14][4].sr = 'R';
action[14][4].srnum=7;

action[11][5].sr = 'S';
action[11][5].srnum=17;

action[16][3].sr='S';
action[16][3].srnum=30;

action[30][4].sr='R';
action[30][4].srnum=9;
   
action[1][5].sr = 'S';
action[1][5].srnum=17;

action[17][3].sr='R';
action[17][3].srnum=15;

/*addition*/

action[16][6].sr = 'R';
action[16][6].srnum=9;

action[16][7].sr = 'S';
action[16][7].srnum=19;

action[19][5].sr = 'S';
action[19][5].srnum=17;
    
action[19][0].sr = 'S';
action[19][0].srnum=10;
    
action[23][3].sr = 'R';
action[23][3].srnum=10;

action[23][12].sr = 'R';
action[23][12].srnum=10;

action[23][7].sr = 'R';
action[23][7].srnum=10;

action[23][8].sr = 'R';
action[23][8].srnum=10;

action[23][9].sr = 'S';
action[23][9].srnum=21;

action[23][10].sr = 'S';
action[23][10].srnum=22; 

action[23][14].sr = 'R';
action[23][14].srnum=10; 

action[23][15].sr = 'R';
action[23][15].srnum=10; 

action[10][7].sr = 'R';
action[10][7].srnum=16;

action[17][7].sr = 'R';
action[17][7].srnum=15;

/*subtraction*/
action[16][8].sr = 'S';
action[16][8].srnum=20;

action[20][0].sr = 'S';
action[20][0].srnum=10;

action[20][5].sr = 'S';
action[20][5].srnum=17;

action[10][8].sr = 'R';
action[10][8].srnum=16;

action[17][8].sr = 'R';
action[17][8].srnum=15;

action[24][3].sr = 'R';
action[24][3].srnum=11;

action[24][12].sr = 'R';
action[24][12].srnum=11;

action[24][7].sr = 'R';
action[24][7].srnum=11;

action[24][8].sr = 'R';
action[24][8].srnum=11;

action[24][9].sr = 'R';
action[24][9].srnum=11;

action[24][10].sr = 'R';
action[24][10].srnum=11;

/*multiplication*/
action[16][9].sr = 'S';
action[16][9].srnum=21;

action[21][0].sr = 'S';
action[21][0].srnum=10;

action[21][5].sr = 'S';
action[21][5].srnum=17;

action[10][9].sr = 'R';
action[10][9].srnum=16;

action[17][9].sr = 'R';
action[17][9].srnum=15;

action[25][3].sr = 'R';
action[25][3].srnum=12;

action[25][12].sr = 'R';
action[25][12].srnum=12;

action[25][7].sr = 'R';
action[25][7].srnum=12;

action[25][8].sr = 'R';
action[25][8].srnum=12;

action[25][9].sr = 'R';
action[25][9].srnum=12;

action[25][10].sr = 'R';
action[25][10].srnum=12;

/* division*/
action[16][10].sr = 'S';
action[16][10].srnum=22;

action[22][0].sr = 'S';
action[22][0].srnum=10;

action[22][5].sr = 'S';
action[22][5].srnum=17;

action[10][10].sr = 'R';
action[10][10].srnum=16;

action[17][10].sr = 'R';
action[17][10].srnum=15;

action[26][3].sr = 'R';
action[26][3].srnum=13;

action[26][12].sr = 'R';
action[26][12].srnum=13;

action[26][7].sr = 'R';
action[26][7].srnum=13;

action[26][8].sr = 'R';
action[26][8].srnum=13;

action[26][9].sr = 'R';
action[26][9].srnum=13;

action[26][10].sr = 'R';
action[26][10].srnum=13;

//logical and
action[16][14].sr = 'S';
action[16][14].srnum=37;

action[28][14].sr = 'S';
action[28][14].srnum=37;

action[37][0].sr = 'S';
action[37][0].srnum=10;

action[37][5].sr = 'S';
action[37][5].srnum=17;

action[37][11].sr = 'S';
action[37][11].srnum=27;

action[10][14].sr = 'R';
action[10][14].srnum=16;

action[17][14].sr = 'R';
action[17][14].srnum=15;

action[38][3].sr = 'R';
action[38][3].srnum=19;

action[38][12].sr = 'R';
action[38][12].srnum=19;

action[38][14].sr = 'R';
action[38][14].srnum=19;

action[38][15].sr = 'R';
action[38][15].srnum=19;

action[38][7].sr = 'S';
action[38][7].srnum=19;

action[38][8].sr = 'S';
action[38][8].srnum=20;

action[38][9].sr = 'S';
action[38][9].srnum=21;

action[38][10].sr = 'S';
action[38][10].srnum=22;

//logical or

action[16][15].sr = 'S';
action[16][15].srnum=39;

action[28][15].sr = 'S';
action[28][15].srnum=39;

action[39][0].sr = 'S';
action[39][0].srnum=10;

action[39][5].sr = 'S';
action[39][5].srnum=17;

action[39][11].sr = 'S';
action[39][11].srnum=27;

action[10][15].sr = 'R';
action[10][15].srnum=16;

action[17][15].sr = 'R';
action[17][15].srnum=15;

action[40][3].sr = 'R';
action[40][3].srnum=20;

action[40][12].sr = 'R';
action[40][12].srnum=20;

action[40][14].sr = 'R';
action[40][14].srnum=20;

action[40][15].sr = 'R';
action[40][15].srnum=20;

action[40][7].sr = 'S';
action[40][7].srnum=19;

action[40][8].sr = 'S';
action[40][8].srnum=20;

action[40][9].sr = 'S';
action[40][9].srnum=21;

action[40][10].sr = 'S';
action[40][10].srnum=22;

/*parenthesis*/
action[1][11].sr = 'S';
action[1][11].srnum=27;

action[27][11].sr = 'S';
action[27][11].srnum=27;

action[27][0].sr = 'S';
action[27][0].srnum=10;

action[27][5].sr = 'S';
action[27][5].srnum=17;

action[19][11].sr = 'S';
action[19][11].srnum=27;

action[20][11].sr = 'S';
action[20][11].srnum=27;

action[21][11].sr = 'S';
action[21][11].srnum=27;

action[22][11].sr = 'S';
action[22][11].srnum=27;

action[28][7].sr = 'S';
action[28][7].srnum=19;

action[28][8].sr = 'S';
action[28][8].srnum=20;

action[28][9].sr = 'S';
action[28][9].srnum=21;

action[28][10].sr = 'S';
action[28][10].srnum=22;

action[28][12].sr = 'S';
action[28][12].srnum=29;

action[11][11].sr = 'S';
action[11][11].srnum=27;

action[29][3].sr = 'R';
action[29][3].srnum=14;

action[29][12].sr = 'R';
action[29][12].srnum=14;

action[29][9].sr = 'R';
action[29][9].srnum=14;

action[29][10].sr = 'R';
action[29][10].srnum=14;

action[29][7].sr = 'R';
action[29][7].srnum=14;

action[29][8].sr = 'R';
action[29][8].srnum=14;

action[29][6].sr = 'R';
action[29][6].srnum=14;

action[29][14].sr = 'R';
action[29][14].srnum=14;

action[29][15].sr = 'R';
action[29][15].srnum=14;

action[10][12].sr = 'R';
action[10][12].srnum=16;

action[17][12].sr = 'R';
action[17][12].srnum=15;

//if statement

action[31][4].sr = 'R';
action[31][4].srnum=17;

action[1][13].sr = 'S';
action[1][13].srnum=32;

action[32][11].sr='S';
action[32][11].srnum=33;

action[16][12].sr='S';
action[16][12].srnum=35;

action[33][5].sr='S';
action[33][5].srnum=16;

action[33][11].sr='S';
action[33][11].srnum=27;

action[33][5].sr='S';
action[33][5].srnum=17;

action[35][0].sr='S';
action[35][0].srnum=10;

action[33][0].sr='S';
action[33][0].srnum=10;

action[36][4].sr = 'R';
action[36][4].srnum=21;

action[35][13].sr = 'S';
action[35][13].srnum=32;

action[60][4].sr = 'R';
action[60][4].srnum=6;

//action[37][0].sr = 'R';
//action[37][0].srnum=6;

//action[37][1].sr = 'R';
//action[37][1].srnum=6;

//action[37][2].sr = 'R';
//action[37][2].srnum=6;

action[48][4].sr = 'R';
action[48][4].srnum=18;

action[48][0].sr = 'S';
action[48][0].srnum=10;

action[35][16].sr = 'S';
action[35][16].srnum=41;

//recursion decn

action[46][4].sr='R';
action[46][4].srnum=24;

action[46][0].sr='R';
action[46][0].srnum=24;

action[46][1].sr='R';
action[46][1].srnum=24;

action[46][2].sr='R';
action[46][2].srnum=24;

action[46][20].sr='R';
action[46][20].srnum=24;

action[46][21].sr='R';
action[46][21].srnum=24;

action[5][1].sr = 'R';
action[5][1].srnum=2;

action[3][1].sr = 'R';
action[3][1].srnum=1;

action[2][1].sr = 'S';
action[2][1].srnum=8;

action[5][2].sr = 'R';
action[5][2].srnum=2;

action[3][2].sr = 'R';
action[3][2].srnum=1;

action[2][2].sr = 'S';
action[2][2].srnum=8;

//recursion assn

action[47][4].sr='R';
action[47][4].srnum=25;

action[47][0].sr='R';
action[47][0].srnum=25;

action[47][1].sr='R';
action[47][1].srnum=25;

action[47][2].sr='R';
action[47][2].srnum=25;

action[47][21].sr='R';
action[47][21].srnum=25;

action[2][0].sr = 'S';
action[2][0].srnum=10;

action[30][0].sr = 'R';
action[30][0].srnum=9;

action[14][0].sr = 'R';
action[14][0].srnum=7;

action[14][1].sr = 'R';
action[14][1].srnum=7;

action[14][2].sr = 'R';
action[14][2].srnum=7;

action[15][0].sr = 'R';
action[15][0].srnum=6;

action[15][1].sr = 'R';
action[15][1].srnum=6;

action[15][2].sr = 'R';
action[15][2].srnum=6;

action[30][2].sr = 'R';
action[30][2].srnum=9;

action[30][1].sr = 'R';
action[30][1].srnum=9;

//curly brackets

action[1][16].sr = 'S';
action[1][16].srnum=49;

action[49][1].sr = 'S';
action[49][1].srnum=8;

action[49][2].sr = 'S';
action[49][2].srnum=9;

action[49][0].sr = 'S';
action[49][0].srnum=10;

action[5][17].sr = 'R';
action[5][17].srnum=2;

action[3][17].sr = 'R';
action[3][17].srnum=1;

action[3][13].sr = 'R';
action[3][13].srnum=1;

action[51][4].sr = 'R';
action[51][4].srnum=23;

action[46][17].sr = 'R';
action[46][17].srnum=24;

action[2][17].sr = 'S';
action[2][17].srnum=51;

action[30][17].sr = 'R';
action[30][17].srnum=9;

action[14][17].sr = 'R';
action[14][17].srnum=7;

action[15][17].sr = 'R';
action[15][17].srnum=6;

action[47][17].sr = 'R';
action[47][17].srnum=25;

action[41][0].sr = 'S';
action[41][0].srnum=10;

action[41][1].sr = 'S';
action[41][1].srnum=8;

action[41][2].sr = 'S';
action[41][2].srnum=9;

action[41][13].sr = 'S';
action[41][13].srnum=32;

action[37][17].sr = 'R';
action[37][17].srnum=6;

action[48][17].sr = 'R';
action[48][17].srnum=18;

action[31][17].sr = 'R';
action[31][17].srnum=17;

action[51][17].sr = 'R';
action[51][17].srnum=23;

action[30][13].sr = 'R';
action[30][13].srnum=9;

action[14][13].sr = 'R';
action[14][13].srnum=7;

action[15][13].sr = 'R';
action[15][13].srnum=6;

action[2][13].sr = 'S';
action[2][13].srnum=32;

action[52][17].sr = 'R';
action[52][17].srnum=26;

action[47][13].sr = 'R';
action[47][13].srnum=25;

action[5][13].sr = 'R';
action[5][13].srnum=2;

action[5][13].sr = 'R';
action[5][13].srnum=2;

action[46][13].sr = 'R';
action[46][13].srnum=24;

action[51][0].sr = 'R';
action[51][0].srnum=23;

action[48][1].sr = 'R';
action[48][1].srnum=18;

action[48][2].sr = 'R';
action[48][2].srnum=23;

action[51][1].sr = 'R';
action[51][1].srnum=23;

action[51][2].sr = 'R';
action[51][2].srnum=23;

action[52][1].sr = 'R';
action[52][1].srnum=26;

action[52][2].sr = 'R';
action[52][2].srnum=26;

action[37][13].sr = 'R';
action[37][13].srnum=6;

action[48][13].sr = 'R';
action[48][13].srnum=18;

action[31][13].sr = 'R';
action[31][13].srnum=17;

action[52][4].sr = 'R';
action[52][4].srnum=26;

//comparison operators
action[10][18].sr = 'R';
action[10][18].srnum=16;

action[17][18].sr = 'R';
action[17][18].srnum=15;

action[16][18].sr = 'S';
action[16][18].srnum=53;

action[53][0].sr = 'S';
action[53][0].srnum=10;

action[53][5].sr = 'S';
action[53][5].srnum=17;

action[54][3].sr = 'R';
action[54][3].srnum=27;

action[54][14].sr = 'R';
action[54][14].srnum=27;

action[54][15].sr = 'R';
action[54][15].srnum=27;

action[54][18].sr = 'R';
action[54][18].srnum=27;

action[54][12].sr = 'R';
action[54][12].srnum=27;

action[54][7].sr = 'S';
action[54][7].srnum=19;

action[54][8].sr = 'S';
action[54][8].srnum=20;

action[54][9].sr = 'S';
action[54][9].srnum=21;

action[54][10].sr = 'S';
action[54][10].srnum=22;

action[28][18].sr = 'S';
action[28][18].srnum=53;

action[29][18].sr = 'R';
action[29][18].srnum=14;

//equal and not equal
action[10][19].sr = 'R';
action[10][19].srnum=16;

action[17][19].sr = 'R';
action[17][19].srnum=15;

action[16][19].sr = 'S';
action[16][19].srnum=55;

action[55][0].sr = 'S';
action[55][0].srnum=10;

action[55][5].sr = 'S';
action[55][5].srnum=17;

action[56][3].sr = 'R';
action[56][3].srnum=28;

action[56][12].sr = 'R';
action[56][12].srnum=28;

action[56][15].sr = 'R';
action[56][15].srnum=28;

action[56][14].sr = 'R';
action[56][14].srnum=28;

action[56][19].sr = 'R';
action[56][19].srnum=28;

//while loop
action[1][20].sr = 'S';
action[1][20].srnum=61;

action[61][11].sr='S';
action[61][11].srnum=62;

action[62][0].sr='S';
action[62][0].srnum=10;

action[63][12].sr='S';
action[63][12].srnum=64;

action[64][0].sr='S';
action[64][0].srnum=10;

action[62][5].sr='S';
action[62][5].srnum=17;

action[65][4].sr='R';
action[65][4].srnum=6;

action[66][4].sr='R';
action[66][4].srnum=30;

action[67][4].sr='R';
action[67][4].srnum=29;

action[35][20].sr = 'S';
action[35][20].srnum=61;

action[30][20].sr = 'R';
action[30][20].srnum=9;

action[14][20].sr = 'R';
action[14][20].srnum=7;

action[15][20].sr = 'R';
action[15][20].srnum=6;

action[2][20].sr = 'S';
action[2][20].srnum=61;

action[60][17].sr = 'R';
action[60][17].srnum=6;
    
//for loop
action[1][21].sr = 'S';
action[1][21].srnum=70;

action[70][11].sr = 'S';
action[70][11].srnum=71;

action[71][0].sr = 'S';
action[71][0].srnum=10;

action[72][0].sr = 'S';
action[72][0].srnum=10;

action[73][0].sr = 'S';
action[73][0].srnum=74;

action[74][6].sr = 'S';
action[74][6].srnum=75;
    
action[75][5].sr = 'S';
action[75][5].srnum=76;

action[75][0].sr = 'S';
action[75][0].srnum=76;

action[76][12].sr = 'R';
action[76][12].srnum=15;

action[77][12].sr = 'R';
action[77][12].srnum=32;

action[78][12].sr = 'S';
action[78][12].srnum=79;

action[79][0].sr = 'S';
action[79][0].srnum=10;

action[80][4].sr = 'R';
action[80][4].srnum=31;

action[76][7].sr = 'S';
action[76][7].srnum=81;

action[76][8].sr = 'S';
action[76][8].srnum=81;

action[81][5].sr = 'S';
action[81][5].srnum=82;

action[81][0].sr = 'S';
action[81][0].srnum=82;

action[82][12].sr = 'R';
action[82][12].srnum=10;

action[79][16].sr = 'S';
action[79][16].srnum=49;

action[49][21].sr = 'S';
action[49][21].srnum=70;

action[80][17].sr = 'R';
action[80][17].srnum=31;

action[30][21].sr = 'R';
action[30][21].srnum=9;

action[14][21].sr = 'R';
action[14][21].srnum=7;

action[15][21].sr = 'R';
action[15][21].srnum=6;

action[2][21].sr = 'S';
action[2][21].srnum=70;

action[51][21].sr = 'R';
action[51][21].srnum=23;

action[48][21].sr = 'R';
action[48][21].srnum=18;

action[52][21].sr = 'R';
action[52][21].srnum=26;

//action[2][21].sr = 'R';
//action[2][21].srnum=26;

action[51][13].sr = 'R';
action[51][13].srnum=23;

action[52][13].sr = 'R';
action[52][13].srnum=26;

action[60][13].sr = 'R';
action[60][13].srnum=6;

action[60][21].sr = 'R';
action[60][21].srnum=6;

action[80][21].sr = 'R';
action[80][21].srnum=31;

action[49][13].sr = 'S';
action[49][13].srnum=32;

action[41][21].sr = 'S';
action[41][21].srnum=70;

action[31][21].sr = 'R';
action[31][21].srnum=17;

action[47][20].sr = 'R';
action[47][20].srnum=25;

action[51][20].sr = 'R';
action[51][20].srnum=23;

action[48][20].sr = 'R';
action[48][20].srnum=18;

action[52][20].sr = 'R';
action[52][20].srnum=26;

action[5][20].sr = 'R';
action[5][20].srnum=2;

action[3][20].sr = 'R';
action[3][20].srnum=1;

action[41][20].sr = 'S';
action[41][20].srnum=32;

action[5][21].sr = 'R';
action[5][21].srnum=2;

action[60][0].sr = 'R';
action[60][0].srnum=6;


    char act;
    int g;
    int iteration=1;
   int length;
   int i;
    int going;
   FILE* fl=fopen("logfile.txt","a");   
   
   yyin=fopen("inout.c","r"); 
   
   stacks[++stackstop]=1;
   ink=yylex();
   

   
   while(1)
   {     
      fprintf(fl,"\nITERATION %d\n",iteration); iteration++;
       
	loo: 
       if(ink==1) index=0;
       else if(ink==2) index=1;
       else if(ink==3) index=2;
       else if(ink==4) index=3;
       else if(ink==5) index=4;
       else if(ink==6) index=5;
       else if(ink==7) index=6;
       else if(ink==8) index=7;
       else if(ink==9) index=8;
       else if(ink==10) index=9;
       else if(ink==11) index=10;
       else if(ink==12) index=11;
       else if(ink==13) index=12;
       else if(ink==14) index=13;
       else if(ink==15) index=14;
       else if(ink==16) index=15;
       else if(ink==17) index=16;
       else if(ink==18) index=17;
       else if(ink==19) index=18;
       else if(ink==20) index=19;
       else if(ink==21) index=20;
       else if(ink==22) index=21;
     
      act=action[stacks[stackstop]][index].sr;
      
   
      g=action[stacks[stackstop]][index].srnum;
    //  printf("%d, %d\n",stacks[stackstop],index);
    
      if(g==0) 
	  {
	  	//printf(" %d",stacks[stackstop]);
	    recover();  continue;
	   // break;
     }
	if(act=='A')
        {
          if(stackstop==1)
         {
          //printf("accepted %d",stacks[stackstop]) ;
	  break; 
         }
 
         else 
            {recover(); ink=yylex(); 
               continue;
                 //break;
             }

        }    
      
    else if(act=='S')
    {  
       int l;
      symbolstop++;
      if(index==0)strcpy(symbols[symbolstop].ss,"IDEN");
      if(index==1)strcpy(symbols[symbolstop].ss,"INT");
      if(index==2)strcpy(symbols[symbolstop].ss,"FLOAT");
      if(index==3)strcpy(symbols[symbolstop].ss,";");
      if(index==4)strcpy(symbols[symbolstop].ss,"$");
      if(index==5)strcpy(symbols[symbolstop].ss,"CON");
      if(index==6)strcpy(symbols[symbolstop].ss,"=");
      if(index==7)strcpy(symbols[symbolstop].ss,"+");
      if(index==8)strcpy(symbols[symbolstop].ss,"-");
      if(index==9)strcpy(symbols[symbolstop].ss,"*");
      if(index==10)strcpy(symbols[symbolstop].ss,"/");
      if(index==11)strcpy(symbols[symbolstop].ss,"(");
      if(index==12)strcpy(symbols[symbolstop].ss,")");
      if(index==13)strcpy(symbols[symbolstop].ss,"IF");
      if(index==14)strcpy(symbols[symbolstop].ss,"&&");
      if(index==15)strcpy(symbols[symbolstop].ss,"||");
      if(index==16)strcpy(symbols[symbolstop].ss,"{");
      if(index==17)strcpy(symbols[symbolstop].ss,"}");
      if(index==18)strcpy(symbols[symbolstop].ss,"COMP");
      if(index==19)strcpy(symbols[symbolstop].ss,"ENQ");
      if(index==20)strcpy(symbols[symbolstop].ss,"WHILE");
      if(index==21)strcpy(symbols[symbolstop].ss,"FOR");

      stacks[++stackstop]=g;
     // printf("action: %d\n",g);       
     
     
     
       fprintf(fl,"\n\n");
      for(l=0;l<=symbolstop;l++)
       fprintf(fl,"symbol %s\n",symbols[l].ss);
      
   
   
       int m;
       fprintf(fl,"\n\n");
      for(m=0;m<=stackstop;m++)
       fprintf(fl,"stacks %d\n",stacks[m]);
      
      fprintf(fl,"action: S %d\n",g); 
    
     ink=yylex();
    
    
    }
  else if(act=='R')
    {   
    	
        int l;
        int m;
        length=production[g].len;
       
	   stackstop=stackstop-length;
	   symbolstop=symbolstop-length;
	   
	   	if(strcmp(production[g].lhs,"S")==0) index1=0;
		if(strcmp(production[g].lhs,"decn")==0) index1=1;
                if(strcmp(production[g].lhs,"var")==0) index1=2;
		if(strcmp(production[g].lhs,"dt")==0) index1=3;
                if(strcmp(production[g].lhs,"assn")==0) index1=4;
                if(strcmp(production[g].lhs,"exp")==0) index1=5;
                if(strcmp(production[g].lhs,"sel")==0) index1=6;
                if(strcmp(production[g].lhs,"wloop")==0) index1=7;
                if(strcmp(production[g].lhs,"incr")==0) index1=8;
              

	    else ;
	    
	         symbolstop++;
	     	 strcpy(symbols[symbolstop].ss,production[g].lhs);
	     
		 
	
	
	going=gotor[stacks[stackstop]][index1];
	stacks[++stackstop]=going;
         
        fprintf(fl,"\n\n");
	 for(l=0;l<=symbolstop;l++)
       fprintf(fl,"symbol %s\n",symbols[l].ss);

        fprintf(fl,"\n\n");
      for(m=0;m<=stackstop;m++)
       fprintf(fl,"stacks %d\n",stacks[m]); 
  
      fprintf(fl,"action: R %d\n",g);
     
  }
	
   if(stackstop==-1 || symbolstop==-1)break;
   	
	
}

if(act=='A' && stackstop==1) {if(errors==0)printf("\nsyntactically correct\n");}

}


void recover()
{ int l,m; ++errors; char a[10];
printf("rejected\n");

 if(strcmp(symbols[symbolstop].ss,"S")==0 || stacks[stackstop]==49)
  {printf("error on line %d: missing }\n", lines); 
    strcpy(symbols[++symbolstop].ss,"}");
    stacks[++stackstop]=51;
  }

 else if(stacks[stackstop]==28)
  {printf("error on line %d: missing ) in expression\n",lines);
   strcpy(symbols[++symbolstop].ss,")");
    stacks[++stackstop]=29;
 }

 else if(strcmp(symbols[symbolstop].ss,"=")==0)
   {printf("error on line %d: missing expression\n",lines);
     strcpy(symbols[++symbolstop].ss,"IDEN");
     stacks[++stackstop]=10;
    }

 else if(stacks[stackstop]==19 || stacks[stackstop]==20 || stacks[stackstop]==21 ||stacks[stackstop]==22 || stacks[stackstop]==37 )
   {printf("error on line %d: missing operand\n",lines);
     strcpy(symbols[++symbolstop].ss,"IDEN");
     stacks[++stackstop]=10;
   }

 else if(strcmp(symbols[symbolstop].ss,"}")==0 || stacks[stackstop]==51)
  {printf("error on line %d: extra }\n", lines); 
     exit(0);
  }
 
 /* else if(stacks[stackstop]==28)
  {printf("error on line %d: missing ) in expression\n",lines);
   strcpy(symbols[++symbolstop].ss,")"); 
    //stacks[++stackstop]=29;
 }*/

 /*else if(stacks[stackstop]==7)
  {printf("error on line %d: missing ; in expression\n",lines);
   strcpy(symbols[++symbolstop].ss,";"); ink=yylex();
    //stacks[++stackstop]=29;
 }*/

else if(stacks[stackstop]==10)
  {printf("error on line %d: missing ; in expression\n",lines);
    while(stacks[stackstop]!=49){stackstop--;symbolstop--;} 
    //stacks[++stackstop]=29;
 
 }
  else exit(0);
}


int value()
{
int i;
int flag=0;
if(sttop==-1)
{
 strcpy(symboltable[++sttop].sm,(char *)yytext);
 //printf("%s",symboltable[sttop].sm);
 return 1;
}

else
{
for(i=0;i<=sttop;i++)
 {
 if(strcmp(yytext,symboltable[i].sm)==0)
   { flag=1;}
 } 
 if(flag==0 &&(strcmp(symbols[symbolstop].ss,"INT")==0 || strcmp(symbols[symbolstop].ss,"FLOAT")==0))
{
 strcpy(symboltable[++sttop].sm,(char *)yytext);
 //printf("%s",symboltable[sttop].sm);
 return 1;
}
else if(flag==1 &&(strcmp(symbols[symbolstop].ss,"INT")==0 || strcmp(symbols[symbolstop].ss,"FLOAT")==0))
 { printf("\nline %d:variable %s redeclared\n",lines,yytext); errors++;
   return 1; 
 }
else if(flag==0)
 {
   printf("\nline %d:variable %s undeclared\n",lines,yytext); errors++;
   return 1; 
 }
}
return 1;
}
yywrap()
{
 }