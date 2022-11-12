float delta_x = 0;
float delta_y = 0;
float Rotate_x = 0;
float Rotate_y = 0;
float Scale = 1;
float rotating_speed = 1;
float scale_speed = 1;

void adjust_xyz() {
  translate(width/2, height/2);
  rotateX(Rotate_x * rotating_speed);
  rotateZ(Rotate_y * rotating_speed);
}
void mousePressed() {
  delta_x = map(mouseY - height/2, 0, height, PI/2, -PI/2) - Rotate_x;
  delta_y = map(mouseX -  width/2, 0, width, PI/2, -PI/2) - Rotate_y;
}
void mouseDragged() {
  Rotate_x = map(mouseY - height/2, 0, height, PI/2, -PI/2) - delta_x;
  Rotate_y = map(mouseX -  width/2, 0, width, PI/2, -PI/2) - delta_y;
}

void mouseWheel(MouseEvent event) {
  float speed = 0.001;
  if (Scale<0) {
    Scale=0;
  };
  Scale = Scale + event.getCount()*speed;
}

void axis(float axis_len) {
  strokeWeight(1);
  colorMode(RGB, 255);
  textSize(15);
  // x-axis
  stroke(255, 0, 0);
  text("R", axis_len, 0, 0);
  line(0, 0, 0, axis_len, 0, 0);
  // y-axis
  stroke(0, 255, 0);
  text("G", 0, axis_len, 0);
  line(0, 0, 0, 0, axis_len, 0);
  // z-axis
  stroke(0, 0, 255);
  text("B", 0, 0, axis_len);
  line(0, 0, 0, 0, 0, axis_len);
}
void show_Rotating_degree() {
  var theta_x = round(Rotate_x/PI * 180);
  var theta_y = round(Rotate_y/PI * 180);
  var angle = "Rotating degree ("+ str(theta_x) +"° ,"+ str(theta_y) +"° )";
  text(angle, 10, 20, 0);
}
void show_zoom_scale() {
  float Scale_round = round(Scale*100);
  Scale_round = Scale_round/100;
  var show_Scale = "zoom scale : " + str(Scale_round);
  text(show_Scale, 10, 40, 0);
}
void ball(float x, float y, float z, float r) {
  translate(x, y, z);
  sphere(r);
  translate(-x, -y, -z);
}
void beam_light(float theta1, float theta2) {
  rotateX(theta1);
  rotateZ(theta2);
  lights();
  rotateZ(-theta2);
  rotateX(-theta1);
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
 7. void ball(x,y,z,r)
 創建一個球，中心在(x,y,z)座標，r為半徑
 8. void beam_light(theta1,theta2)
 生成在(theta1,theta2)角度所輸入之平行光
 -----------------------------------------------------------------------------------------------------------------------------------------------------
 */
 void axis_block(){
  var l = 9;
  var max_l = 30;
  //------------------------------------------------------
  for(var i=0;i<max_l;i++){
    translate(l, 0, 0);
    fill(255*i/max_l,0,0);
    box(l);
  }
  translate(-max_l*l, 0, 0);
  //------------------------------------------------------
  for(var i=0;i<max_l;i++){
    translate(0, l, 0);
    fill(0,255*i/max_l,0);
    box(l);
  }
  translate(0, -max_l*l, 0);
  //------------------------------------------------------
  for(var i=0;i<max_l;i++){
    translate(0, 0, l);
    fill(0,0,255*i/max_l);
    box(l);
  }
  translate(0,0, -max_l*l);
 }
 void rgb_block(){
  var l = 9;
  var max_l = 30;
  for(var i=0;i<max_l;i++){
    translate(l, 0, 0);
    fill(255*i/max_l,0,0);
    box(l);
  }
  translate(-max_l*l, 0, 0);
 }

float l = 9;
float max_l = 20;

void keyPressed(){
  if (keyCode==39){
    //right
    max_l = max_l+1;
  }
  if (keyCode==37){
    //left
    max_l = max_l-1;
  }
}

void setup() {
  fullScreen(P3D);
  //rectMode(CENTER);
  pixelDensity(2);
}


void draw() {
  colorMode(RGB, 255);
  background(255);
  fill(255,255,255);
  rotating_speed = 1;
  scale_speed = 1;
  my_3D_default();
  //beam_light(-PI/4, PI/4);
  colorMode(RGB, 255);
  noStroke();
  //stroke(0.01);
  
  translate(-l*max_l/2,-l*max_l/2,-l*max_l/2);
  for(var i=0;i<max_l;i++){
      for(var j=0;j<max_l;j++){
        for(var k=0;k<max_l;k++){
          translate(l*i,l*j,l*k);
          fill(255*i/max_l,255*j/max_l,255*k/max_l);
          box(l);
          translate(-l*i, -l*j,-l*k);
      }
    }
  }
}
