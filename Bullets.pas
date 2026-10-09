unit bullets;

uses GraphWPF;

type
  patron = class
    posX: real;
    posY: real;
    fname: string;
    isCol: boolean;
    constructor ();
    begin
      posX:=-1000;
      posY:=-1000;
      fname := '';
      isCol:= false;
    end;
    
    constructor(x, y: real; f: string);
    begin
      posX := x;
      posY := y;
      fname := f;
    end;
    
    procedure show;
    begin
      DrawImage(posX, posY,10,10, fname);
    end;
  end;

type
  patrons = auto class
    bullets: list<patron>;
    fname: string;
    speed: real;
    procedure move;
    begin
      foreach var bullet in bullets do
      begin
        bullet.posY -= speed;
      end;
      bullets := bullets.Where(x->x.posy>-10).ToList;
    end;
    
    procedure create(x, y: real);
    begin
      bullets += new patron(x, y, fname);
    end;
    
    procedure show();
    begin
      foreach var bullet in bullets do
      begin
        if bullet.fname <> '' then
           bullet.show;
      end;
    end;
    
  end;

end.