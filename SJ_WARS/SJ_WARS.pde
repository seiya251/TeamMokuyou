Souko souko;
//ステート３関係のやつです
int draggingIndex = -1;
//ドラッグ中のカードを記憶
int totalCards = 200;
boolean[] Dragging = new boolean[totalCards];
float[] cardX = new float [totalCards];
float[] cardY = new float [totalCards];
float[] startX = new float[totalCards];
float[] startY = new float[totalCards];

//編成したカードのデータを保存する関係です
int[] cardData = new int[totalCards];
int[] cardRestDurability = new int[totalCards];
//デッキ編成を２０枚へ
int[] deckSlots = new int[20];
// 倉庫のスクロール位置を記憶します
float scrollY = 0;
//選択されたカードを右画面に表示するためにクリックされたカードを記憶します
int selectedCard = -1;
//ここまでステート３関係のやつです


//PImage img;
PFont font;
int fightState = 1;//戦闘画面の状態(1-初回の5枚ドロー,2-敵のターン,3プレイヤーのターン,4カード選択状態,5一枚ドロー,6ゲームオーバー)
int allState; //全体の画面状態(1-タイトル画面,2-戦闘画面,3-拠点)　
int PL_HP =100;//プレイヤーのHP
int PL_EP =100;//プレイヤーのエネルギー
int PL_HP_MAX = 100;//プレイヤーのHP最大値
int PL_EP_MAX = 100;//プレイヤーのエネルギーの最大値
int scrap = 0;
int EN_HP = 0;
int EN_HP_MAX = 0;
int EN_Num = 0;//現在の敵の種類
int PL_defend = 0;
int PL_total_damage = 0;
//配列allCardsの横行の名前を決めます
final int cardName = 0;//カード名
final int cardType = 1;//カードのタイプ(攻撃や回復など)
final int value = 2;//攻撃や回復などの「値」
final int durability = 3;//カードの耐久力
final int consumption =4; //消費武器エネルギー
final int description = 5;//カードの説明
//要素を追加する際は final int 名前 = 縦の行番目 で追加可能です

String[][] allCards = {
  {"エネルギーソード-01", "攻撃", "10", "5", "5", "敵に10ダメージ与えるエネルギーな剣"},
  {"エネルギーガン-01", "攻撃", "15", "3", "8", "敵に15ダメージ与えるエネルギッシュな銃"},
  {"エネルギーバリア-01", "防御", "20", "3", "10", "エネルギーのバリアで次ターンの敵からの攻撃を-20する！"},
  {"メインエネルギー20", "HP回復", "20", "1", "0", "プレイヤーのエネルギーを20回復"},
  {"武器エネルギー20", "EP回復", "20", "1", "0", "武器のエネルギーを20回復"}
};

final int enemyName = 0; //敵の名前
final int enemyAttack = 1; //敵の攻撃力
final int enemyHP =2; //敵の最初のHP
final int scrap_min = 3;//ドロップするスクラップの最小
final int scrap_max = 4;//ドロップするスクラップの最大
String[][] allEnemy= {
  {"En-01", "5", "30", "10", "30"},
  {"En-02", "10", "20", "5", "40"}
};
class typeDeckCards {
  int cardNum; //allCards内での番号
  int rest_durability ;//カードの残り耐久
}

ArrayList<typeDeckCards> deckCards = new ArrayList<typeDeckCards>();
ArrayList<typeDeckCards> handCards = new ArrayList<typeDeckCards>();

ArrayList<String> battleLog = new ArrayList<String>();

void setup() {
  size(1250, 700);
  //img = loadImage("SJWARS_title_background.jpg");
  allState = 3;
  fightState = 1;//
  background(0);
  font =createFont("Meiryo", 30);
  textFont(font);
  addCards(0, 4);
  addCards(1, 4);
  addCards(2, 4);
  addCards(3, 4);
  addCards(4, 4);

  // ステート３のやつです
  souko = new Souko();
  //編成スロットを全て空にする処理
  for (int slot = 0; slot <20; slot++) {
    deckSlots[slot] = -1;
  }

  int cardCount = 0;
  int boxW = 80;
  int boxH = 80;
  int activeCardW = 55;
  int activeCardH = 70;

  //縦に４０列作ります 5×40 = 200

  for ( int tate = 0; tate < 40; tate++) {
    for ( int yoko = 0; yoko < 5; yoko++) {

      startX[cardCount] = (100 + (yoko * 180)) + (boxW /2) - ( activeCardW / 2);
      startY[cardCount] = (380 + (tate * 100)) + (boxH /2) - ( activeCardH /2);

      cardX[cardCount] = startX[cardCount];
      cardY[cardCount] = startY[cardCount];
      Dragging[cardCount] = false;

      //200枚のカードそれぞれに０－４のカードIDを割り当て
      int cId = cardCount %5;
      cardData[cardCount] = cId;
      //カード毎に残り使用回数を付与
      cardRestDurability[cardCount] = int(allCards[cId][durability]);
      cardCount++;
    }
  }
  //ここまでステート３です
}

void draw() {
  //ここからステート３です

  //image(img,0,0,width,height);//仮で背景表示してません
  if (allState == 3) {
    colorMode(RGB, 255, 255, 255);
    //色を付けました
    background(0, 100, 100);
    fill(0, 50, 100);
    rect(0, 0, 80, 700);
    rect(width-80, 0, 80, 700);



    int cardWidth = 150;
    int cardHeigtht = 65;

    for ( int tate = 0; tate < 4; tate++) {
      for ( int yoko = 0; yoko < 5; yoko++) {
        int slot = tate*5+yoko;
        int targetX = 100 + ( yoko * 180);
        int targetY = 30 + ( tate * 75);

        //色を付けます　主に編成欄
        if (deckSlots[slot] != -1) {
          //編成欄にカードが入っている場合、そのカードと同じ感じで
          colorMode(HSB, 360, 100, 100);
          int cardId = deckSlots[slot];
          fill((cardId * 72) % 360, 60, 95);
        } else {
          //編成欄が空っぽ
          colorMode(RGB, 255, 255, 255);//通常モード
          fill(240);
        }

        stroke(0);
        rect(targetX, targetY, cardWidth, cardHeigtht, 7);

        colorMode(RGB, 255, 255, 255);
        if (deckSlots[slot] != -1) {
          fill(0);
          textSize(11);
          int actualCardId = cardData[deckSlots[slot]];
          text(allCards[actualCardId][cardName], targetX + 8, targetY + cardHeigtht/2 + 5);
        } else {
          fill(130);
          textSize(13);
          text("Slot" + (slot + 1), targetX + 12, targetY + cardHeigtht/2 + 5);
        }
      }
    }

    int boxWidth = 80;
    int boxHeight= 80;
    fill(255);
    for ( int rowY = 380; rowY <= 680; rowY += 100) {
      for ( int x = 100; x < 1000; x += 180) {
        rect ( x, rowY, boxWidth, boxHeight, 7);
      }
    }

    int activeCardW = 55;
    int activeCardH = 70;

    colorMode( HSB, 360, 100, 100);
    for ( int i = 0; i < totalCards; i++) {
      //カードが編成欄に入っているかどうかを調べる
      int assignedSlot = -1;
      for (int slot = 0; slot < 20; slot++) {
        if (deckSlots[slot] == i) {
          assignedSlot = slot;
          break;
        }
      }
      if ( Dragging[i]) {
        cardX[i] = mouseX - (activeCardW/2);
        cardY[i] = mouseY - (activeCardH/2);
      } else {
        //boolean inSlot = false;
        //for (int slot = 0; slot < 20; slot++) {
        if (assignedSlot != -1) {
          int slotYoko = assignedSlot % 5;
          int slotTate = assignedSlot /5;
          cardX[i] = 100 + (slotYoko * 180) + (150/2) - (activeCardW/2);
          cardY[i] = 30 + (slotTate * 75) + (65/2) - (activeCardH/2);
        } else {
          //スロットに入っていない　倉庫になるなら
          cardX[i] = startX[i];
          cardY[i] = startY[i] + scrollY;
        }
      }
      //白い枠も動かそう
      if (assignedSlot == -1) {
        //
        if ( cardY[i] >= 380) {
          colorMode( RGB, 255, 255, 255);
          fill(255);
          stroke(0);
          strokeWeight(1);

          //
          float boxX = cardX[i] - (boxWidth - activeCardW) / 2.0;
          float boxY = cardY[i] - (boxHeight - activeCardH) / 2.0;

          rect ( boxX, boxY, boxWidth, boxHeight, 7);
        }
      }
      //掴んでいなくて、かつ倉庫の境界線を（Y３８０）を越えたら非表示
      if (!Dragging[i] ) {
        //ただし編成欄にはいっているものは上に表示したいのでスロット済みの物は除外
        if (assignedSlot == -1 && cardY[i]  < 380) {

          continue;
        }
      }
      colorMode(HSB, 360, 100, 100);
      int cId = cardData[i];
      fill((cId*72)% 360, 80, 90);
      //選択されているなら　ハイライトする
      if ( i == selectedCard) {
        stroke(60, 100, 100);
        strokeWeight(3);
      } else {
        stroke(0);
        strokeWeight(1);
      }
      rect( cardX[i], cardY[i], activeCardW, activeCardH, 7);
    }

    strokeWeight(1);
    colorMode( RGB, 255, 255, 255);

    //詳細表示欄の関係です
    if (selectedCard != -1) {
      int cId = cardData[selectedCard];
      //int rD = cardRestDurability[selectedCard];

      colorMode(RGB, 255, 255, 255);
      fill(255, 255, 0);
      textSize(20);

      //詳細表示欄の位置はここで変えてね！
      int textX = 1000;
      int textY = 100;

      rect(textX-15, textY-35, 265, 310, 7);

      colorMode(RGB, 255, 255, 255);
      fill(0);
      textSize(20);

      rect(textX-10, textY-30, 255, 300, 7);

      colorMode(RGB, 255, 255, 255);
      fill(255);
      textSize(20);

      text("【選択中のカード】", textX, textY);
      text("名前:" + allCards[cId][cardName], textX, textY + 25);
      text("タイプ:" + allCards[cId][cardType], textX, textY + 50);
      text("効果値:" + allCards[cId][value], textX, textY + 75);
      text("消費EP:" + allCards[cId][consumption], textX, textY + 100);
      text("耐久度:" + cardRestDurability[selectedCard] + "/" + allCards[cId][durability], textX, textY + 125);

      //説明文が長い場合は小さくするか折り返す
      textSize(15);
      text("説明:" + allCards[cId][description], textX, textY + 160, 220, 100);
    }
    if (draggingIndex != -1) {
      colorMode(HSB, 360, 100, 100);
      int cId = cardData[draggingIndex];
      fill((cId * 72) % 360, 80, 90);
      stroke(0);
      rect(cardX[draggingIndex], cardY[draggingIndex], activeCardW, activeCardH, 7);
    }
  }



  // int kirikaeA=0;
  //int kirikaeB=0;
  //int oku=0;

  //      if ( kirikaeA==0 && mousePressed == true &&mouseX<=167 && mouseX>=112 ) {
  //        fill(255, 0, 0);
  //        rect(mouseX, mouseY, 55, 70, 7);
  //        fill(255);
  //        kirikaeB=1;
  //      }
  //      if (kirikaeB==1 && mousePressed == true && mouseY<= 220    && mouseY >=50 && oku == 0 ) {

  //        text("A", 500, 500);
  //        kirikaeB=0;
  //        oku =1;
  //ここまでステート３です

  if (allState == 2) {
    background(0);
    textSize(40);
    text ("プレイヤーエネルギー:"+ PL_HP + "/" + PL_HP_MAX, 30, 50);
    text ("武器エネルギー:"+ PL_EP + "/" + PL_EP_MAX, 30, 90);
    text ("スクラップ所持数:" + scrap, 650, 50);
    text("敵のHP:"+EN_HP+"/"+EN_HP_MAX, 650, 90);
    textSize(30);
    text("デッキ", 30, 130);
    text("テキスト", 30, 520);
    textLog();
    textSize(15);
    for (int i = 0; i<deckCards.size(); i++) {
      typeDeckCards card = deckCards.get(i);
      text(allCards[card.cardNum][cardName]+"耐久度"+ card.rest_durability, 30, 150+ i*16);
    }
    textSize(30);
    text("手札", 350, 130);
    for (int i = 0; i< handCards.size(); i++) {
      typeDeckCards card = handCards.get(i);
      text(i+1 +"-"+ allCards[card.cardNum][cardName]+"[残り耐久度]"+  card.rest_durability + "[必要武器エネルギー]"+allCards[card.cardNum][consumption] + "\n"+allCards[card.cardNum][description], 350, 160 + i*80);
    }
    if (PL_HP >0) {
      if ( fightState == 1) {
        for (int i = 0; i < 5; i++) {
          drawCard();
        }
        fightState = 2;
      }
      if (fightState ==2) {
        if ( EN_HP == 0 || EN_HP < 0) {
          EN_appearance();//新しい敵が出現
          addLog(allEnemy[EN_Num][enemyName]+ "があらわれた!");
          fightState = 3;
          PL_defend = 0;
        } else {
          PL_total_damage = int(allEnemy[EN_Num][enemyAttack]) - PL_defend;
          if (PL_total_damage <= 0) {
            PL_total_damage = 0;
          }
          PL_HP = PL_HP - PL_total_damage;
          addLog(allEnemy[EN_Num][enemyName]+"の攻撃!");
          addLog("プレイヤーは"+PL_total_damage+"ダメージ受けた!");
          if (PL_HP <= 0) {
            fightState = 6;
          } else {
            fightState = 3;
            PL_defend = 0;
          }
        }
      }
      if (fightState == 3) {
        addLog("プレイヤーはどうする？数字キーでカードを選択!");
        fightState = 4;
      }
      if (fightState == 4) {
        //プレイヤーのカード選択状態
      }
      if (fightState == 5) {
        drawCard();
        fightState = 2;
      }
      if (fightState == 6) {
        addLog("やられてしまった....");
      }
    } else {
      fill(255, 0, 0);
      textSize(400);
      text("死", 400, 500);
    }
  }
}



void addCards(int cardId, int count) {//カードを容易に追加できる関数
  for (int i = 0; i< count; i++) {
    typeDeckCards card = new typeDeckCards();
    card.cardNum = cardId;
    card.rest_durability = int(allCards[cardId][durability]);

    deckCards.add(card);
  }
}

void drawCard() {
  if (deckCards.size() == 0)return;
  int index = int (random(deckCards.size()));
  handCards.add(deckCards.get(index));
  deckCards.remove(index);
}

void EN_appearance() {
  int index = int (random(allEnemy.length));
  EN_Num = index;
  EN_HP = int(allEnemy[index][enemyHP]);
  EN_HP_MAX = int(allEnemy[index][enemyHP]);
}

void addLog(String message) {
  battleLog.add(message);
}

void textLog() {
  textSize(20);
  if (battleLog.size() >= 1) {
    text(battleLog.get(battleLog.size()-1), 100, 660);
  }
  if (battleLog.size() >= 2) {
    text(battleLog.get(battleLog.size()-2), 100, 630);
  }
  if (battleLog.size() >= 3) {
    text(battleLog.get(battleLog.size()-3), 100, 600);
  }
  if (battleLog.size() >= 4) {
    text(battleLog.get(battleLog.size()-4), 100, 570);
  }
  if (battleLog.size() >= 5) {
    text(battleLog.get(battleLog.size()-5), 100, 540);
  }
}

void keyPressed() {
  if (fightState == 4) {
    if (key == '1' || key == '2' || key == '3' || key == '4' || key =='5') {
      int index = key - '1';
      if ( index >=  0 && index < handCards.size()) {
        typeDeckCards card = handCards.get(index);
        int cardID = card.cardNum;

        addLog(allCards[cardID][cardName]+"を使った！");
        if ( allCards[cardID][cardType].equals("攻撃")) {
          if ( int(allCards[cardID][consumption]) < PL_EP) {
            addLog(allEnemy[EN_Num][enemyName]+"に"+allCards[cardID][value]+"ダメージ");
            EN_HP = EN_HP - int(allCards[cardID][value]);
            PL_EP = PL_EP - int(allCards[cardID][consumption]);
            if ( EN_HP <= 0) {
              addLog(allEnemy[EN_Num][enemyName]+"をスクラップにしてやった！");
              int get_scrap = int((random(int(allEnemy[EN_Num][scrap_min]), int(allEnemy[EN_Num][scrap_max])+1)));
              scrap = scrap + get_scrap;
            }
            card.rest_durability--;
            if (card.rest_durability <= 0) {
              addLog(allCards[cardID][cardName]+"を使い切った");
            } else {
              deckCards.add(card);
            }
            handCards.remove(index);
            fightState = 5;
          } else {
            addLog("武器エネルギーが不足している！");
            addLog("プレイヤーはどうする？数字キーでカードを選択!");
          }
        }
        if ( allCards[cardID][cardType].equals("防御")) {
          if ( int(allCards[cardID][consumption]) < PL_EP) {
            addLog(allCards[cardID][cardName]+"を展開！");
            PL_defend = int(allCards[cardID][value]);
            card.rest_durability--;
            PL_EP = PL_EP -  int(allCards[cardID][consumption]);
            if (card.rest_durability <= 0) {
              addLog(allCards[cardID][cardName]+"を使い切った");
            } else {
              deckCards.add(card);
            }
            handCards.remove(index);
            fightState = 5;
          } else {
            addLog("武器エネルギーが不足している！");
            addLog("プレイヤーはどうする？数字キーでカードを選択!");
          }
        }
        if ( allCards[cardID][cardType].equals("HP回復")) {
          addLog("プレイヤーエネルギーを"+allCards[cardID][value]+"回復");
          if (PL_HP+int(allCards[cardID][value]) > PL_HP_MAX) {
            PL_HP = PL_HP_MAX;
          } else {
            PL_HP = PL_HP+int(allCards[cardID][value]);
          }
          card.rest_durability--;
          if (card.rest_durability <= 0) {
            addLog(allCards[cardID][cardName]+"を使い切った");
          } else {
            deckCards.add(card);
          }
          handCards.remove(index);
          fightState = 5;
        }
        if ( allCards[cardID][cardType].equals("EP回復")) {
          addLog("武器エネルギーを"+allCards[cardID][value]+"回復");
          if (PL_EP+int(allCards[cardID][value]) > PL_EP_MAX) {
            PL_EP = PL_EP_MAX;
          } else {
            PL_EP = PL_EP+int(allCards[cardID][value]);
          }
          card.rest_durability--;
          if (card.rest_durability <= 0) {
            addLog(allCards[cardID][cardName]+"を使い切った");
          } else {
            deckCards.add(card);
          }
          handCards.remove(index);
          fightState = 5;
        }
      }
    }
  }
}

//ステート３のやつです
void mousePressed() {
  if (allState == 3) {

    int activeCardW = 55;
    int activeCardH = 70;

    boolean cardPressed = false;

    for ( int i = 0; i < totalCards; i++) {
      if (mouseX >= cardX[i] && mouseX <= cardX[i] + activeCardW && mouseY >= cardY[i] && mouseY <= cardY[i] + activeCardH) {
        Dragging[i] = true;
        draggingIndex = i;
        //カードの詳細を表示します
        selectedCard  = i;
        cardPressed = true;
        //// 編成したカードを外したときにデータを消すやつ
        //if (cardY[i] == 125) {

        //for ( int slot = 0; slot < 20; slot++) {
        //  //float sX = 100 + ( slot % 5 * 180);
        //  //float sY = 30 + (slot / 5 * 75) + (65/2) - (activeCardH/2) ;
        ////  if (deckSlots[slot] == i ) {
        ////    deckSlots [slot] = -1;
        //  }
        //}

        break;
      }
    }
    //もしカードが押されてないなら詳細表示欄を消す
    if (!cardPressed) {
      selectedCard = -1;
    }
  }
}



void mouseReleased() {
  if (allState == 3) {
    int activeCardW = 55;
    int activeCardH = 70;

    for ( int i = 0; i< totalCards; i++) {
      if (Dragging[i]) {
        Dragging[i] = false;
        boolean placed = false;

        //このカードのもともとどこのスロットにいたかを確認
        int oldSlot = -1;
        for ( int slot = 0; slot < 20; slot++) {
          if ( deckSlots[slot] == i) {
            oldSlot = slot;
            break;
          }
        }


        //マウスが離されたスロットの判定
        for ( int slot = 0; slot < 20; slot++) {
          int slotYoko = slot % 5;
          int slotTate = slot /5;
          int targetX = 100 + (slotYoko * 180);
          int targetY = 30 + (slotTate * 75);

          if ( mouseX >= targetX && mouseX <= targetX + 150 && mouseY >= targetY && mouseY <= targetY + 65) {
            int HenseiCardIndex = deckSlots[slot];
            if ( HenseiCardIndex != -1 && HenseiCardIndex != i) {
              float newX = 100 + (slotYoko * 180) + (150/2) - (activeCardW/2);
              float newY = 30  + ( slotTate * 75) + (65/2)  - (activeCardH/2);

              for ( int kasanari = 0; kasanari < totalCards; kasanari++ ) {
                if ( i != kasanari && cardX[kasanari] == newX && cardY[kasanari] == newY) {
                  cardX[kasanari]=startX[kasanari];
                  cardY[kasanari] = startY[kasanari];
                }
              }
              cardX[HenseiCardIndex] = startX[HenseiCardIndex];
              cardY[HenseiCardIndex]=  startY[HenseiCardIndex];
            }
            deckSlots[slot] = i;

            //別のスロットにいったなら古い編成データを消す
            if (oldSlot != -1 && oldSlot != slot) {
              deckSlots[oldSlot] = -1;
            }

            placed = true;
            break;
          }
        }

        if (!placed) {
          cardX[i] = startX[i];
          cardY[i] = startY[i] + scrollY;

          if (oldSlot != -1) {
            deckSlots[oldSlot] = -1;
          }
        }
      }
    }
  }
  draggingIndex = -1;
}

//マウスホイールのイベントコードだよ
void mouseWheel(MouseEvent event) {
  if (allState == 3) {
    //下にホイールを動かせば＋、上にすれば－の値をゲット
    float e = event.getCount();
    //スクロールスピードを２５ＰＸに
    scrollY -= e*25;
    //倉庫の２００枚の壁を抜けないようにブレーキを
    scrollY = constrain(scrollY, -3300, 0);
  }
}

//ここまでステート３です
