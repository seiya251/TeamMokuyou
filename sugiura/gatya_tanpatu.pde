float tanpatu_tate,tanpatu_yoko,tanpatu_left,tanpatu_right,tanpatu_top,tanpatu_bottom;
//それぞれ1回ガチャボタンの縦幅(tate)、横幅(yoko)、左端のx座標(left)、右端のx座標(right)、上辺のy座標(top)、底辺のy座標(bottom)

int stone_kazu;
float stone_tate,stone_yoko,stone_left,stone_right,stone_top,stone_bottom;
//それぞれガチャ石の数(kazu)、ガチャ石表示枠の縦幅(tate)、横幅(yoko)、左端のx座標(left)、右端のx座標(right)、上辺のy座標(top)、底辺のy座標(bottom)

float kyara_tate,kyara_yoko,kyara_left,kyara_right,kyara_top,kyara_bottom;
//それぞれキャラクター表示の縦幅(tate)、横幅(yoko)、左端のx座標(left)、右端のx座標(right)、上辺のy座標(top)、底辺のy座標(bottom)

float kakunin_tate,kakunin_yoko,kakunin_left,kakunin_right,kakunin_top,kakunin_bottom;
//それぞれ1回ガチャボタンを押した後のWORNING画面の縦幅(tate)、横幅(yoko)、左端のx座標(left)、右端のx座標(right)、上辺のy座標(top)、底辺のy座標(bottom)

float gatya_go_tate,gatya_go_yoko,gatya_go_left,gatya_go_right,gatya_go_top,gatya_go_bottom;
//それぞれGOボタンの縦幅(tate)、横幅(yoko)、左端のx座標(left)、右端のx座標(right)、上辺のy座標(top)、底辺のy座標(bottom)

int reset_time;

float time;

int kirikae;
//kirikaeが０の時は

PImage chuuni_N;
PImage kubinasi_R;
PImage dragon_SR;
PImage knight_R;
PImage goblin_N;
PImage slime_N;

void setup(){
  size(1200,600);
  
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  
  tanpatu_tate=100;
  tanpatu_yoko=300;
  tanpatu_left=450;
  tanpatu_right=tanpatu_left+tanpatu_yoko;
  tanpatu_top=400;
  tanpatu_bottom=tanpatu_top+tanpatu_tate;
  
  stone_kazu=1100;
  stone_tate=50;
  stone_yoko=240;
  stone_left=900;
  stone_right=stone_left+stone_yoko;
  stone_top=20;
  stone_bottom=stone_top+stone_tate;
  
  kyara_tate=400;
  kyara_yoko=400;
  kyara_left=400;
  kyara_right=kyara_left+kyara_yoko;
  kyara_top=100;
  kyara_bottom=kyara_top+kyara_tate;
  
  kakunin_tate=400;
  kakunin_yoko=800;
  kakunin_left=200;
  kakunin_right=kakunin_left+kakunin_yoko;
  kakunin_top=100;
  kakunin_bottom=kakunin_top+kakunin_tate;
  
  gatya_go_tate=80;
  gatya_go_yoko=300;
  gatya_go_left=450;
  gatya_go_right=gatya_go_left+gatya_go_yoko;
  gatya_go_bottom=kakunin_bottom-10;
  gatya_go_top=gatya_go_bottom-gatya_go_tate;
  
  kirikae=0;
}

void draw(){
  time=frameCount-reset_time;
  if(kirikae==0){
    background(170,170,170);
    fill(140,230,255);
    rect(tanpatu_left,tanpatu_top,tanpatu_yoko,tanpatu_tate);
    fill(255);
    rect(stone_left,stone_top,stone_yoko,stone_tate);
    PImage stone;
    stone = loadImage("https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhdDg6RMdFKCGkta9r6uuvxk1C8aMp6_6zZRyNVBfvlegEDC4WXxtK6hJC9u8bIAlDYREe4wFHcj1TAoRYvXdfCTMp0PmBpj22SkOVOlfB5R8mFRQoZPIBQrbEJNxVS5KwYZ5AwbcFnuNL_/s800/jewel15_colorful.png");
    image(stone,stone_left,stone_top,stone_tate,stone_tate);
    textSize(stone_tate);
    fill(0);
    text(stone_kazu,stone_left+stone_tate,stone_bottom-5);
    text("単発召喚",tanpatu_left+45,tanpatu_bottom-25);
    fill(255);
  }else if(kirikae==2){
    fill(0,255,140);
    noStroke();
    rect(0,0,time*50,height/3);
    fill(0,255,100);
    rect(-200,height/3,time*50,height/3);
    fill(150,255,0);
    rect(-400,height*2/3,time*50,height/3);
    fill(170);
    rect(-1400,0,time*50,height);
    if(time>53){
      float kyara_N=random(3);
      if(kyara_N<1){
        fill(150,255,0,20);
        ellipse(kyara_left+kyara_yoko/2,kyara_top+kyara_tate/2,kyara_yoko,kyara_yoko);
        fill(0,255,100);
        text("ノーマル",kyara_right+30,kyara_bottom);
        chuuni_N=loadImage("https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjYzuYJQcy3-O6mupAmtosDwjlrGceE-O8zanDF4bG3aBTextNw1zof8h7VsKYQ4aRMre48TsInEDBgvgkVPeSpF4yvzi1CenwXeHWmqmzHEF-kfhguEeI6X8ubeGUrxrZtO7Ew3QiDckw/s800/kids_chuunibyou_girl.png");
        image(chuuni_N,kyara_left,kyara_top,kyara_yoko,kyara_tate);
        kirikae=5;
      }else if(kyara_N<2){
        fill(150,255,0,20);
        ellipse(kyara_left+kyara_yoko/2,kyara_top+kyara_tate/2,kyara_yoko,kyara_yoko);
        fill(0,255,100);
        text("ノーマル",kyara_right+30,kyara_bottom);
        goblin_N=loadImage("https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi6DeTPLvqQD_rm_8vXdMXRuHxAw1SFEMztZXFTZL82bFOTOZrSGoKZTE1YNugxzavWaLZylG340JN1CONxIymKGjv_C60_f-DaWVSJdZrvetxLimDVhXZX_QYomgXOg97E5G8fHEvxWCY/s1600/fantasy_goblin.png");
        image(goblin_N,kyara_left,kyara_top,kyara_yoko,kyara_tate);
        kirikae=5;
      }else{
        fill(150,255,0,20);
        ellipse(kyara_left+kyara_yoko/2,kyara_top+kyara_tate/2,kyara_yoko,kyara_yoko);
        fill(0,255,100);
        text("ノーマル",kyara_right+30,kyara_bottom);
        slime_N=loadImage("https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgPEnaTjO3Bhl_nUapYh7CYQCGcvNFv0KIDbWOPhdQSg-Cz4zh1nHBfxVoTwt-sN2NdeV6sRggpFUgwxWxhILZnT0Dc2N2d3eBz-urwwzpPwdYkfN29HqzmaTAN9DCVdXWbhrz7h870_SYf/s1600/fantasy_game_character_slime.png");
        image(slime_N,kyara_left,kyara_top,kyara_yoko,kyara_tate);
        kirikae=5;
      }
    }else{
    }
    }else if(kirikae==3){
    fill(255,125,0);
    noStroke();
    rect(0,0,time*50,height/3);
    fill(255,65,0);
    rect(-200,height/3,time*50,height/3);
    fill(255,0,120);
    rect(-400,height*2/3,time*50,height/3);
    fill(170);
    rect(-1400,0,time*50,height);
    if(time>53){
      float kyara_R=random(2);
      if(kyara_R<1){
        fill(255,65,0,20);
        ellipse(kyara_left+kyara_yoko/2,kyara_top+kyara_tate/2,kyara_yoko,kyara_yoko);
        fill(255,0,120);
        text("レア",kyara_right+30,kyara_bottom);
        kubinasi_R=loadImage("https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgpH0Y9E9csVoeDb6SLSj5s1WR54Rl4qVsVRfheetjUFFz7u_vMf-yr92woafC9SKoOW9vyQ6_Df2EO_M4PKgub97fQFtyZH7AFJeiNZGVILoc49X2r3beLEEuSmTfbf-MY91o2cUbN4ICe/s800/fantasy_dullahan.png");
        image(kubinasi_R,kyara_left,kyara_top,kyara_yoko,kyara_tate);
        kirikae=5;
      }else{
        fill(255,65,0,20);
        ellipse(kyara_left+kyara_yoko/2,kyara_top+kyara_tate/2,kyara_yoko,kyara_yoko);
        fill(255,0,120);
        text("レア",kyara_right+30,kyara_bottom);
        knight_R=loadImage("https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiS1zlUuc1ijJHKAhDtgzwqXpM3VlU_5EhhWT1NgWauxnjIr8NnfyVO4kYW9YuIcWqyjtDvb9rwIMzcyev_VV6eVBcG0d9NjPHfRY73MnmvnP3Scnz0IxZv8uDc-Qk-hG7gwe0kos9_hBro/s800/fantasy_ryuukishi.png");
        image(knight_R,kyara_left,kyara_top,kyara_yoko,kyara_tate);
        kirikae=5;
      }
    }else{
    }
  }else if(kirikae==4){
    fill(200,0,200);
    noStroke();
    rect(0,0,time*50,height/3);
    fill(135,0,200);
    rect(-200,height/3,time*50,height/3);
    fill(135,0,130);
    rect(-400,height*2/3,time*50,height/3);
    fill(170);
    rect(-1400,0,time*50,height);
    if(time>53){
      fill(200,0,200,20);
      ellipse(kyara_left+kyara_yoko/2,kyara_top+kyara_tate/2,kyara_yoko,kyara_yoko);
      fill(135,0,200);
      text("スーパーレア",kyara_right+30,kyara_bottom);
      dragon_SR=loadImage("https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhWsvL0brkhZn9zU4BpyeOuPORRguZz4iPTopr4phHynEW0DATC9W5j11fWGDlghx_Eysn_5gGSLuBYybC28GRYzsPZB_qpNjFU8qMGpgL_fEi5iUfZv4GnEn_v-sI80WTqOPbSqrg1-3c/s1600/fantasy_dragon.png");
      image(dragon_SR,kyara_left,kyara_top,kyara_yoko,kyara_tate);
      kirikae=5;
    }
  }else if(kirikae==1){
    fill(170,170,170,70);
    rect(0,0,width,height);
    fill(255);
    rect(kakunin_left,kakunin_top,kakunin_yoko,kakunin_tate);
    fill(255,255,0);
    rect(gatya_go_left,gatya_go_top,gatya_go_yoko,gatya_go_tate);
    fill(255,150,150);
    textSize(gatya_go_tate);
    text("WARNING",kakunin_left+200,kakunin_top+gatya_go_tate+10);
    fill(0);
    text("GO",gatya_go_left+100,gatya_go_bottom-10);
    textSize(gatya_go_tate/2);
    text("ガチャ石を使用して召喚を行いますか？",kakunin_left+40,kakunin_top+gatya_go_tate*2+10);
    text(stone_kazu,kakunin_left+200,kakunin_top+gatya_go_tate*3+10);
    text("➡",kakunin_left+400,kakunin_top+gatya_go_tate*3+10);
    text(stone_kazu-100,kakunin_left+500,kakunin_top+gatya_go_tate*3+10);
  }else{
  }
}
  
void mouseClicked(){
  if(kirikae==0 &&mouseX>=tanpatu_left && mouseX<=tanpatu_right && mouseY>=tanpatu_top && mouseY<=tanpatu_bottom){
    kirikae=1;
  }else if(kirikae==1 && mouseX>=gatya_go_left && mouseX<=gatya_go_right && mouseY>=gatya_go_top && mouseY<=gatya_go_bottom && stone_kazu>=100){
    float rare=random(10);
    if(rare<5){
      kirikae=2;
      reset_time=frameCount;
    }else if(rare<9){
      kirikae=3;
      reset_time=frameCount;
      
    }else{
      kirikae=4;
      reset_time=frameCount;
    }
  }else{
  }
}
