uses WPFObjects, GraphWpf, System.Timers, Controls, spaceShip, BackGround, bullets, obstacleObj;


var SpawnTimer := new Timer(500);
var layers := arr(new layer(-60, 0, 0,0, 'src/фон0.png'), new layer(-60, 0,20, 1,'src/фон1.png'), new layer(-60, -552,20, 1,'src/фон1.png'), new layer(-60, 0,10, 2,'src/фон2.png'));
var figs := new patrons(lst(new patron), 'src/fig.png', 4);
var ship  := new ship(Window.Width / 2, window.Height - 100, 'src/spaceShip.png');
var obs := new obstacles(lst(new obstacle()));

procedure moveEvents(x, y: real; mousebutton: integer);
begin
  
  //  Rectangle(x * 0.01 + x1, y * 0.01 + y1, 10, 10, Colors.Blue);
  //  Rectangle( x * 0.05 + x3, y * 0.05 + y3, 30, 30, Colors.Red);
  //  Rectangle(x * 0.1 + x2, y * 0.1 + y2, 50, 50, Colors.Aqua);
  foreach var layer in layers do
  begin
    if layer.lvl = 1 then
      layer.parralax(x, y, 0.01)
    else if layer.lvl = 2 then
      layer.parralax(x, y, 0.05);
  end;
  if (trunc(ship.width + x + 4) < Window.Width) and (trunc(x) > 0) then
    ship.changedX := x;
end;

procedure Bulletevents(x, y: real; mousebutton: integer);
begin
  if mousebutton = 1 then
  begin
    ship.figFire(figs);
  end;
end;

procedure spawn(source: Object; e: ElapsedEventArgs);
begin
  obs.create(random(10, 500), -50);
end;

procedure run;
begin
  foreach var layer in layers do
  begin
         layer.move;
    if layer.mainY >= 555 then
      layer.mainY := -552;
    layer.show;
  end;
  figs.move;
  obs.move;
  for var cnt := 0 to figs.bullets.Count - 1 do
  begin
    foreach var meteor in obs.objs do
    begin
      if (figs.bullets[cnt].posY <= meteor.Bottom) and (figs.bullets[cnt].posY >= meteor.posY) and (figs.bullets[cnt].posX >= meteor.PosX) and (figs.bullets[cnt].posX <= meteor.PosX + 60) then
      begin
        figs.bullets[cnt].isCol := true;
        boom(meteor);
        break;
      end;
    end;
    obs.objs := obs.objs.Where(x -> ((figs.bullets[cnt].posY > x.Bottom) or (figs.bullets[cnt].posY < x.posY) or (figs.bullets[cnt].posX < x.PosX) or (figs.bullets[cnt].posX > x.PosX + 60))).ToList; 
  end;
  figs.bullets := figs.bullets.Where(x -> (x.isCol <> true)).Tolist;
  figs.show;
  obs.show;
  ship.Show;
end;

procedure init;
begin
  OnMouseMove += moveEvents;
  OnMouseDown += Bulletevents;
  BeginFrameBasedAnimation(run, 30);
  SpawnTimer.Elapsed += spawn;
  SpawnTimer.Start;
end;

begin
  Window.Height := 552;
  Window.Width := 736;
  Window.IsFixedSize := true;
  init();
end.