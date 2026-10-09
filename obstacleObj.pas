unit obstacleObj;
uses GraphWpf;

type
  obstacle = class
    fname: string;
    posX: real;
    posY: real;
    objBoom := 'src/boom.png';
    obj: array of string := arr('src/Bigmeteor.png', 'src/middleMeteor1.png', 'src/middleMeteor2.png', 'src/middleMeteor3.png');
    bottom : real;
    size : real;
    objInd: integer;
    speed: real;
    constructor;
    begin
    end;
    
    constructor(x, y: real);
    begin
      posX := x;
      posY := y;
      objInd := random(0, 3);
      speed := random(3, 8);
      fname := obj[objInd];
      case objind of 
        0: size := 61.0;
        1: size := 27.0;
        2: size := 30.0;
        3: size := 25.0;
      end;
  bottom := posY+size;
      fname := obj[objInd];
    end;
    
    procedure show;
      begin
        DrawImage(posX,posY,fname);
      end;
  end;
  

type
  obstacles = auto class
    objs: List<obstacle>;
    procedure move();
    begin
      foreach var obj in objs do
      begin
        obj.posY += obj.speed;
        obj.bottom := obj.posY+obj.size;
        if obj.posY >= 600 then
        begin
          println('Вы проиграли');
          halt;
          end;
      end;
      objs := objs.Where(x -> x.posY < 800).ToList;
    end;
    
    procedure create(x, y: real);
    begin
      objs += new obstacle(x, y);
    end;
    
    procedure show();
    begin
      foreach var obj in objs do
      begin
        if obj.fname <> '' then
          obj.show;
      end;
    end;
    
  end;
procedure boom(b: obstacle);
    begin
      drawImage(b.posX,b.posY,b.objBoom);
    end;
end.