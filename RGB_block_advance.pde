float delta_x = 0;
float delta_y = 0;
float Rotate_x = 0;
float Rotate_y = 0;
float Scale = 1;
float rotating_speed = 1;
float scale_speed = 1;

void adjust_xyz() {translate(width/2, height/2);rotateX(Rotate_x * rotating_speed);rotateZ(Rotate_y * rotating_speed);}
void mousePressed() {delta_x = map(mouseY - height/2, 0, height, PI/2, -PI/2) - Rotate_x;delta_y = map(mouseX -  width/2, 0, width, PI/2, -PI/2) - Rotate_y;}
void mouseDragged() {Rotate_x = map(mouseY - height/2, 0, height, PI/2, -PI/2) - delta_x;Rotate_y = map(mouseX -  width/2, 0, width, PI/2, -PI/2) - delta_y;}
void mouseWheel(MouseEvent event) {float speed = 0.001;if (Scale<0) {Scale=0;};Scale = Scale + event.getCount()*speed;}
void axis(float axis_len) {strokeWeight(1);colorMode(RGB, 255);textSize(15);
  stroke(255, 0, 0);text("R", axis_len, 0, 0);line(0, 0, 0, axis_len, 0, 0);
  stroke(0, 255, 0);text("G", 0, axis_len, 0);line(0, 0, 0, 0, axis_len, 0);
  stroke(0, 0, 255);text("B", 0, 0, axis_len);line(0, 0, 0, 0, 0, axis_len);
}
void show_Rotating_degree() {
  var theta_x = round(Rotate_x/PI * 180);var theta_y = round(Rotate_y/PI * 180);
  var angle = "Rotating degree ("+ str(theta_x) +"° ,"+ str(theta_y) +"° )";text(angle, 10, 20, 0);
}
void show_zoom_scale() {
  float Scale_round = round(Scale*100);Scale_round = Scale_round/100;
  var show_Scale = "zoom scale : " + str(Scale_round);text(show_Scale, 10, 40, 0);
}
void my_3D_default() {
  show_zoom_scale();
  show_Rotating_degree();
  adjust_xyz();
  //axis(300);
  scale(Scale * scale_speed);
}
/*
 1. void adjust_xyz()
 調整三為坐置中，旋轉角度到 (Rotate_x , Rotate_y)
 2. void mousePressed()
 滑鼠按下後，所執行函數
 3. void mouseWheel(MouseEvent event)
 滑鼠滾輪滑動後，所執行函數
 4. void axis()
 顯示座標軸，與 x,y,z 的文字
 5. void show_Rotating_degree()
 在左上角顯示現在所旋轉之角度
 6. void show_zoom_scale()
 在左上角顯示現在所放大之倍數
 -----------------------------------------------------------------------------------------------------------------------------------------------------
 */




void keyPressed() {
  if (keyCode==39) {n = n + 1;}// right arrow
  if (keyCode==37) {n = n - 1;}// left arrow
  if (keyCode==38) {distance = distance + 5;}// up arrow
  if (keyCode==40) {distance = distance - 5;}// down arrow
  if (distance<0) {distance=0;}
  if (distance>BC/n) {distance=BC/n;}
  if (keyCode==76) {STROKE=!STROKE;}// l
  if (keyCode==65) {if(Alpha==0.5){Alpha = 0.1;}else if(Alpha==0.1){Alpha = 1;}else if(Alpha==1){Alpha = 0.5;}}// a
  if (keyCode==66) {if(BACKGRIUND==255){BACKGRIUND=0;}else{BACKGRIUND=255;}}// b
  println(keyCode);
}

void setup() {
  fullScreen(P3D);
  pixelDensity(2);
}


int n = 5;
float distance = 60;
float BC = 300;
boolean STROKE = true;
float Alpha = 1;
float BACKGRIUND = 255;
int[] Ly = {60,80,100,120,140,160,180,200};
void draw() {
  colorMode(RGB, 255);
  background(BACKGRIUND);
  fill(255-BACKGRIUND);
  text("Number of box : "+n+" x "+n+" x "+n+" ("+n*n*n+") ", 10, Ly[0]);
  text("Size : "+distance, 10, Ly[1]);
  text("_____________________________________________", 10, Ly[2]);
  text("Press ▲ or ▼ to adjust the size of small box. ", 10, Ly[3]);
  text("Press ▶ or ◀ to adjust the number of small box. ", 10, Ly[4]);
  text("Press l to toggle the Stroke mode.", 10, Ly[5]);
  text("Press a to toggle the alpha value.", 10, Ly[6]);
  text("Press b to toggle the background color.", 10, Ly[7]);
  my_3D_default();
  colorMode(RGB, 255, 255, 255, 1);
  noStroke();
  if (STROKE) {
    stroke(0.001);
  }
  translate(-BC/2, -BC/2, -BC/2);
  for (var i=0; i<=n; i++) {
    for (var j=0; j<=n; j++) {
      for (var k=0; k<=n; k++) {
        translate(BC*i/n, BC*j/n, BC*k/n);
        fill(255*i/n, 255*j/n, 255*k/n, Alpha);
        box(distance);
        translate(-BC*i/n, -BC*j/n, -BC*k/n);
      }
    }
  }
}
