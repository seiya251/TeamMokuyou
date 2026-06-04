int titleX;
int titleY;
int gacha_1_X;
int gacha_1_Y;
int gacha_10_X;
int gacha_10_Y;
int state;
int crystal;
int hikuWindow_X;
int hikuWindow_Y;
int hikanaiWindow_X;
int hikanaiWindow_Y;
int clickWait;
int kaisuu;
int gachaHikuBangou;
int lastChangeTime = 0;
int interval = 2000;
String [] characterNames = {
  "勇者",
  "竜騎士",
  "疾風のコッコ",
  "スライム",
  "黒服",
  "精霊術師",
  "マスクマン",
  "天空の鷹",
  "ニセハナマオウカマキリ"
};
String[] characterExplanation = {
  "世界を救うため、今日も剣を手に旅を続ける",
  "竜の力を宿した鎧をまとい、強敵へ果敢に挑む",
  "誰にも追いつけない速さで大地を駆け抜ける俊足の2羽のニワトリ",
  "弱そうに見えるが、その生態には多くの謎が残されている",
  "任務の内容も素性も一切不明の謎めいた人物",
  "精霊の力を借りて奇跡を起こす神秘の使い手",
  "覆面の下に隠された正体は、いまだ誰も知らない",
  "遥か上空から地上を見渡す孤高の狩人",
  "花に擬態して獲物を待ち構える、美しくも恐ろしい捕食者"
};
import java.util.ArrayList;
ArrayList<Integer> gacha = new ArrayList<Integer>();
int[] result = new int[10];
int[] newCharacte =new int[9];
PImage[] characterImages = new PImage[9];
void setup() {
 characterImages[0] = loadImage("0.png");
 characterImages[1] = loadImage("1.png");
 characterImages[2] = loadImage("2.png");
 characterImages[3] = loadImage("3.png");
 characterImages[4] = loadImage("4.png");
 characterImages[5] = loadImage("5.png");
 characterImages[6] = loadImage("6.png");
 characterImages[7] = loadImage("7.png");
 characterImages[8] = loadImage("8.png");
 size(800, 500);
 PFont font = createFont("Meiryo", 50);
 textFont(font);
 background(#b8860b);
 state = 1;
 //１はタイトル画面
 // 2は単発確認
 // 3は10連確認
 crystal = 9999999;
 titleX = 150;
 titleY = 100;
 gacha_1_X = width/2-230;
 gacha_1_Y = 300;
 gacha_10_X =width/2+30;
 gacha_10_Y = 300;
 hikuWindow_X = 300;
 hikuWindow_Y = 250;
 hikanaiWindow_X = 300;
 hikanaiWindow_Y = 350;
 clickWait = 0;
 
 int index = 0;
 //竜騎士5 ウルトラレア
 for (int i = 0 ; i< 5; i++){
   gacha.add(1);
   index++;
 };
 //勇者7 レア
 for (int i = 0 ; i< 7; i++){
   gacha.add(0);
   index++;
 };
 //疾風のコッコ7 レア
 for (int i = 0 ; i< 7; i++){
   gacha.add(2);
   index++;
 };
 //精霊術師6 レア
 for (int i = 0 ; i< 6; i++){
   gacha.add(5);
   index++;
 };
 //スライム19 ノーマル
 for (int i = 0 ; i< 19; i++){
   gacha.add(3);
   index++;
 };
 //黒服19 ノーマル
 for (int i = 0 ; i< 19; i++){
   gacha.add(4);
   index++;
 };
 //マスクマン19 ノーマル
 for (int i = 0 ; i< 19; i++){
   gacha.add(6);
   index++;
 };
 //天空の鷹9 ノーマル
 for (int i = 0 ; i< 9; i++){
   gacha.add(7);
   index++;
 };
 //ニセハナマオウカマキリ9 ノーマル
 for (int i = 0 ; i< 9; i++){
   gacha.add(8);
   index++;
 };
 
};


void draw(){
  println("残り"+gacha.size());//確認用
   //background(#b8860b);
  textSize(30);
  //println("state"+state);
  //text("clickWait"+clickWait,20,60);
  //text("kisuu"+kaisuu,20,400);
  //for (int i = 0; i < result.length;i ++){
    //text(result[i],100,100+i*20);
  //};
  //println(millis()-lastChangeTime);
  fill(#ffffff);
  if (state ==1){
    drawTitle();
    clickWait  =  0;
    if (mouseX > gacha_1_X && mouseX < gacha_1_X + 200 && mouseY > gacha_1_Y && mouseY < gacha_1_Y + 80){
      if (mousePressed){
        state = 2;
        delay(60);
        clickWait = 1;
      };
    };
    if (mouseX > gacha_10_X && mouseX < gacha_10_X + 200 && mouseY > gacha_10_Y && mouseY < gacha_10_Y + 80){
      if (mousePressed){
        state = 3;
         delay(60);
        clickWait = 1;
      };
    };
  }; 
  
  if (state == 2){
    drawTitle();
    drawConfirmationWindow();
    textSize(30);
    fill(#ffffff);
    text("キャラガチャを",295,150);
    text("1回引きますか？",290,200);
    drawHikuWindow();
  };
  
  if (state == 3){
    drawTitle();
    drawConfirmationWindow();
    textSize(30);
    fill(#ffffff);
    text("キャラガチャを",295,150);
    text("10回引きますか？",280,200);
    drawHikuWindow();
  };
  
  
  if (state == 2 || state == 3){
     drawYameruWindow();
    if (mouseX >hikanaiWindow_X && mouseX < hikanaiWindow_X + 200 && mouseY > hikanaiWindow_Y && mouseY < hikanaiWindow_Y + 50 && clickWait == 1){
      if (mousePressed){
        state = 1;
        background(#b8860b);
      };
    };
  };
  
  if (state ==1 || state == 2 || state== 3){
    stroke(0);
    fill(#ffffff);
    textSize(30);
    text("クリスタル所持数:"+crystal,400,30);
  };
  
  if (state == 4){ 
    interval = 2000;
          if (millis() - lastChangeTime > interval && state == 4) {
            background(#b8860b);
            state = 1;
          };
       };
  if (state == 5){
    interval = 500;
     drawResult();
       if (millis() - lastChangeTime > interval && state == 5) {
           kaisuu++;
           lastChangeTime = millis();
           if (kaisuu == 10){
             background(#b8860b);
            state = 1;
           };
          };
       };
  
  if (state == 2 || state == 3){
    if (mouseX >hikuWindow_X && mouseX < hikuWindow_X + 200 && mouseY > hikuWindow_Y && mouseY < hikuWindow_Y + 50 && clickWait == 1){
      if (mousePressed){
        if (state ==2 ){
          if (crystal > 99 && gacha.size() >0){
           crystal = crystal - 100;
           kaisuu = 0;
           for (int i =0; i < result.length; i++){
            result[i] = -1;
           };
           gachaHiku();
           kaisuu = 0;
           clickWait = 0;
           lastChangeTime = millis();
           state = 4;
           kaisuu = 0;
           drawResult();
           
           
         };
        };
        if (state ==3 ){
          if ( crystal > 999 && gacha.size()>9){
           crystal = crystal - 1000;
           kaisuu = 0;
           for (int i =0; i < result.length; i++){
            result[i] = -1;
           };
           clickWait = 0;
           state = 5;
           lastChangeTime = millis();
            for (int i = 0 ; i< 10; i++){
              gachaHiku();
            };
           kaisuu = 0;
           };
        };
       
      };
    };
  };
};




void drawTitle(){
  fill(#daa520);
  rect(titleX,titleY,500,60); 
  rect(gacha_1_X,gacha_1_Y,200,80);
  rect(gacha_10_X,gacha_10_Y,200,80);
  fill(#ff4500);
  textSize(50);
  text("キャラガチャ",titleX+100,titleY+50);
  textSize(30);
  text("1回引く！",gacha_1_X+30,gacha_1_Y+50);
  text("10回引く！",gacha_10_X+30,gacha_1_Y+50);
  image(characterImages[0], 280,180,100,120);
  image(characterImages[1], 400,180,100,120);
  textSize(20);
  text("今月のピックアップ！",300,180);
};

void drawConfirmationWindow(){
  fill(#daa520);
  rect(250,80,300,350);
};

void drawHikuWindow(){
  fill(#ffa500);
  rect(hikuWindow_X,hikuWindow_Y,200,70);
  fill(#ff4500);
  if (state == 2 ){
    text("1回引く!!",335,285);
    textSize(20);
    text((crystal)+"→"+(crystal-100),300,310);
  };
  
  if (state ==  3 ){
    text("10回引く!!",330,285);
    textSize(20);
    text((crystal)+"→"+(crystal-1000),300,310);
  };
};

void drawYameruWindow(){
  fill(#ffffff);
  rect(hikanaiWindow_X,hikanaiWindow_Y,200,50);
  textSize(30);
  fill(0);
  text("やめておく",330,385);
};

void gachaHiku(){
  gachaHikuBangou = int (random(gacha.size()));
  result[kaisuu] = gacha.get(gachaHikuBangou);
  gacha.remove(gachaHikuBangou);
  kaisuu ++;
};

void drawResult(){
  noStroke();
  background(#b8860b);
  if (result[kaisuu] == 0){
    fill(#dda0dd);
  };
  if (result[kaisuu] == 1 ||result[kaisuu] == 2 || result[kaisuu] == 3){
    fill(#d4b51d);
  };
  if (result[kaisuu] > 3 && result[kaisuu] < 10 ){
    fill(#dcdcdc);
  };
  rect(230,10,350,480);
  if (result[kaisuu] == 0){
    fill(#9932cc);
  };
  if (result[kaisuu] == 1 ||result[kaisuu] == 2 || result[kaisuu] == 3){
    fill(#857212);
  };
  if (result[kaisuu] > 3 && result[kaisuu] < 10 ){
    fill(#a9a9a9);
  };
  rect(245,30,320,400);
  image(characterImages[result[kaisuu]], 250,35,300,360);
  if (result[kaisuu] == 0){
    fill(#dda0dd);
  };
  if (result[kaisuu] == 1 ||result[kaisuu] == 2 || result[kaisuu] == 3){
    fill(#d4b51d);
  };
  if (result[kaisuu] > 3 && result[kaisuu] < 10 ){
    fill(#dcdcdc);
  };
  rect(230,290,350,170);
  if (result[kaisuu] == 0){
    fill(#da70d6);
    stroke(#ba55d3);
  };
  if (result[kaisuu] == 1 ||result[kaisuu] == 2 || result[kaisuu] == 3){
    fill(#b8860b);
    stroke(#826f12);
  };
  if (result[kaisuu] > 3 && result[kaisuu] < 10 ){
    fill(#c0c0c0);
    stroke(#696969);
  };
  rect(250,300,310,50);
  rect(235,360,340,120);
  
    if (result[kaisuu] == 0){
    fill(#4b0082);
  };
  if (result[kaisuu] == 1 ||result[kaisuu] == 2 || result[kaisuu] == 3){
    fill(#826f12);
  };
  if (result[kaisuu] > 3 && result[kaisuu] < 10 ){
    fill(#696969);
  };
  textSize(25);
  text(characterNames[result[kaisuu]],255,335);
  textSize(20);
  text(characterExplanation[result[kaisuu]],240,390,330,200);
};
