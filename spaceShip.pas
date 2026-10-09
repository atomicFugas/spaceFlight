unit spaceShip;
uses GraphWPF, bullets;

type ship = class
  fname : string;
  mainX, mainY : real;
  changedX, changedY: real;
  width := 32;
  height := 32;
  engineLeft := 'src/engineFire1.png';
  engineMiddle := 'src/engineFire3.png';
  engineRight := 'src/engineFire2.png';
  figCannon := 'src/figFire.png';
  constructor(x,y:real; s: string);
  begin
    fname := s;
    mainX := x;
    mainY := y;
  end;
  
  procedure ShowFire(side: byte);
  begin
    if side = 0 then
     DrawImage(mainX+4, mainY+height-1,5, 32,engineLeft)
    else if side = 1 then
      DrawImage(mainX+width-8,mainY+height-1,5, 32,engineRight)
    else
      begin
      DrawImage(mainX+4, mainY+height-1,4, 30, engineLeft);
      DrawImage(mainX+width-8,mainY+height-1,4, 30,engineRight);
    end;
     DrawImage(mainX+width/2-4, mainY+height,8,20, engineMiddle);
  end;
  
  procedure figFire(figs: patrons);
  begin
    figs.create(mainX+width/2-5,mainY-5);
//    DrawImage(mainX+width/2-1, mainY-5, 5,5,figCannon);
    sleep(10);
  end;
  
  procedure show;
  begin
    DrawImage(mainX, mainY,32,32, fname);
    if changedX > MainX then
    showFire(0)
    else if changedX < MainX  then
      showFire(1)
    else 
      showFire(2);
    mainX := changedX;
  end;
  
end;

end.