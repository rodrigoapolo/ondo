int pinoSensorLM35 = A0;// declarando o pino analogico do arduino
float temperatura; // declarando a variavel da temperatura
float max = 27;
float min = 20;

void setup() {
  Serial.begin(9600); // iniciação do arduino
}

void loop() { // código que ira se repetir
  temperatura = (float(analogRead(pinoSensorLM35)) * 5 / (1023)) / 0.01; // formula de conversão para Celsius
  //Serial.print("bananinha 123 temperatura: "); // mostrar texto na tela
  Serial.println(temperatura); // mostrar o valor de temperatura na tela
  delay(1000); // tempo entre cada leitura  
}