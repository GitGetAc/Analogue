unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Timer1: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);

  private
    procedure DrawHands();
  end;

var
  Form1: TForm1;

  xcenter : Integer = 175;
  ycenter : Integer = 170;

  lastxs, lastys, lastxm, lastym, lastxh, lastyh: Integer;

  clockbg: tbitmap;

  second, minute, hour: Integer;

  //For drag and drop
  MouseIsDown : Boolean;
  PX, PY: Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  clockbg := tbitmap.Create;
  clockbg.SetSize(350,350);

  with clockbg.Canvas do begin
    //Background clearing
    Brush.Color := RGBToColor(0,92,82);
    FillRect(5,5,345,345);

    //Clock area
    Brush.Color := clBlack;
    EllipseC(xcenter, ycenter, 150,150);

    //Draw numbers
    Font.Color := clWhite;
    Font.Size := 12;
    Brush.Style := bsSolid;

    TextOut(xcenter - 145, ycenter - 12, '9');
    TextOut(xcenter + 135, ycenter - 12, '3');
    TextOut(xcenter - 9, ycenter - 150, '12');
    TextOut(xcenter - 5, ycenter + 130, '6');

    //Draw the points in between numbers (hour marks)
    Brush.Style := bsSolid;
    Brush.Color := clLime;

    // 1
    EllipseC(
      round(cos((1 * 30) * pi / 180 - pi / 2) * 140 + xcenter),
      round(sin((1 * 30) * pi / 180 - pi / 2) * 140 + ycenter),
      3,3);
    // 2
    EllipseC(
      round(cos((2 * 30) * pi / 180 - pi / 2) * 140 + xcenter),
      round(sin((2 * 30) * pi / 180 - pi / 2) * 140 + ycenter),
      3,3);
    // 4
    EllipseC(
      round(cos((4 * 30) * pi / 180 - pi / 2) * 140 + xcenter),
      round(sin((4 * 30) * pi / 180 - pi / 2) * 140 + ycenter),
      3,3);
    // 5
    EllipseC(
      round(cos((5 * 30) * pi / 180 - pi / 2) * 140 + xcenter),
      round(sin((5 * 30) * pi / 180 - pi / 2) * 140 + ycenter),
      3,3);
    // 7
    EllipseC(
      round(cos((7 * 30) * pi / 180 - pi / 2) * 140 + xcenter),
      round(sin((7 * 30) * pi / 180 - pi / 2) * 140 + ycenter),
      3,3);
    // 8
    EllipseC(
      round(cos((8 * 30) * pi / 180 - pi / 2) * 140 + xcenter),
      round(sin((8 * 30) * pi / 180 - pi / 2) * 140 + ycenter),
      3,3);
    // 10
    EllipseC(
      round(cos((10 * 30) * pi / 180 - pi / 2) * 140 + xcenter),
      round(sin((10 * 30) * pi / 180 - pi / 2) * 140 + ycenter),
      3,3);
    // 11
    EllipseC(
      round(cos((11 * 30) * pi / 180 - pi / 2) * 140 + xcenter),
      round(sin((11 * 30) * pi / 180 - pi / 2) * 140 + ycenter),
      3,3);
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if clockbg <> nil then FreeAndNil(clockbg);
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    MouseIsDown := True;
    PX := X;
    PY := Y;
    end
  else if Button = mbRight then Form1.Close;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if MouseIsDown then begin
    SetBounds(Left + (X - PX), Top + (Y - PY), Width, Height);

    //This is the same
    //Form1.Left := Form1.Left + (X - PX);
    //Form1.Top := Form1.Top + (Y - PY);
  end;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MouseIsDown := False;
end;



procedure TForm1.DrawHands;
var
  HH, MM, SS, MS : Word;
  xhour, yhour, xminute, yminute, xsecond, ysecond, second, minute, hour : Integer;
  cSecond, cMinute, cHour : TColor;
begin

  // Hand colors
  cSecond := clGreen;
  cMinute := clLime;
  cHour := clWhite;

  //Get the time
  DecodeTime(Time, HH, MM, SS, MS);
  second := SS;
  minute := MM;
  hour := HH;

  //Calculation of (x, y) points where the hands will point to
  xsecond := round(cos(second * pi / 30 - pi / 2) * 125 + xcenter);
  ysecond := round(sin(second * pi / 30 - pi / 2) * 125 + ycenter);
  xminute := round(cos(minute * pi / 30 - pi / 2) * 115 + xcenter);
  yminute := round(sin(minute * pi / 30 - pi / 2) * 115 + ycenter);
  xhour := round(cos((hour * 30 + minute / 2) * pi / 180 - pi / 2) * 95 + xcenter);
  yhour := round(sin((hour * 30 + minute / 2) * pi / 180 - pi / 2) * 95 + ycenter);

  with Canvas do begin

    //Hands width
    pen.Width := 10;
    pen.Style := psSolid;

    //Draw the hands

    pen.Color := cHour;
    Line(xcenter, ycenter - 1, xhour, yhour);
    Line(xcenter - 1, ycenter, xhour, yhour);

    pen.Color := cMinute;
    Line(xcenter, ycenter - 1, xminute, yminute);
    Line(xcenter - 1, ycenter, xminute, yminute);

    pen.Color := cSecond;
    Line(xcenter, ycenter, xsecond, ysecond);
  end;

  //some info we can use later
  lastxs := xsecond;
  lastys := ysecond;
  lastxm := xminute;
  lastym := yminute;
  lastxh := xhour;
  lastyh := yhour;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if clockbg <> nil then
  begin
    Canvas.Draw(0,0,clockbg);

    DrawHands;

    Canvas.Font.Name := 'Segoe UI'; // Set the font name
    Canvas.Font.Color := clBlack; // Set the text color
    Canvas.Font.Style := [fsBold];
    Canvas.Font.Height := 20; // Set the font size

    Canvas.TextOut(xcenter - 160, ycenter - 160, FormatDateTime('DDDD', now));
    Canvas.TextOut(xcenter - 70, ycenter + 153, FormatDateTime('hh:nn:ss  DD.MM.YYYY', now));
  end;
end;

end.
