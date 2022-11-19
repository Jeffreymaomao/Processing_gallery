let viewportWidth = window.innerWidth;
let viewportHeight = window.innerHeight;

function setup() {
    frameRate(60);
    createCanvas(viewportWidth, viewportHeight, WEBGL);
    HowFar = 400
    camera(HowFar, -HowFar, HowFar, 0, 0, 0, 0, 1, 0);
    noStroke()
    colorMode(RGB, 255,255,255,1);
}

var BC = 300;
var n = 3;
var Alpha = 1;
var distance = 50;
var BACKGRIUND = 255;
var STROKE_ornot = true;

function keyReleased() {
    //console.log(keyCode);
    if (keyCode==39) {n = n + 1;}// right arrow
    if (keyCode==37) {n = n - 1;}// left arrow
    if (keyCode==38) {distance = distance + 10;}// up arrow
    if (keyCode==40) {distance = distance - 10;}// down arrow
    if (distance<0) {distance=0;}
    if (distance>BC/n) {distance=BC/n;}
    if (keyCode==76) {STROKE_ornot=!STROKE_ornot;}// l
    if (keyCode==65) {
        if(Alpha==0.5){Alpha = 0.1;}
        else if(Alpha==0.1){Alpha = 1;}
        else if(Alpha==1){Alpha = 0.5;}
    }// a
    if (keyCode==66) {
        if(BACKGRIUND==255){BACKGRIUND=150;}
        else if(BACKGRIUND==150){BACKGRIUND=0;}
        else if(BACKGRIUND==0){BACKGRIUND=255;}
    }// b
}

function draw() {
    background(BACKGRIUND);
    orbitControl(2, 2, 0.05);
    rotateX(PI/2);
    //-----------------
    if (STROKE_ornot) {
        stroke(0);
        strokeWeight(0.5);
    }else{
        noStroke();
    }
    translate(-BC / 2, -BC / 2, -BC / 2);
    for (var i = 0; i <= n; i++) {
        for (var j = 0; j <= n; j++) {
            for (var k = 0; k <= n; k++) {
                translate(BC * i / n, BC * j / n, BC * k / n);
                fill(255 * i / n, 255 * j / n, 255 * k / n, Alpha);
                box(distance);
                translate(-BC * i / n, -BC * j / n, -BC * k / n);
            }
        }
    }
}
