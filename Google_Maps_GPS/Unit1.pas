unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, ComCtrls, XPMan, ExtCtrls, ShellApi,
  Buttons, Math;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    XPManifest1: TXPManifest;
    ProgressBar1: TProgressBar;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Image1: TImage;
    Image2: TImage;
    Button1: TButton;
    MapType: TComboBox;
    Zoom: TComboBox;
    Latitude: TEdit;
    Longitude: TEdit;
    Key: TEdit;
    Button2: TButton;
    Image3: TImage;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label8: TLabel;
    Button6: TButton;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Label9: TLabel;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure WebBrowser1ProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
    procedure ZoomChange(Sender: TObject);
    procedure HTMLGenerat;
    procedure FormShow(Sender: TObject);
    procedure MapTypeChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

  private
  GeneratedHTML,zoom_index,matrice_image : TStringList;
  CodeHTML: string;
  map:Tbitmap;
  nb,statu_nb:integer;
  nbimage_Long,nbimage_Lati:real;
  statu_b:boolean;
  i,j:integer;
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;
  procedure GetScreenBitmap(r: TRect; var bitmap: TBitmap);
implementation

uses Unit2, Unit3, Unit4;

{$R *.dfm}
const
  TEMP_FILE_NAME = '\BAGMaps.html';
procedure GetScreenBitmap(r: TRect; var bitmap: TBitmap);
var DC: HDC;
begin
  Bitmap.Width := r.Right;
  Bitmap.Height := r.Bottom;
  DC := GetDC(0);
  try
    with Bitmap do
      BitBlt(Canvas.Handle, 0, 0,
             Width, Height, DC, r.Left, r.Top, SrcCopy);
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure Tform1.HTMLGenerat;
begin
CodeHTML := '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"'
             +'"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'#13
             +'<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">'#13
             +'<head>'#13
             +'<meta http-equiv="content-type" content="text/html; charset=utf-8"/>'#13
             +'<title>Google Maps JavaScript API Example: Simple Map</title>'#13
             +'<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key='+ Key.Text+'"'#13
             +'type="text/javascript"></script>'#13
             +'<script type="text/javascript">'#13
             +'function initialize() {'#13
             +'if (GBrowserIsCompatible()) {'#13
             +'var map = new GMap2(document.getElementById("map_canvas"));'#13
             +'map.setCenter(new GLatLng('+Latitude.Text +','+ Longitude.Text +'),'+inttostr(Zoom.ItemIndex) + ','+'G_'+MapType.Text +'_MAP'+');'#13
             +'  }'#13
             +' }'#13
             +'</script>'#13
             +'</head>'#13
             +'<body onload="initialize()" onunload="GUnload()">'#13
             +'<div id="map_canvas" style="width: 800px; height: 600px"></div>'#13
             +'</body>'#13
             +'</html>'#13 ;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
GeneratedHTML := TStringList.Create;
zoom_index    := TStringList.Create;
matrice_image := TStringList.Create;
statu_b:=false;
nbimage_Lati:=90;
statu_nb:=0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
GeneratedHTML.Free;
zoom_index.Free;
matrice_image.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  HTMLGenerat;
  GeneratedHTML.Text :=CodeHTML ;
  GeneratedHTML.SaveToFile(TEMP_FILE_NAME);
  webBrowser1.Navigate(TEMP_FILE_NAME);
//   webBrowser1.Navigate('D:\11Telechargement\13-01-2008\Convert Latitude - Longitude in Degrees-Minutes-Seconds to-from Decimal (FCC) USA.mht');
  end;

procedure TForm1.WebBrowser1ProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
begin
if Progress > 0 then
   begin
     ProgressBar1.Max := ProgressMax;
     ProgressBar1.Position :=Progress;
 //    form1.Caption :='Google Map Satellite Hybrid '+ inttostr(trunc(Progress/ProgressMax)*100)+'%';
   end
  else
   ProgressBar1.Position  := 0;
end;

procedure TForm1.ZoomChange(Sender: TObject);
begin
i:=0;j:=0;
label8.Caption :=inttostr(Zoom.ItemIndex);
button1.Click ;
nbimage_Lati:=90;
i:=0;j:=0;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
nb:=0;
label8.Caption :=inttostr(Zoom.ItemIndex);
HTMLGenerat;
end;

procedure TForm1.MapTypeChange(Sender: TObject);
begin
if MapType.ItemIndex=0 then label10.Caption :='17';
if MapType.ItemIndex=1 then label10.Caption :='19';
if MapType.ItemIndex=2 then label10.Caption :='19';
if MapType.ItemIndex=3 then label10.Caption :='15';
i:=0;j:=0;
button1.Click ;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
map:=Tbitmap.Create ;
map.Width :=512;
map.Height:=512;
nb:=nb+1;
GetScreenBitmap(rect(form1.Left+13, form1.Top+44, 512, 512), map);
image3.Picture.Bitmap :=map;
image3.Picture.SaveToFile('FolderCapture'+'\'+'('+inttostr(j)+','+inttostr(i)+')'+'.bmp');
map.Free ;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
form2.showmodal;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
form3.showmodal;
end;

procedure TForm1.Button5Click(Sender: TObject);
//var
//Longueur_matrice:integer;
//zm,mat:string;

begin

{if FileExists('Zoom.txt')=true then
begin
zoom_index.LoadFromFile('Zoom.txt');
end else zoom_index.SaveToFile('Zoom.txt');

if FileExists('matrice.txt')=true then
begin
matrice_image.LoadFromFile('matrice.txt');
end else matrice_image.SaveToFile('matrice.txt');

//zm:=zoom_index.DelimitedText ;
label8.Caption :=inttostr(Zoom.ItemIndex);
zm:=inttostr(Zoom.ItemIndex);


//mat:=matrice_image.Text  ;
//form1.Caption :=mat;
//if zm<>'' then begin Zoom.ItemIndex:=strtoint(zm);label8.Caption :=inttostr(Zoom.ItemIndex);end;
Longueur_matrice:=strtoint(floattostr(Sqrt(IntPower(4,Zoom.ItemIndex))/2));


//if  nbimage=Longueur_matrice then exit;
//Latitude.Text:='90';

//for i:=0 to Longueur_matrice-1 do
//for j:=0 to Longueur_matrice-1 do


if nbimage_Lati=-90 then begin j:=0; i:=i+1;nbimage_Lati:=90;  end;
if i= Longueur_matrice then exit;

begin
nbimage_Long:=-180+180*(2*i+1)/Longueur_matrice ;
nbimage_Lati:=nbimage_Lati-90/Longueur_matrice ;
Longitude.Text:=floattostr(nbimage_Long);
Latitude.Text:=floattostr(nbimage_Lati);
form1.Caption :='('+inttostr(j)+','+inttostr(i)+')';
end;
j:=j+1;
button1.Click ;     }    
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
form4.showmodal;
end;

end.
 