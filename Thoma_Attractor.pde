float delta_x = 0;
float delta_y = 0;
float Rotate_x = 0;
float Rotate_y = 0;
float Scale = 85;
float rotating_speed = 1;
float scale_speed = 1;
boolean animation_rotate = true;
boolean show_axis = false;
float animation_theta_x = 0.005;
float animation_theta_y = 0.005;


void adjust_xyz() {
  translate(width/2, height/2);
  if(animation_rotate){
    Rotate_x = Rotate_x + animation_theta_x;
    Rotate_y = Rotate_y + animation_theta_y;
  }
  rotateX(Rotate_x * rotating_speed);
  rotateZ(Rotate_y * rotating_speed);
}
void mousePressed() {
  //ursor(HAND);
  delta_x = map(mouseY - height/2, 0, height, PI/2, -PI/2) - Rotate_x;
  delta_y = map(mouseX -  width/2, 0, width, PI/2, -PI/2) - Rotate_y;
}
void mouseReleased(){
  //cursor(ARROW);
}
void mouseDragged() {
  Rotate_x = map(mouseY - height/2, 0, height, PI/2, -PI/2) - delta_x;
  Rotate_y = map(mouseX -  width/2, 0, width, PI/2, -PI/2) - delta_y;
}

void mouseWheel(MouseEvent event) {
  float speed = 0.001;
  float scroll = event.getCount();
  if (Scale<0) {
    Scale=0;
  };
  Scale = Scale + abs(scroll) * scroll * speed;
}

void axis(float axis_len) {
  strokeWeight(1);
  colorMode(RGB, 255);
  textSize(15);
  // x-axis
  stroke(255, 0, 0);text("x", axis_len, 0, 0);line(0, 0, 0, axis_len, 0, 0);
  // y-axis
  stroke(0, 255, 0);text("y", 0, axis_len, 0);line(0, 0, 0, 0, axis_len, 0);
  // z-axis
  stroke(0, 0, 255);text("z", 0, 0, axis_len);line(0, 0, 0, 0, 0, axis_len);
}

void show_Rotating_degree() {
  var theta_x = round((Rotate_x/PI * 180)%360);
  var theta_y = round((Rotate_y/PI * 180)%360);
  var angle = "Rotating degree ("+ str(theta_x) +"° ,"+ str(theta_y) +"° )";
  text(angle, 20, 40);
}
void show_zoom_scale() {
  float Scale_round = round(Scale*100);
  Scale_round = Scale_round/100;
  var show_Scale = "zoom scale : " + str(Scale_round);
  text(show_Scale, 20, 60);
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
  if(show_axis){axis(100);}
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

void show_information(){
  textSize(12);
  fill(100);
  text("press q : change the value of b",30,100);
  text("press r : rotation",30,115);
  text("press s : Save the Frame(png)",30,130);
  text("press esc : exit",30,145);
  textSize(16);
  fill(255);
}



void Thoma_Attractor_plot(int N,float x0, float y0,float z0, float b){
  float dt = 0.1;
  float l=0;
  float lm=0;
  float[] x_arr = new float[2];
  float[] y_arr = new float[2];
  float[] z_arr = new float[2];
  float x = x0;//initial value
  float y = y0;//initial value
  float z = z0;//initial value
  
  x_arr[0] = x;
  x_arr[1] = x;
  y_arr[0] = y;
  y_arr[1] = y;
  z_arr[0] = z;
  z_arr[1] = z;
  
  for(int i=0;i<N;i++){
    x = x + dt * ( sin(y) - b * x );
    y = y + dt * ( sin(z) - b * y ) ;
    z = z + dt * ( sin(x) - b * z );
    //------------------------------------------------
    x_arr = append(x_arr, x);
    y_arr = append(y_arr, y);
    z_arr = append(z_arr, z);
  }
  colorMode(HSB,1,1,1);
  strokeWeight(1.2/Scale);
  for (int i=0; i<N; i++) {
    l = abs(x_arr[i+1]-x_arr[i]) + abs(y_arr[i+1]-y_arr[i]) + abs(z_arr[i+1]-z_arr[i]);
    if(l>lm){lm=l;};
    float c = l/lm;
    stroke(0.7 -0.2 * c,1,1);
    line(x_arr[i], y_arr[i], z_arr[i],x_arr[i+1], y_arr[i+1], z_arr[i+1]);
  }
}


void keyPressed() {
  //press q 
  if(keyCode==81 | keyCode==32){
    if(change_b){change_b = false;}
    else{change_b = true;}
  }
  //press c 
  if(keyCode==83){
    saveFrame("output/image####.png");
  }
  //press r
  if(keyCode==82){
    if(animation_rotate){animation_rotate = false;}
    else{animation_rotate = true;}
  }
  //press right arrow
  if(keyCode==39){
    b = b + 0.05;
  }
  //press left arrow
  if(keyCode==37){
     b = b - 0.05;
  }
  // press 0
  if(keyCode==48){
     Rotate_x = 0;
     Rotate_y = 0;
  }
  // press 65
  if(keyCode==65){
     if(show_axis){show_axis = false;}
     else{show_axis = true;}
  }
  println("Press the key board : "+keyCode);
}


// -----------------------------------------------------------------------------------------------------------------------------------------------------

void setup() {
  fullScreen(P3D);
  //size(600, 600, P3D);
  rectMode(CENTER);
  pixelDensity(2);
}
boolean change_b = true;
int n = 5000;
float x0 = 1;
float y0 = -1;
float z0 = -0.2;
float b = 0.095;
void draw() {
  if(change_b){b = b +0.00001;}
  colorMode(RGB, 255);
  background(0);
  text("b = "+b,20,80);
  show_information();
  my_3D_default();
  
  
  Thoma_Attractor_plot(n,x0,y0,z0,b);
  //Thoma_Attractor_plot(n,x0+0.1,y0,z0,b);
  Thoma_Attractor_plot(n,-x0,-y0,-z0,b);
  //Thoma_Attractor_plot(n,-x0-0.1,-y0,-z0,b);
  
}
