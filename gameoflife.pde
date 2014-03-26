// tamaño de celdas
int tamanoCeldas = 10;

// probabilidad de comenzar una celda viva
double vivir = 50;

//variables para el tiempo
int intervalo = 200;
int tiempo = 0;

// Colores para celdas
color vivo = color(0, 200, 0);
color muerto = color(0);

// Array de celdas
float[][] cells;
float[][] cells2;

void setup() {
  size (400, 300);

  // Instantiate arrays 
  cells = new float[width/tamanoCeldas][height/tamanoCeldas];
  cells2 = new float[width/tamanoCeldas][height/tamanoCeldas];

  // This stroke will draw the background grid
  stroke(48);

  // Initialization of cells
  for (int x=0; x<width/tamanoCeldas; x++) {
    for (int y=0; y<height/tamanoCeldas; y++) {
      float estado = random (100);
      if (estado > vivir) { 
        estado = 0;
      }
      else {
        estado = 1;
      }
      cells[x][y] = estado; // guarda el estado de cada celda
    }
  }
}

void draw() {

  //Dibuja la Grilla o malla
  for (int x=0; x<width/tamanoCeldas; x++) {
    for (int y=0; y<height/tamanoCeldas; y++) {
      if (cells[x][y]==1) {
        fill(vivo); // si esta vivo
      }
      else {
        fill(muerto); // si esta muerto
      }
      rect (x*tamanoCeldas, y*tamanoCeldas, tamanoCeldas, tamanoCeldas);
    }
  }
  // Iterate if timer ticks
  if (millis()-tiempo>intervalo) {
      iteration();
      tiempo = millis();
  }
} 

void iteration(){
  
  for (int x=0; x<width/tamanoCeldas; x++) {
    for (int y=0; y<height/tamanoCeldas; y++) {
      cells2[x][y] = cells[x][y];
    }
  }

  for(int x=0; x<width/tamanoCeldas; x++){
    for (int y=0; y<height/tamanoCeldas; y++){
      int vecinos=0;
      for(int vx=x-1; vx<=x+1; vx++){
        for(int vy=y-1; vy<=y+1; vy++){
          if (((vx>=0)&&(vx<width/tamanoCeldas))&&((vy>=0)&&(vy<height/tamanoCeldas))){ //Se asegura que no exista un desbordamiento
            if (!((vx==x)&&(vy==y))) { // Se asegura de que no se tenga a si mismo en cuenta
              if (cells2[vx][vy]==1){
                vecinos++;
              }
            }
          }
        }
      }
      if(cells2[x][y]==1){ //La celda esta viva, hay que matarla si es necesario
        if(vecinos<2 || vecinos>3){
          cells[x][y]=0;  //Muere si tiene menos de 2 o más de 3 vecinos
        }
      } else if(vecinos==3){ //La celda esta muerta, hay que revivirla si es necesario
          cells[x][y]=1; //Sólo vive si tiene 3 vecinos
      }
    }
  }
}










