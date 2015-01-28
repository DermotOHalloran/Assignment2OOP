class Button 
{
  PVector pos;
  color textColor, hoverColor;
  float size, tWidth;  //Button base variables
  String text;
 
  Button(String text, PVector pos, float size, color textColor, color hoverColor) 
  {
    this.pos = pos;
    this.textColor = textColor;
    this.hoverColor = hoverColor;  //Additional button variables
    this.size = size;
    this.text = text;
    textSize(size);
    tWidth = textWidth(text);
  

}
  
   boolean containsMouse() { //If mouse is on button
    if (mouseX > pos.x && mouseX < pos.x + tWidth && mouseY > pos.y && mouseY < pos.y + size )
      return true;
    else return false;
  }

    
 
  void draw1(boolean on) 
  {
    textSize(size);
    if (containsMouse()) fill(hoverColor); //Changes button to red whie hovering
    else fill(textColor);
    text(text, pos.x, pos.y + size);
    if (on)
      rect(pos.x, pos.y, tWidth, size);
  }
  

}
