import processing.serial.*;

Serial puerto;


/*
La variable estado me sirve para identificar si la señal esta en alto o en bajo
variable axe  sirve para saber el estado anterior y me servira para hacer una comparacion
si el estado anterior es igual a el estado actual dibujaremos la line a continua mientras el estado no cambie.
variable antpos sirve para guardar la posicion de y hacer la linea  Vertical 

*/
int estado = 0;
int axe = 0;
int antpos = 0;

int xPos = 0;
int Hpantalla = 1000; 
int time;
int wait = 1000;
int clock = 1;

void setup(){
  
  time = millis();
  size(Hpantalla, 600); //tamaño de pantalla
  println(Serial.list());
  estado = 0;
  axe = 0;
  puerto = new Serial(this,Serial.list()[0],9600); //lectura del puerto Serial  
  puerto.bufferUntil('\n');
  background(0);
  
  stroke(17,239,17);
  line(0, 400 , Hpantalla, 400); //dividir la pantlla para que mi linea 0 empieze en x = 0 ,y =400
}

 void draw () {

 }
 
 
 //Evento de puerto serial que lee la entrada de arduino
 
 void serialEvent(Serial puerto){
   String inString = puerto.readStringUntil('\n');  //obtener el valor de puerto analogo  0 
   
   if(inString != null){
     inString = trim(inString); 
     float inByte = float(inString); //Convertir el valor dado en flotante 
      //println(inByte);
     stroke(239,224,17);
     int y0 = int(inByte);
     
     //********** Programacion Tiempo  ******************
     
     if(millis() - time >= wait){
       println(clock++);
       stroke(25,252,17);
        line(xPos, 0   , xPos , 600);
        stroke(252,252,252);
        text(clock,xPos,10);
       time = millis();
     }
     
     //********** Programacion Grafica ******************
     stroke(239,224,17);
     if(y0 >300){
       line(xPos, y0-400   , xPos , y0-400);
         if(estado == 1 && axe == 1){
           line(xPos, antpos   , xPos , y0-400);
           antpos = y0 - 400;
       }
       axe = 1;
       estado = 1;
     }else if(y0 < 30){
       line(xPos, y0+400   , xPos ,y0+ 400);
       if(estado == 0 && axe == 0){
         line(xPos, antpos   , xPos , y0+400);
         antpos = y0 + 400;
       }
       axe = 0;
       estado = 0;
    } 
     

     if(xPos >= width){
       xPos = 0;
       background(0); 
       stroke(17,239,17);
        line(0, 400 , Hpantalla, 400);
     }else{
       xPos++;
     }
   }
 }
 
 
 
 





