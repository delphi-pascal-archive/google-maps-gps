unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Math, StdCtrls, Buttons, ExtCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Button3: TButton;
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Déclarations privées }
     Function  sexagesimaux_degre(var s:string):string;
   Function  sexagesimaux_minut(var s:string):string;
   Function  sexagesimaux_Second(var s:string):string;
   Function  degre_sexagesimaux_latitude(var s:string):string;
   Function  degre_sexagesimaux_longitude(var s:string):string;
   Function  degre_Direction(var s:string):string;  
  public
    { Déclarations publiques }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.dfm}
Function  TForm3.degre_Direction(var s:string):string;
begin
result:='';
 result:=result+s[length(s)];
end;

Function TForm3.degre_sexagesimaux_latitude(var s:string):string;
var
val,val2,val3:real;
d:string;
begin
val:=strtofloat(s);
if val <0 then d:='S' else d:='N';
val2:=frac(val)*60;
val3:=frac(val2)*60;
result:=floattostr(int(abs(val)))+'°'+floattostr(int(abs(val2)))+''''+floattostr(RoundTo(abs(val3),-2))+''''''+' '+d;
end;

Function TForm3.degre_sexagesimaux_longitude(var s:string):string;
var
val,val2,val3:real;
d:string;
begin
val:=strtofloat(s);
if val <0 then d:='W' else d:='E';
val2:=frac(val)*60;
val3:=frac(val2)*60;
result:=floattostr(int(abs(val)))+'°'+floattostr(int(abs(val2)))+''''+floattostr(RoundTo(abs(val3),-2))+''''''+' '+d;
end;

Function TForm3.sexagesimaux_degre(var s:string):string;
var
i:integer;
begin
i:=0;
repeat
  begin
  i:=i+1;
  if s[i]='°' then Break;
  result:=result+s[i];
  end ;
until (i=length(s));
end;
Function TForm3.sexagesimaux_minut(var s:string):string;
var
i:integer;
Bminut:boolean;
begin
Bminut:=false;
i:=0;
repeat
  begin
  i:=i+1;
   if (s[i]='''')  then Break;
   if Bminut=True then result:=result+s[i];
   if (s[i]='°')  then Bminut:=True ;
  end ;
until (i=length(s));
end;
Function TForm3.sexagesimaux_Second(var s:string):string;
var
i:integer;
BSecond:boolean;
begin
BSecond:=false;
i:=0;
repeat
  begin
  i:=i+1;
   if (s[i]='''') and (s[i+1]='''')  then Break;
   if BSecond=True then result:=result+s[i];
   if (s[i]='''')  then BSecond:=True ;
  end ;
until (i=length(s));
end;


procedure TForm3.Button1Click(Sender: TObject);
var
q,qw:string;
val:real;
direction:integer;
begin
q:=edit1.Text ;
direction:=1;
if (degre_Direction(q)='N')or (degre_Direction(q)='n') then  direction:=1;
if (degre_Direction(q)='S')or (degre_Direction(q)='s') then  direction:=-1;
if (degre_Direction(q)='W')or (degre_Direction(q)='w') then  direction:=-1;
if (degre_Direction(q)='E')or (degre_Direction(q)='e') then  direction:=1;

val:=strtofloat(sexagesimaux_degre(q))
+strtofloat(sexagesimaux_minut(q))/60
+strtofloat(sexagesimaux_Second(q))/3600;

edit3.Text :=floattostr(val*direction)+' °';

/////////////////
qw:=edit7.Text ;
direction:=1;
if (degre_Direction(qw)='N')or (degre_Direction(qw)='n') then  direction:=1;
if (degre_Direction(qw)='S')or (degre_Direction(qw)='s') then  direction:=-1;
if (degre_Direction(qw)='W')or (degre_Direction(qw)='w') then  direction:=-1;
if (degre_Direction(qw)='E')or (degre_Direction(qw)='e') then  direction:=1;

val:=strtofloat(sexagesimaux_degre(qw))
+strtofloat(sexagesimaux_minut(qw))/60
+strtofloat(sexagesimaux_Second(qw))/3600;

edit8.Text :=floattostr(val*direction)+' °';


end;

procedure TForm3.Button2Click(Sender: TObject);
var
qq,qq1:string;
begin
qq:=edit2.Text ;
qq1:=edit5.Text ;
edit4.Text :=degre_sexagesimaux_latitude(qq);
edit6.Text :=degre_sexagesimaux_longitude(qq1);

end;

procedure TForm3.Button3Click(Sender: TObject);
var
i:integer;
la,lo,la1,lo1,la11,lo11:string;
begin
if (edit3.Text='') or (edit8.Text='') then begin showmessage('Vous devez convertire dabord !!!');exit;   end;

for i:=1 to length(edit3.Text )-2 do la:=la+edit3.Text[i];
for i:=1 to length(edit8.Text )-2 do lo:=lo+edit8.Text[i];
la1:=floattostr(frac(abs(strtofloat(la))));
lo1:=floattostr(frac(abs(strtofloat(lo))));
for i:=3 to length(la1) do  la11:=la11+la1[i];
for i:=3 to length(lo1) do  lo11:=lo11+lo1[i];

form1.Latitude.Text :=floattostr(int(strtofloat(la)))+'.'+la11 ;
form1.Longitude.Text :=floattostr(int(strtofloat(lo)))+'.'+lo11;
close;
end;

end.
 