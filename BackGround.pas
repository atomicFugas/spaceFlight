unit BackGround;

uses GraphWPF, controls;

type
  layer = class
    fname: string;
    mainX, mainY: real;
    changedX, changedY: real;
    speed : real;
    lvl: byte;
    constructor(x, y, sp: real; l: byte;s: string);
    begin
      mainX := x;
      mainY := y;
      fname := s; 
      speed := sp;
      lvl := l;
    end;
    
    procedure parralax(x, y, lvl: real);
    begin
      changedX := x * 0.1 + mainX;
    end;
    
    procedure show;
    begin
      DrawImage(changedX, mainY, fname);
    end;
    
    procedure move;
    begin
    if mainy > Window.Height then
      mainY := -100;
    mainy += speed;
    end;
  end;
end.