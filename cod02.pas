(*************************YazevBomberManDevelopmentStudio**********************)
(***********************************developed in*******************************)
(*************************************YazevSoft********************************)
(**********************************by Yazev Yuriy******************************)

//_begin of a development: 08.03.2008
//___end of a development: 21.05.2008
// modified: 06.06.2008

unit cod02;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, OpenGL, AppEvnts, StdCtrls, DirectInput8, ComCtrls,
  ToolWin, StdActns, ActnList, ImgList, Menus;

type
  TYazevBMLevel = class(TForm)
    YazevTopView: TPanel;
    YazevEngine: TApplicationEvents;
    YazevLevelBuilder: TListBox;
    YazevMainMenu: TMainMenu;
    mmbFile: TMenuItem;
    mmbCreate: TMenuItem;
    mmbEdit: TMenuItem;
    mmbCForm: TMenuItem;
    YazevImageList: TImageList;
    YazevActionList: TActionList;
    WindowCascade1: TWindowCascade;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowArrange1: TWindowArrange;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowTileVertical1: TWindowTileVertical;
    YazevToolBar: TToolBar;
    tbCreateLevel: TToolButton;
    ToolButton1: TToolButton;
    YazevComponentPanel: TPanel;
    mbPointer: TPanel;
    mbCube: TPanel;
    mbWall: TPanel;
    mbGold: TPanel;
    mbEnCyl: TPanel;
    mbEnDrop: TPanel;
    mbEnSph: TPanel;
    mbYazevBomberMan: TPanel;
    mmbLoadLevel: TMenuItem;
    mmbSaveLevel: TMenuItem;
    mmbExit: TMenuItem;
    YazevOpenWorldFile: TOpenDialog;
    YazevSaveWorldFile: TSaveDialog;
    KeyDelay: TTimer;
    tbOpenLevel: TToolButton;
    Rotate_90: TToolButton;
    tbSaveLevel: TToolButton;
    Rotate_180: TToolButton;
    Rotate_270: TToolButton;
    tbControlPanel: TToolButton;
    Rotate_360: TToolButton;
    imgCube: TImage;
    imgWall: TImage;
    imgPointer: TImage;
    imgGold: TImage;
    imgEnCyl: TImage;
    imgEnDrop: TImage;
    imgEnSph: TImage;
    imgYazevBomberMan: TImage;
    mmbHelp: TMenuItem;
    mmbReference: TMenuItem;
    mmbAbout: TMenuItem;
    ToolButton2: TToolButton;
    mmbLog: TMenuItem;
    mmbReg: TMenuItem;
    YazevGameStartUp: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure YazevEngineIdle(Sender: TObject; var Done: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure YazevTopViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mmbCFormClick(Sender: TObject);
    procedure mmbCreateClick(Sender: TObject);
    procedure mbPointerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mbCubeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mbWallMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mbGoldMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mbEnCylMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mbEnDropMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mbEnSphMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mbYazevBomberManMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure mmbLoadLevelClick(Sender: TObject);
    procedure mmbSaveLevelClick(Sender: TObject);
    procedure KeyDelayTimer(Sender: TObject);
    procedure mmbExitClick(Sender: TObject);
    procedure Rotate_90Click(Sender: TObject);
    procedure Rotate_180Click(Sender: TObject);
    procedure Rotate_270Click(Sender: TObject);
    procedure Rotate_360Click(Sender: TObject);
    procedure mmbAboutClick(Sender: TObject);
    procedure mmbRegClick(Sender: TObject);
    procedure YazevGameStartUpTimer(Sender: TObject);
  private
    { Private declarations }
    DC : HDC;
    rc : HGLRC;
    DI : IDirectInput8;
    DID : IDirectInputDevice8;
    ViewPort : Array [0..3] of GLint;
    SelectBuffer : Array [0..128] of GLUint;
    levelNum : Integer;
    objTypeBuild : Integer;

    procedure TwoViews;
    procedure Init_OpenGL;
    procedure Init_World;
    procedure Draw_World(mode : GLenum);
    procedure Destroy_World;
    procedure Window_ReDraw;
    procedure Init_DirectInput;
    procedure Check_Device;
    procedure Zoom(z : Single);
    function ChoiceObj(x, y : GLint) : GLUint;
    function Select_Cube(hits : Integer) : Bool;
    function Select_Wall(hits : Integer) : Bool;
    function Select_Gold(hits : Integer) : Bool;
    function Select_EnCyl(hits : Integer) : Bool;
    function Select_EnDrop(hits : Integer) : Bool;
    function Select_EnSph(hits : Integer) : Bool;
    function Select_YazevBomberMan(hits : Integer) : Bool;
    procedure Null;
  public
    { Public declarations }
    GLactive : Bool;
    procedure Set_Caption(s : String);
  end;

    TYazevGameObject = class
    anumber : Integer;
    xpos, ypos, zpos, ydeg, w, h, v : GLfloat;
  end;

    TYazevLevel = class(TYazevGameObject)
       xval, zval : Integer;
       lxval, lzval : Integer;
       LevelLabel, LevelCaption : String;
       was_changed : Bool;
       constructor Create(yform : TYazevBMLevel; levname : String; ww, vv : GLfloat; load : Bool);
       destructor Clean_Memory;
       procedure Draw(mode : GLenum);
       procedure Create_Monster_Cyl;
       procedure Create_Monster_Sph;
       procedure Create_Monster_Drop;
       procedure Create_Brick_Wall;
       procedure Create_GoldHeap;
       procedure Create_ExitDoor;
       procedure LoadLevel(levname : String; yform : TYazevBMLevel);
       procedure Create_Ground;
       procedure Draw_Level(mode : GLenum);
       procedure GetSize;
       procedure SetSize(width, length : Integer; minus : Bool);
       procedure SaveLevel(levname : String);
       function GetName(levname : String) : String;
       procedure SaveCurrentFile;
  end;

  TYazevCube = class(TYazevGameObject)
       constructor Create(i : Integer; x, z : GLfloat);
       destructor Clean_Memory(i : Integer);
       procedure Draw(i : Integer; mode : GLenum);
  end;

  TYazevBomberMan = class(TYazevGameObject)
    constructor Create(num : Integer; x, y, z, yd : GLfloat);
    destructor Clean_Memory;
    procedure Draw(mode : GLenum);
  end;

  TYazevBrickWall = class(TYazevGameObject)
      constructor Create(num : Integer; x, z : GLfloat);
      destructor Clean_Memory(num : Integer);
      procedure Draw(num : Integer; mode : GLenum);
   end;

  TEnemy = class(TYazevGameObject)
     number, shape, lifesCount, move : Integer;
     sp_var : Single;
     change : Bool;
     lxpos, lzpos : GLfloat;
     ThisSec, LastSec : DWord;
     constructor Create(num, lifes, sh : Integer;
                        x, y, z, ww, hh, vv, degree : GLfloat); virtual; abstract;
     destructor Clean_Memory(num : Integer); virtual; abstract;
     procedure Draw(num : Integer; mode : GLenum); virtual; abstract;
   end;

   TEnemyCyl = class(TEnemy)
     constructor Create(num, lifes, sh : Integer;
                        x, y, z, ww, hh, vv, degree : GLfloat); override;
     destructor Clean_Memory(num : Integer); override;
     procedure Draw(num : Integer; mode : GLenum); override;
   end;

   TEnemySph = class(TEnemy)
     constructor Create(num, lifes, sh : Integer;
                        x, y, z, ww, hh, vv, degree : GLfloat); override;
     destructor Clean_Memory(num : Integer); override;
     procedure Draw(num : Integer; mode : GLenum); override;
   end;

   TEnemyDrop = class(TEnemy)
     constructor Create(num, lifes, sh : Integer;
                        x, y, z, ww, hh, vv, degree : GLfloat); override;
     destructor Clean_Memory(num : Integer); override;
     procedure Draw(num : Integer; mode : GLenum); override;
   end;

   TGold = class(TYazevGameObject)
     constructor Create(num : Integer; x, z : GLfloat);
     destructor Clean_Memory(num : Integer);
     procedure Draw(num : Integer; mode : GLenum);
   end;
{ ~~~ внимание!!! 
   TExitDoor = class(TYazevGameObject)
      constructor Create(num : Integer; x, z : GLfloat);
      destructor Clean_Memory;
      procedure Draw(mode : GLenum);
   end;
 }
   TYazevTile = class(TYazevGameObject)
      constructor Create(i : Integer; x, z : GLfloat);
      destructor Clean_Memory(i, j : Integer);
      procedure Draw(i, j : Integer; mode : GLenum);
   end;

   TObjSel = record
   obj_num : Integer;
   obj_type : String;
   end;

   const
//    ground = 1;
    cube = 2;
    // enemys shapes
    cyl = 5;
    sph = 6;
    drop = 7;
    // wall
    brickwall = 8;
    // gold
    goldheap = 9;

    exdoor = 10;

    tile = 11;

var
  YazevBMLevel: TYazevBMLevel;

  qO : GLUquadricObj;
  YazevBomberMan : TYazevBomberMan = nil;
  Level : TYazevLevel = nil;
  cubes : Array of TYazevCube;
  // enemys
  encyl : Array of TEnemyCyl;
  ensph : Array of TEnemySph;
  endrop : Array of TEnemyDrop;
  // wall
  walls : Array of TYazevBrickWall;
  // gold
  gold : Array of TGold;

//  exitdoor : TExitDoor = nil;

 wii, vii, ybmpx, ybmpz, ybmry, xcam, ycam, zcam, lxcam, lycam, lzcam : Single;

  tiles : Array of Array of TYazevTile;
 // счётчик объектов
  numlong : Integer = 0;
  // активный объект
  obj_sel : TObjSel;
  // активность клавиш - задержка нажатия
  key_delay : Bool = true;

implementation

uses Registry, DGLUT, cod03, cod04;

{$R *.dfm}

procedure TYazevBMLevel.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
  but : Integer;
begin
//formCount := formCount - 1;
//YazevBMDev.Set_Text(IntToStr(formCount));
//Destroy;
if Level.was_changed then begin
but := MessageDlg('Do you wanna save your World?', mtConfirmation, mbYesNoCancel, 0);
case but of
mrYes :
if Level <> nil then begin
if Level.LevelLabel = '' then mmbSaveLevel.Click else Level.SaveCurrentFile;
end;
mrCancel : Action := caNone;
end;
end;
end;

procedure TYazevBMLevel.Set_Caption(s: String);
begin
Caption := s;
end;

procedure TYazevBMLevel.FormResize(Sender: TObject);
begin
TwoViews;
end;

procedure TYazevBMLevel.FormCreate(Sender: TObject);
begin
//ClientHeight := 400;
//ClientWidth := 400;
levelNum := 0;
DC := GetDC(YazevTopView.Handle);
Init_OpenGL;
rc := wglCreateContext(DC);
wglMakeCurrent(DC, rc);
Init_DirectInput;
Init_World;
glClearColor(0.3, 0.9, 1.0, 1.0);
if (Level = nil) and (ParamCount <= 0) then
Level := TYazevLevel.Create(Sender as TYazevBMLevel, 'Level01', 7, 7, false)
else if (Level = nil) and (ParamCount > 0) then
YazevGameStartUp.Enabled := true;
end;

procedure TYazevBMLevel.TwoViews;
{
var
size : Integer;
}
begin
{
size := ClientWidth div 2 - 5;
YazevTopView.Width := size;
YazevTopView.Width := size;
YazevAboveView.Left := YazevTopView.Left + YazevTopView.Width div 2 - YazevAboveView.Width div 2;
YazevPerspView.Left := YazevPerspectiveView.Left + YazevPerspectiveView.Width div 2 - YazevPerspView.Width div 2;
//****************************************
}
Window_ReDraw;
end;

procedure TYazevBMLevel.Init_OpenGL;
var
zPixel : Integer;
pfd : TPixelFormatDescriptor;
begin
FillChar(pfd, SizeOf(pfd), 0);
pfd.dwFlags := PFD_DRAW_TO_WINDOW OR PFD_SUPPORT_OPENGL OR PFD_DOUBLEBUFFER;
pfd.cColorBits := 32;
pfd.cDepthBits := 32;
zPixel := ChoosePixelFormat(DC, @pfd);
SetPixelFormat(DC, zPixel, @pfd);
end;

procedure TYazevBMLevel.FormDestroy(Sender: TObject);
begin
GLactive := false;
Destroy_World;
wglMakeCurrent(0, 0);
wglDeleteContext(rc);
ReleaseDC(Handle, DC);
DeleteDC(DC);
end;

procedure TYazevBMLevel.YazevEngineIdle(Sender: TObject;
  var Done: Boolean);
begin
if GLactive then begin
Draw_World(GL_RENDER);
Check_Device;
end;
Done := false;
end;

procedure TYazevBMLevel.Init_World;
begin
glSelectBuffer(SizeOf(SelectBuffer), @SelectBuffer);
glEnable(GL_DEPTH_TEST);
glEnable(GL_LIGHTING);
glEnable(GL_LIGHT0);
qO := gluNewQuadric;
GLactive := true;
Null;
end;

procedure TYazevBMLevel.FormActivate(Sender: TObject);
begin
GLactive := true;
end;

procedure TYazevBMLevel.FormDeactivate(Sender: TObject);
begin
//GLactive := false;
end;

procedure TYazevBMLevel.Draw_World(mode : GLenum);
var
tps : TPaintStruct;
begin
BeginPaint(YazevTopView.Handle, tps);
glClear(GL_COLOR_BUFFER_BIT OR GL_DEPTH_BUFFER_BIT);
glPushMatrix;
glTranslatef(xcam, ycam, zcam);
if Level <> nil then Level.Draw(mode);
glPopMatrix;
SwapBuffers(DC);
EndPaint(YazevTopView.Handle, tps);
end;

{ TYazevLevel }

destructor TYazevLevel.Clean_Memory;
var
i, j : Integer;
begin
//glDeleteLists(ground, 1);
for i := Low(cubes) to High(cubes) do
if cubes[i] <> nil then cubes[i].Clean_Memory(i);
glDeleteLists(cube, 1);
for i := Low(walls) to High(walls) do
if walls[i] <> nil then walls[i].Clean_Memory(i);
glDeleteLists(brickwall, 1);
// monsters
for i := Low(encyl) to High(encyl) do
if encyl[i] <> nil then encyl[i].Clean_Memory(i);
glDeleteLists(cyl, 1);
for i := Low(ensph) to High(ensph) do
if ensph[i] <> nil then ensph[i].Clean_Memory(i);
glDeleteLists(sph, 1);
for i := Low(endrop) to High(endrop) do
if endrop[i] <> nil then endrop[i].Clean_Memory(i);
glDeleteLists(drop, 1);
for i := Low(gold) to High(gold) do
if gold[i] <> nil then gold[i].Clean_Memory(i);
glDeleteLists(goldheap, 1);
{if exitdoor <> nil then exitdoor.Clean_Memory;
glDeleteLists(exdoor, 1);}
for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) do
if tiles[i][j] <> nil then tiles[i][j].Clean_Memory(i, j);
glDeleteLists(tile, 1);
// YazevBomberMan
if YazevBomberMan <> nil then YazevBomberMan.Clean_Memory;
// main object
Level := nil;
Level.Free;
end;

constructor TYazevLevel.Create(yform : TYazevBMLevel; levname : String; ww, vv : GLfloat; load : Bool);
{
begin
xpos := 0.0;
ypos := -1.77;
zpos := 0.5;
ydeg := 0.0;
w := 27.0;//wii;
h := 0.1;
v := 14.5;//vii;
     }
const
mat_for_cube : Array [0..3] of GLfloat = (0.8, 0.8, 0.8, 1.0);
//------------------------------------------------------------------------------
begin
YazevBMLevel.objTypeBuild := 0;
if levname <> GetName(levname) then
LevelLabel := levname else
LevelLabel := '';
LevelCaption := GetName(levname);

with obj_sel do begin
obj_num := -1;
obj_type := '';
end;

xval := 0;
zval := 0;
lxval := 0;
lzval := 0;
glNewList(cube, GL_COMPILE);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_cube);
glPushMatrix;
glScalef(1.0, 2.0, 1.0);
glutSolidCube(1.0);
glPopMatrix;
glEndList;

Create_Brick_Wall;

// enemys_monsters
Create_Monster_Cyl;

Create_Monster_Sph;

Create_Monster_Drop;
// gold
Create_GoldHeap;
//exit
Create_ExitDoor;
// Load Level
if load then begin
YazevBMLevel.YazevLevelBuilder.Clear;
LoadLevel(levname, yform);
end;
// ground and walls
xpos := 0.0;
ypos := -1.77;
zpos := 0.5;
ydeg := 0.0;
if not load then begin
wii := ww;
vii := vv;
end;
w := wii;
h := 0.1;
v := vii;

Create_Ground;

was_changed := false;
{
w := 27.0;//wii;
h := 0.1;
v := 14.5;//vii;
}

{
Create_Brick_Wall;
Create_Monster_Cyl;
Create_Monster_Sph;
Create_Monster_Drop;
Create_GoldHeap;
Create_ExitDoor;
}
//numlong := numlong + 1;
// YazevBomberMan
//YazevBomberMan := TYazevBomberMan.Create(numlong, ybmpx, 0.0, ybmpz, ybmry);
YazevBMLevel.Caption := 'YazevBomberManDevelopmentStudio   developed by Yazev Yuriy:  ' + LevelCaption;
{with YazevBMLevel do begin
xcam := xpos - w / 4;
zcam := zpos + v / 4;
glTranslatef(xcam, ycam, zcam);
end;}
end;

procedure TYazevLevel.Create_Brick_Wall;
const
mat_for_cube : Array [0..3] of GLfloat = (0.8, 0.8, 0.2, 1.0);
begin
glNewList(brickwall, GL_COMPILE);
glPushMatrix;
glScalef(1.0, 2.0, 1.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_cube);
glutSolidCube(1.0);
glPopMatrix;
glEndList;
end;

procedure TYazevLevel.Create_ExitDoor;
const
mat_for_door : Array [0..3] of GLfloat = (0.4, 0.4, 0.1, 1.0);
mat_for_handle : Array [0..3] of GLfloat = (1.5, 1.5, 0.0, 1.0);
begin
glNewList(exdoor, GL_COMPILE);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_door);
glPushMatrix;
glScalef(0.9, 1.8, 0.9);
glutSolidCube(1.0);
glPopMatrix;
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_handle);
glPushMatrix;
glTranslatef(-0.25, 0.4, 0.4);
glScalef(0.1, 0.1, 0.2);
glutSolidTorus(0.4, 0.9, 10, 10);
glPopMatrix;
glPushMatrix;
glRotatef(90.0, 0.0, 1.0, 0.0);
glTranslatef(-0.25, 0.4, 0.4);
glScalef(0.1, 0.1, 0.2);
glutSolidTorus(0.4, 0.9, 10, 10);
glPopMatrix;
glEndList;
end;

procedure TYazevLevel.Create_GoldHeap;
const
mat_for_gold : Array [0..3] of GLfloat = (1.1, 1.1, 0.0, 1.0);
begin
glNewList(goldheap, GL_COMPILE);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_gold);
gluCylinder(qO, 0.5, 0.0, 0.8, 10, 10);
glEndList;
end;

procedure TYazevLevel.Create_Ground;
const
mat_for_ground : Array [0..3] of GLfloat = (0.7, 0.7, 0.7, 1.0);
var
i, j : Integer;
begin
{
glNewList(ground, GL_COMPILE);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_ground);
glBegin(GL_QUADS);
glNormal3f(0.0, 1.0, 0.0);
glVertex3f(xpos - 0.5, ypos, zpos + 0.5);
glVertex3f(xpos + 0.5, ypos, zpos + 0.5);
glVertex3f(xpos + 0.5, ypos, zpos - 0.5);
glVertex3f(xpos - 0.5, ypos, zpos - 0.5);
glEnd;
}
glNewList(tile, GL_COMPILE);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_ground);
glBegin(GL_QUADS);
glNormal3f(0.0, 1.0, 0.0);
glVertex3f(-0.5, ypos, 0.5);
glVertex3f(0.5, ypos, 0.5);
glVertex3f(0.5, ypos, -0.5);
glVertex3f(-0.5, ypos, -0.5);
glEnd;
glEndList;

SetLength(tiles, Round(wii) + 1, Round(vii) + 1);

for i := 1 to Round(wii) do
for j := 1 to Round(vii) do begin
//tiles[i][j] := TYazevTile.Create(numlong, xpos - wii / 2 + i, zpos - vii / 2 + j);
tiles[i][j] := TYazevTile.Create(numlong, xpos + i, zpos + j);
numlong := numlong + 1;
end;
end;

procedure TYazevLevel.Create_Monster_Cyl;
const
cyl_mat_for_eyes : Array [0..3] of GLfloat = (0.8, 0.8, 0.8, 1.0);
cyl_mat_for_body : Array [0..3] of GLfloat = (0.5, 0.7, 0.2, 1.0);
cyl_mat_for_head : Array [0..3] of GLfloat = (0.7, 0.9, 0.4, 1.0);
cyl_mat_for_mouth : Array [0..3] of GLfloat = (0.3, 0.1, 0.1, 1.0);
cyl_mat_for_arms : Array [0..3] of GLfloat = (1.0, 1.0, 0.0, 1.0);
cyl_mat_for_hands : Array [0..3] of GLfloat = (1.0, 0.0, 0.0, 1.0);
begin
glNewList(cyl, GL_COMPILE);
glPushMatrix;
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @cyl_mat_for_body);
gluCylinder(qO, 0.35, 0.35, 1.0, 10, 10);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @cyl_mat_for_head);
glutSolidSphere(0.35, 10, 10);
glPushMatrix;
glTranslatef(-0.15, 0.2, -0.175);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @cyl_mat_for_eyes);
glutSolidSphere(0.1, 10, 10);
glTranslatef(0.3, 0.0, 0.0);
glutSolidSphere(0.1, 10, 10);
glPopMatrix;
glTranslatef(0.0, 0.25, 0.1);
glPushMatrix;
glScalef(1.2, 1.0, 0.7);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @cyl_mat_for_mouth);
glutSolidCube(0.3);
glPopMatrix;
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @cyl_mat_for_arms);
glPushMatrix;
glTranslatef(-0.23, -0.1, 0.0);
glRotatef(90.0, -1.0, 0.0, 0.0);
gluCylinder(qO, 0.075, 0.075, 0.5, 10, 10);
glTranslatef(0.0, 0.0, 0.5);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @cyl_mat_for_hands);
glutSolidCube(0.2);
glPopMatrix;
glPushMatrix;
glTranslatef(0.23, -0.1, 0.0);
glRotatef(90.0, -1.0, 0.0, 0.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @cyl_mat_for_arms);
gluCylinder(qO, 0.075, 0.075, 0.5, 10, 10);
glTranslatef(0.0, 0.0, 0.5);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @cyl_mat_for_hands);
glutSolidCube(0.2);
glPopMatrix;
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @cyl_mat_for_mouth);
glPushMatrix;
glTranslatef(0.0, -0.25, 0.8);
glScalef(4.0, 6.0, 1.0);
glutSolidCube(0.2);
glPopMatrix;
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @cyl_mat_for_arms);
glPushMatrix;
glRotatef(90.0, 0.0, 1.0, 0.0);
glTranslatef(-0.95, 0.3, -0.35);
glScalef(1.0, 1.0, 1.4);
gluCylinder(qO, 0.085, 0.085, 0.5, 10, 10);
glTranslatef(0.0, -0.2, 0.0);
gluCylinder(qO, 0.085, 0.085, 0.5, 10, 10);
glTranslatef(0.0, -0.2, 0.0);
gluCylinder(qO, 0.085, 0.085, 0.5, 10, 10);
glTranslatef(0.0, -0.2, 0.0);
gluCylinder(qO, 0.085, 0.085, 0.5, 10, 10);
glTranslatef(0.0, -0.2, 0.0);
gluCylinder(qO, 0.085, 0.085, 0.5, 10, 10);
glTranslatef(0.0, -0.2, 0.0);
gluCylinder(qO, 0.085, 0.085, 0.5, 10, 10);
glPopMatrix;
glPopMatrix;
glEndList;
end;

procedure TYazevLevel.Create_Monster_Drop;
const
mat_for_body : Array [0..3] of GLfloat = (0.5, 0.5, 0.9, 1.0);
mat_for_eyes : Array [0..3] of GLfloat = (0.75, 0.75, 0.1, 1.0);
mat_for_arms : Array [0..3] of GLfloat = (0.1, 0.8, 0.3, 1.0);
begin
glNewList(drop, GL_COMPILE);
glPushMatrix;
glPushMatrix;
glRotatef(90.0, -1.0, 0.0, 0.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_body);
gluCylinder(qO, 0.0, 0.35, 1.3, 10, 10);
glPopMatrix;
glTranslatef(0.0, 1.4, 0.0);
glutSolidSphere(0.4, 10, 10);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_eyes);
glTranslatef(0.17, 0.17, 0.25);
glutSolidSphere(0.1, 10, 10);
glTranslatef(-0.17 * 2, 0.0, 0.0);
glutSolidSphere(0.1, 10, 10);
glTranslatef(0.17, -0.1, 0.1);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_arms);
glPushMatrix;
glTranslatef(-0.27, -0.2, -0.15);
glPushMatrix;
glRotatef(90.0, 1.0, 0.0, 0.0);
gluCylinder(qO, 0.02, 0.02, 0.5, 10, 10);
glPopMatrix;
glTranslatef(0.0, -0.5, 0.0);
glutSolidSphere(0.05, 10, 10);
glRotatef(-30.0, 1.0, 0.0, 0.0);
gluCylinder(qO, 0.02, 0.02, 0.5, 10, 10);
glTranslatef(0.0, 0.0, 0.5);
glRotatef(30.0, -1.0, 0.0, 0.0);
gluCylinder(qO, 0.02, 0.02, 0.2, 10, 10);
glRotatef(60.0, 1.0, 0.0, 0.0);
gluCylinder(qO, 0.02, 0.02, 0.2, 10, 10);
glPopMatrix;
glTranslatef(0.57, 0.0, 0.0);
glPushMatrix;
glTranslatef(-0.27, -0.2, -0.15);
glPushMatrix;
glRotatef(90.0, 1.0, 0.0, 0.0);
gluCylinder(qO, 0.02, 0.02, 0.5, 10, 10);
glPopMatrix;
glTranslatef(0.0, -0.5, 0.0);
glutSolidSphere(0.05, 10, 10);
glRotatef(-30.0, 1.0, 0.0, 0.0);
gluCylinder(qO, 0.02, 0.02, 0.5, 10, 10);
glTranslatef(0.0, 0.0, 0.5);
glRotatef(30.0, -1.0, 0.0, 0.0);
gluCylinder(qO, 0.02, 0.02, 0.2, 10, 10);
glRotatef(60.0, 1.0, 0.0, 0.0);
gluCylinder(qO, 0.02, 0.02, 0.2, 10, 10);
glPopMatrix;
glPopMatrix;
glEndList;
end;

procedure TYazevLevel.Create_Monster_Sph;
const
mat_for_body : Array [0..3] of GLfloat = (0.8, 0.0, 0.0, 1.0);
mat_for_eyes : Array [0..3] of GLfloat = (0.3, 0.3, 0.8, 1.0);
mat_for_mouth : Array [0..3] of GLfloat = (2.0, 2.0, 2.0, 1.0);
mat_for_peak : Array [0..3] of GLfloat = (3.0, 2.0, 0.0, 1.0);
begin
glNewList(sph, GL_COMPILE);
glPushMatrix;
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_body);
glutSolidSphere(0.5, 10, 10);
glPushMatrix;
glTranslatef(0.2, 0.1, 0.4);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_eyes);
glutSolidSphere(0.1, 10, 10);
glTranslatef(-0.4, 0.0, 0.0);
glutSolidSphere(0.1, 10, 10);
glTranslatef(0.2, -0.2, 0.0);
glPushMatrix;
glScalef(1.5, 1.0, 1.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_mouth);
glutSolidCube(0.2);
glPopMatrix;
glTranslatef(-0.13, 0.0, 0.0);
glTranslatef(0.0, 0.35, -0.1);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_peak);
glPushMatrix;
glRotatef(-45.0, 1.0, 1.0, 0.0);
gluCylinder(qO, 0.1, 0.0, 0.4, 10, 10);
glPopMatrix;
glPushMatrix;
glTranslatef(0.25, 0.0, 0.0);
glRotatef(-45.0, 1.0, -1.0, 0.0);
gluCylinder(qO, 0.1, 0.0, 0.4, 10, 10);
glPopMatrix;
glPopMatrix;

glPopMatrix;
glEndList;
end;

procedure TYazevLevel.Draw(mode : GLenum);
var
i : Integer;
begin
glPushMatrix;
glTranslatef(xpos, ypos, zpos);
//glCallList(ground);
//glCallList(tile);
Draw_Level(mode);
glTranslatef(-1.0, -1.0, -1.0);
glPushMatrix;
//glTranslatef(-10.0, 0.0, -3.5);
for i := Low(cubes) to High(cubes) do
if cubes[i] <> nil then cubes[i].Draw(anumber, mode);
glPopMatrix;
glPopMatrix;
for i := Low(walls) to High(walls) do
if walls[i] <> nil then walls[i].Draw(i, mode);
// monsters
for i := Low(encyl) to High(encyl) do
if encyl[i] <> nil then encyl[i].Draw(i, mode);
//YazevBombField.Caption := IntToStr(High(bombs))
for i := Low(ensph) to High(ensph) do
if ensph[i] <> nil then ensph[i].Draw(i, mode);
for i := Low(endrop) to High(endrop) do
if endrop[i] <> nil then endrop[i].Draw(i, mode);
// gold
for i := Low(gold) to High(gold) do
if gold[i] <> nil then gold[i].Draw(i, mode);
// exit
//if exitdoor <> nil then exitdoor.Draw(mode);
if YazevBomberMan <> nil then YazevBomberMan.Draw(mode);
end;

procedure TYazevLevel.Draw_Level(mode : GLenum);
const
mat_for_ground : Array [0..3] of GLfloat = (0.7, 0.7, 0.7, 1.0);
mat_for_cube : Array [0..3] of GLfloat = (0.8, 0.8, 0.8, 1.0);
var
i, j : Integer;
begin
{
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_ground);
glBegin(GL_QUADS);
glNormal3f(0.0, 1.0, 0.0);
glVertex3f(xpos - w / 2, ypos, zpos + v / 2);
glVertex3f(xpos + w / 2, ypos, zpos + v / 2);
glVertex3f(xpos + w / 2, ypos, zpos - v / 2);
glVertex3f(xpos - w / 2, ypos, zpos - v / 2);
glEnd;
}
{
// надо сделать в настройках
xval := 3;
zval := 2;
}

for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) do
if tiles[i][j] <> nil then tiles[i][j].Draw(i, j, mode);

glNormal3f(0.0, 1.0, 0.0);
{
glBegin(GL_QUADS);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_cube);
glVertex3f(xpos - w / 2, ypos, zpos - v / 2);
glVertex3f(xpos - w / 2, ypos + 2, zpos - v / 2);
glVertex3f(xpos + w / 2 + xval, ypos + 2, zpos - v / 2);
glVertex3f(xpos + w / 2 + xval, ypos, zpos - v / 2);
glEnd;

glBegin(GL_QUADS);
glVertex3f(xpos - w / 2, ypos, zpos + v / 2 + zval);
glVertex3f(xpos - w / 2, ypos + 2, zpos + v / 2 + zval);
glVertex3f(xpos + w / 2 + xval, ypos + 2, zpos + v / 2 + zval);
glVertex3f(xpos + w / 2 + xval, ypos, zpos + v / 2 + zval);
glEnd;

glPushMatrix;
glRotatef(90.0, 0.0, 1.0, 0.0);
glBegin(GL_QUADS);
glVertex3f(zpos + v / 2 - 1.0, ypos, xpos - w / 2);
glVertex3f(zpos + v / 2 - 1.0, ypos + 2, xpos - w / 2);
glVertex3f(zpos - v / 2 - 1.0 - zval, ypos + 2, xpos - w / 2);
glVertex3f(zpos - v / 2 - 1.0 - zval, ypos, xpos - w / 2);
glEnd;

glBegin(GL_QUADS);
glVertex3f(zpos + v / 2 - 1.0, ypos, xpos + w / 2 + xval);
glVertex3f(zpos + v / 2 - 1.0, ypos + 2, xpos + w / 2 + xval);
glVertex3f(zpos - v / 2 - 1.0 - zval, ypos + 2, xpos + w / 2 + xval);
glVertex3f(zpos - v / 2 - 1.0 - zval, ypos, xpos + w / 2 + xval);
glEnd;
glPopMatrix;
}
glBegin(GL_QUADS);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_cube);
glVertex3f(xpos, ypos, zpos);
glVertex3f(xpos, ypos + 2, zpos);
glVertex3f(xpos + w + xval, ypos + 2, zpos);
glVertex3f(xpos + w + xval, ypos, zpos);
glEnd;

glBegin(GL_QUADS);
glVertex3f(xpos, ypos, zpos + v + zval);
glVertex3f(xpos, ypos + 2, zpos + v + zval);
glVertex3f(xpos + w + xval, ypos + 2, zpos + v + zval);
glVertex3f(xpos + w + xval, ypos, zpos + v + zval);
glEnd;

glPushMatrix;
glRotatef(90.0, 0.0, 1.0, 0.0);
glBegin(GL_QUADS);
glVertex3f(zpos - 1.0, ypos, xpos);
glVertex3f(zpos - 1.0, ypos + 2, xpos);
glVertex3f(zpos - v - 1.0 - zval, ypos + 2, xpos);
glVertex3f(zpos - v - 1.0 - zval, ypos, xpos);
glEnd;

glBegin(GL_QUADS);
glVertex3f(zpos - 1.0, ypos, xpos + w + xval);
glVertex3f(zpos - 1.0, ypos + 2, xpos + w + xval);
glVertex3f(zpos - v - 1.0 - zval, ypos + 2, xpos + w + xval);
glVertex3f(zpos - v - 1.0 - zval, ypos, xpos + w + xval);
glEnd;
glPopMatrix;
end;

function TYazevLevel.GetName(levname: String): String;
var
s : String;
i, a : Integer;
begin
a := 0;
s := ExtractFileName(levname);
for i := Length(s) downto 1 do
if s[i] = '.' then begin
a := a + 1;
end;
if a > 0 then
for i := Length(s) downto 1 do
if s[i] <> '.' then Delete(s, i, 1) else begin
Delete(s, i, 1);
a := a - 1;
if a = 0 then break;
end;
Result := s;
end;

procedure TYazevLevel.GetSize;
begin
YazevControlForm.YazevXValEdit.Value := xval + Round(w);
YazevControlForm.YazevZValEdit.Value := zval + Round(v);
end;

procedure TYazevLevel.LoadLevel(levname: String; yform : TYazevBMLevel);
var
i, j, lc, numpar, obj_num, count : Integer;
s,  posx, posz, roty, obj_type, obj_count : String;
kreat : Bool;
px, pz, ry : Single;
begin
obj_num := 0;
px := 0;
pz := 0;
ry := 0;
with yform do begin
YazevLevelBuilder.Items.LoadFromFile(levname);
for i := 0 to YazevLevelBuilder.Items.Count - 1 do begin
numpar := 0;
kreat := true;
posx := '';
posz := '';
roty := '';
s := YazevLevelBuilder.Items.Strings[i];
for j := 1 to Length(s) do
case s[j] of
'#' : begin
kreat := false;
break;
end;
'!' : numpar := numpar + 1;
{',' : begin
Delete(s, j, 1);       параметры зависят от настроек операционной системы
Insert('.', s, j - 1);
end;}
'$' : begin
obj_num := 0;
obj_type := '';
obj_count := '';
lc := j + 1;
while s[lc] <> ':' do begin
Insert(s[lc], obj_type, Length(obj_type) + 1);
lc := lc + 1;
end;
for lc := lc + 1 to Length(s) do Insert(s[lc], obj_count, Length(obj_count) + 1);
count := StrToInt(obj_count);
if obj_type = 'cube' then SetLength(cubes, count) else
if obj_type = 'box' then SetLength(walls, count) else
if obj_type = 'gold' then SetLength(gold, count) else
if obj_type = 'encyl' then SetLength(encyl, count) else
if obj_type = 'ensph' then SetLength(ensph, count) else
if obj_type = 'endrop' then SetLength(endrop, count) else
if obj_type = 'Score' then YazevControlForm.YazevScoreToWin.Value := count;
kreat := false;
Break;
end else
case numpar of
0 : Insert(s[j], posx, Length(posx) + 1);
1 : Insert(s[j], posz, Length(posz) + 1);
2 : Insert(s[j], roty, Length(roty) + 1);
end; // case
end; // case
numlong := numlong + 1;
if kreat then begin
if posx <> '' then px := StrToFloat(posx);
if posz <> '' then pz := StrToFloat(posz);
if roty <> '' then ry := StrToFloat(roty);
if obj_type = 'cube' then
cubes[obj_num] := TYazevCube.Create(numlong, px, pz) else
if obj_type = 'box' then
walls[obj_num] := TYazevBrickWall.Create(numlong, px, pz) else
if obj_type = 'gold' then
gold[obj_num] := TGold.Create(numlong, px, pz) else
if obj_type = 'encyl' then
encyl[obj_num] := TEnemyCyl.Create(numlong, 0, 0, px, -2.15, pz, 1.0, 2.0, 1.0, ry) else
if obj_type = 'ensph' then
ensph[obj_num] := TEnemySph.Create(numlong, 0, 1, px, -2.5, pz, 1.0, 2.0, 1.0, ry) else
if obj_type = 'endrop' then
endrop[obj_num] := TEnemyDrop.Create(numlong, 0, 2, px, -3.5, pz, 1.0, 2.0, 1.0, ry) else
if obj_type = 'ground' then begin
wii := px;// внимание!!!
vii := pz;
end else
if obj_type = 'YazevBomberMan' then begin
ybmpx := px;
ybmpz := pz;
ybmry := ry;
YazevBomberMan := TYazevBomberMan.Create(numlong, ybmpx, 0.0, ybmpz, ybmry);
end;
// переменная-счётчик
obj_num := obj_num + 1;
end; // if
end; // for
end; // with
end;

procedure TYazevLevel.SaveCurrentFile;
const
ex = '.ywf';
var
s : String;
begin
s := ExtractFilePath(Level.LevelLabel) + Level.GetName(Level.LevelLabel);
//ShowMessage(s);
Level.LevelLabel := s;
Level.LevelCaption := Level.GetName(s);
YazevBMLevel.Caption := 'YazevBomberManDevelopmentStudio   developed by Yazev Yuriy:  ' + Level.LevelCaption;
Level.SaveLevel(s);
end;

procedure TYazevLevel.SaveLevel(levname: String);
var
i, count : Integer;
begin
with YazevBMLevel.YazevLevelBuilder do begin
Clear;
// title
Items.Add('# YazevBomberMan v1.5: ' + Level.LevelCaption);
Items.Add('# developed in YazevBomberManDev');
Items.Add('# date of creating: ' + DateTimeToStr(Now));
// ground
Items.Add('$ground:1');
Items.Add(FloatToStr(w + xval) + '!' + FloatToStr(v + zval));
// cube
count := 0;
for i := Low(cubes) to High(cubes) do
if cubes[i] <> nil then count := count + 1;
Items.Add('$cube:' + IntToStr(count));
for i := Low(cubes) to High(cubes) do
if cubes[i] <> nil then
Items.Add(FloatToStr(cubes[i].xpos) + '!' + FloatToStr(cubes[i].zpos));
// box
count := 0;
for i := Low(walls) to High(walls) do
if walls[i] <> nil then count := count + 1;
Items.Add('$box:' + IntToStr(count));
for i := Low(walls) to High(walls) do
if walls[i] <> nil then
Items.Add(FloatToStr(walls[i].xpos) + '!' + FloatToStr(walls[i].zpos));
// gold
count := 0;
for i := Low(gold) to High(gold) do
if gold[i] <> nil then count := count + 1;
Items.Add('$gold:' + IntToStr(count));
for i := Low(gold) to High(gold) do
if gold[i] <> nil then
Items.Add(FloatToStr(gold[i].xpos) + '!' + FloatToStr(gold[i].zpos));
// encyl
count := 0;
for i := Low(encyl) to High(encyl) do
if encyl[i] <> nil then count := count + 1;
Items.Add('$encyl:' + IntToStr(count));
for i := Low(encyl) to High(encyl) do
if encyl[i] <> nil then
Items.Add(FloatToStr(encyl[i].xpos) + '!' + FloatToStr(encyl[i].zpos) + '!' + FloatToStr(encyl[i].ydeg));
// ensph
count := 0;
for i := Low(ensph) to High(ensph) do
if ensph[i] <> nil then count := count + 1;
Items.Add('$ensph:' + IntToStr(count));
for i := Low(ensph) to High(ensph) do
if ensph[i] <> nil then
Items.Add(FloatToStr(ensph[i].xpos) + '!' + FloatToStr(ensph[i].zpos) + '!' + FloatToStr(ensph[i].ydeg));
// endrop
count := 0;
for i := Low(endrop) to High(endrop) do
if endrop[i] <> nil then count := count + 1;
Items.Add('$endrop:' + IntToStr(count));
for i := Low(endrop) to High(endrop) do
if endrop[i] <> nil then
Items.Add(FloatToStr(endrop[i].xpos) + '!' + FloatToStr(endrop[i].zpos) + '!' + FloatToStr(endrop[i].ydeg));
// YazevBomberMan
if YazevBomberMan <> nil then begin
Items.Add('$YazevBomberMan:1');
Items.Add(FloatToStr(YazevBomberMan.xpos) + '!' + FloatToStr(YazevBomberMan.zpos) + '!' + FloatToStr(YazevBomberMan.ydeg));
end;
// score
Items.Add('$Score:' + IntToStr(YazevControlForm.YazevScoreToWin.Value));
// save to file
Items.SaveToFile(levname + '.ywf');
end;
end;

procedure TYazevLevel.SetSize(width, length : Integer; minus : Bool);
var
i, j : Integer;
begin
lxval := xval;
lzval := zval;
{
xval := YazevControlForm.YazevXValEdit.Value - Round(w);
zval := YazevControlForm.YazevZValEdit.Value - Round(v);
}
if minus then begin
xval := width - Round(w);
zval := length - Round(v);
end else begin
xval := width;
zval := length;
end;
// x
if xval < lxval then begin
for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) do
if (i > w + xval) and (tiles[i][j] <> nil) then
tiles[i][j].Clean_Memory(i, j);
SetLength(tiles, Round(w) + xval + 1);
end else
if xval > lxval then begin
SetLength(tiles, Round(w) + xval + 1, Round(v) + zval + 1);
for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) - 1 do
if (i > w + lxval) and (tiles[i][j] = nil) then begin
numlong := numlong + 1;
//tiles[i][j] := TYazevTile.Create(numlong, xpos - w / 2 + i, zpos - v / 2 + j + 1);
tiles[i][j] := TYazevTile.Create(numlong, xpos + i, zpos + j + 1);
end;
end;
// z
if zval < lzval then begin
for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) do
if (j > v + zval) and (tiles[i][j] <> nil) then
tiles[i][j].Clean_Memory(i, j);
for i := Low(tiles) to High(tiles) do
SetLength(tiles[i], Round(v) + zval + 1);
end else
if zval > lzval then begin
SetLength(tiles, Round(w) + xval + 1, Round(v) + zval + 2);
for i := Low(tiles) to High(tiles) - 1 do
for j := Low(tiles[i]) to High(tiles[i]) - 1 do
if (j > v + lzval) and (tiles[i][j] = nil) then begin
numlong := numlong + 1;
//tiles[i][j] := TYazevTile.Create(numlong, xpos - w / 2 + i + 1, zpos - v / 2 + j);
tiles[i][j] := TYazevTile.Create(numlong, xpos + i + 1, zpos + j);
end;
end;
end;

{ TYazevCube }

destructor TYazevCube.Clean_Memory(i: Integer);
begin
cubes[i] := nil;
cubes[i].Free
end;

constructor TYazevCube.Create(i : Integer; x, z: GLfloat);
begin
anumber := i;
xpos := x;
ypos := 0.0;
zpos := z;
ydeg := 0.0;
w := 1.0;
h := 2.0;
v := 1.0;
end;

procedure TYazevCube.Draw(i : Integer; mode : GLenum);
begin
glPushMatrix;
glTranslatef(xpos, ypos, zpos);
if mode = GL_SELECT then glLoadName(anumber);
glCallList(cube);
glPopMatrix;
end;

{ TYazevBomberMan }

destructor TYazevBomberMan.Clean_Memory;
begin
YazevBomberMan := nil;
YazevBomberMan.Free
end;

constructor TYazevBomberMan.Create(num : Integer; x, y, z, yd: GLfloat);
begin
anumber := num;

xpos := x;
ypos := y;
zpos := z;
ydeg := yd;

v := 1.0;
w := 1.0;
h := 2.0;
end;

procedure TYazevBomberMan.Draw(mode : GLenum);
const
mat_for_head : Array [0..3] of GLFloat = (1.0, 1.0, 0.0, 1.0);
mat_for_eyes : Array [0..3] of GLFloat = (1.0, 0.0, 0.0, 1.0);
mat_for_body : Array [0..3] of GLFloat = (0.0, 1.0, 0.0, 1.0);
mat_for_arms : Array [0..3] of GLFloat = (0.0, 0.0, 1.0, 1.0);
mat_for_legs : Array [0..3] of GLFloat = (0.0, 0.0, 0.0, 1.0);
mat_for_bots : Array [0..3] of GLFloat = (0.6, 0.3, 0.1, 1.0);
begin
if mode = GL_SELECT then glLoadName(anumber);
glPushMatrix;
glTranslatef(xpos, ypos, zpos);
glRotatef(ydeg, 0.0, 1.0, 0.0);//~~~
glPushMatrix;
//glTranslatef(0.0, 1.5, 0.0); - внимание!!!
//if P <> 0 then glRotatef(Degree, 0.0, P, 0.0);
glPushMatrix;
glRotatef(90.0, 1.0, 0.0, 0.0);
gluCylinder(qO, 0.0, 0.0, 3.0, 30, 30);
glPopMatrix;
//glPopMatrix;
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_head);
//glPushMatrix;
glScalef(0.7, 0.8, 0.8);
glTranslatef(0.9, -2.8, 0.0);
//if (X <> 0) or (Y <> 0) or (Z <> 0) then glRotatef(Degree, X, Y, Z);
gluSphere(qO, 0.15, 30, 30);
glPushMatrix;
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_eyes);
glTranslatef(0.05, 0.0, 0.11);
glutSolidSphere(0.05, 30, 30);
glTranslatef(-0.1, 0.0, 0.0);
glutSolidSphere(0.05, 30, 30);
glPushMatrix;
glTranslatef(0.05, -0.04, 0.02);
glutSolidSphere(0.03, 30, 30);
glPopMatrix;
glPushMatrix;
glTranslatef(0.05, -0.1, -0.05);
glScalef(1.1, 0.5, 1.0);
glutSolidCube(0.1);
glPopMatrix;
glPopMatrix;
glTranslatef(0.0, -0.1, 0.0);
glPushMatrix;
glRotatef(90.0, 1.0, 0.0, 0.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_body);
gluCylinder(qO, 0.05, 0.05, 0.1, 30, 30);
glPopMatrix;
glPushMatrix;
glTranslatef(0.0, -0.38, 0.0);
glScalef(0.9, 1.5, 1.0);
gluSphere(qO, 0.2, 30, 30);
glPopMatrix;
glPushMatrix;
glTranslatef(0.13, -0.24, 0.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_head);
glutSolidSphere(0.07, 30, 30);
glPushMatrix;
glTranslatef(0.05, 0.0, 0.0);
glRotatef(90.0, 0.0, 1.0, 0.0);
glRotatef(45.0, 1.0, 0.0, 0.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_arms);
gluCylinder(qO, 0.03, 0.03, 0.3, 30, 30);
glPopMatrix;
glPushMatrix;
glTranslatef(0.28, -0.23, 0.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_head);
glutSolidSphere(0.07, 30, 30);
glPushMatrix;
glRotatef(120.0, 0.0, 1.0, 1.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_arms);
gluCylinder(qO, 0.03, 0.03, 0.3, 30, 30);
glPopMatrix;
glPopMatrix;
glPushMatrix;
glTranslatef(0.48, 0.01, 0.09);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_head);
glutSolidSphere(0.07, 30, 30);
glPopMatrix;
glPopMatrix;
glPushMatrix;
glTranslatef(-0.13, -0.24, 0.0);
glutSolidSphere(0.07, 30, 30);
glPushMatrix;
glTranslatef(-0.05, 0.0, 0.0);
glRotatef(-90.0, 0.0, 1.0, 0.0);
glRotatef(45.0, 1.0, 0.0, 0.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_arms);
gluCylinder(qO, 0.03, 0.03, 0.3, 30, 30);
glPopMatrix;
glPushMatrix;
glTranslatef(-0.28, -0.23, 0.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_head);
glutSolidSphere(0.07, 30, 30);
glPushMatrix;
glRotatef(120.0, 0.0, -0.5, -0.5);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_arms);
gluCylinder(qO, 0.03, 0.03, 0.3, 30, 30);
glPopMatrix;
glPopMatrix;
glPushMatrix;
glTranslatef(-0.48, 0.01, 0.09);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_head);
glutSolidSphere(0.07, 30, 30);
glPopMatrix;
glPopMatrix;
glPushMatrix;
glTranslatef(0.09, -0.65, 0.0);
glutSolidSphere(0.07, 30, 30);
glPushMatrix;
glRotatef(130.0, 0.0, 0.5, -0.5);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_legs);
gluCylinder(qO, 0.03, 0.03, 0.3, 30, 30);
glPopMatrix;
glPushMatrix;
glTranslatef(0.18, -0.29, 0.05);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_head);
glutSolidSphere(0.07, 30, 30);
glPushMatrix;
glRotatef(200.0, 0.0, 0.5, -0.5);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_legs);
gluCylinder(qO, 0.03, 0.03, 0.3, 30, 30);
glPopMatrix;
glPushMatrix;
glTranslatef(-0.06, -0.3, 0.0);
glScalef(1.0, 1.0, 1.7);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_bots);
glutSolidCube(0.1);
glPopMatrix;
glPopMatrix;
glPopMatrix;
glPushMatrix;
glTranslatef(-0.09, -0.65, 0.0);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_head);
glutSolidSphere(0.07, 30, 30);
glPushMatrix;
glRotatef(130.0, 0.0, -0.5, 0.5);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_legs);
gluCylinder(qO, 0.03, 0.03, 0.3, 30, 30);
glPopMatrix;
glPushMatrix;
glTranslatef(-0.18, -0.29, 0.05);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_head);
glutSolidSphere(0.07, 30, 30);
glPushMatrix;
glRotatef(200.0, 0.0, -0.5, 0.5);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_legs);
gluCylinder(qO, 0.03, 0.03, 0.3, 30, 30);
glPopMatrix;
glPushMatrix;
glTranslatef(0.06, -0.3, 0.0);
glScalef(1.0, 1.0, 1.7);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_bots);
glutSolidCube(0.1);
glPopMatrix;
glPopMatrix;
glPopMatrix;
glPopMatrix;
glPopMatrix;
end;

{ TYazevBrickWall }

destructor TYazevBrickWall.Clean_Memory(num: Integer);
begin
walls[num] := nil;
walls[num].Free
end;

constructor TYazevBrickWall.Create(num: Integer; x, z: GLfloat);
begin
anumber := num;
xpos := x;
ypos := -3.0;
zpos := z;
ydeg := 0.0;
w := 1.0;
h := 2.0;
v := 1.0;
end;

procedure TYazevBrickWall.Draw(num : Integer; mode : GLenum);
begin
glPushMatrix;
glTranslatef(xpos, ypos, zpos);
if mode = GL_SELECT then glLoadName(anumber);
glCallList(brickwall);
glPopMatrix;
end;

{ TEnemyCyl }

destructor TEnemyCyl.Clean_Memory(num: Integer);
begin
encyl[num] := nil;
encyl[num].Free;
end;

constructor TEnemyCyl.Create(num, lifes, sh: Integer; x, y, z, ww, hh,
  vv, degree: GLfloat);
begin
anumber := num;
number := num;
lifescount := lifes;
shape := sh;
xpos := x;
lxpos := x;
ypos := y;
zpos := z;
lzpos := z;
ydeg := degree;
w := ww;
h := hh;
v := vv;
Change := false;
sp_var := 1.2;
//move := encylinc[num];
ThisSec := GetTickCount;
LastSec := ThisSec;
end;

procedure TEnemyCyl.Draw(num : Integer; mode : GLenum);
const
mat_for_lamp : Array [0..3] of GLfloat = (1.5, 0.5, 0.0, 1.0);
st = 0.02;
begin
lxpos := xpos;
lzpos := zpos;
ThisSec := GetTickCount;
if ThisSec - LastSec > 1000 then begin
//move := Select_Way;
LastSec := GetTickCount;
end;
{
case move of
0 : zpos := zpos - st;
1 : xpos := xpos - st;
2 : zpos := zpos + st;
3 : xpos := xpos + st;
end;
}
glPushMatrix;
glTranslatef(xpos, ypos, zpos);
glRotatef(90.0, 1.0, 0.0, 0.0);
glRotatef(ydeg, 0.0, 0.0, 1.0);
glScalef(1.0, 1.0, 1.2);
if mode = GL_SELECT then glLoadName(anumber);
glCallList(cyl);
glPushMatrix;
glTranslatef(0.0, 0.0, -0.25);
glScalef(sp_var, sp_var, sp_var);    // Look Out!!! "scale" is used here
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_lamp);
glutSolidSphere(0.2, 10, 10);
glPopMatrix;
glPopMatrix;
end;

{ TEnemySph }

destructor TEnemySph.Clean_Memory(num: Integer);
begin
ensph[num] := nil;
ensph[num].Free
end;

constructor TEnemySph.Create(num, lifes, sh: Integer; x, y, z, ww, hh,
  vv, degree: GLfloat);
begin
anumber := num;
number := num;
lifescount := lifes;
shape := sh;
xpos := x;
ypos := y;
zpos := z;
ydeg := degree;
w := ww;
h := hh;
v := vv;
Change := false;
sp_var := 0.0;
//move := ensphinc[num];
ThisSec := GetTickCount;
LastSec := ThisSec;
end;

procedure TEnemySph.Draw(num : Integer; mode : GLenum);
const
step = 0.5;
st = 0.02;
begin
lxpos := xpos;
lzpos := zpos;
ThisSec := GetTickCount;
if ThisSec - LastSec > 500 then begin
//move := Select_Way;
LastSec := GetTickCount;
end;
{
case move of
0 : zpos := zpos - st;
1 : xpos := xpos - st;
2 : zpos := zpos + st;
3 : xpos := xpos + st;
end;
}
glPushMatrix;
glTranslatef(xpos, ypos, zpos);
glRotatef(ydeg, 0.0, 1.0, 0.0);
glRotatef(sp_var, 0.0, 0.0, 1.0);
if mode = GL_SELECT then glLoadName(anumber);
glCallList(sph);
glPopMatrix;
end;

{ TEnemyDrop }

destructor TEnemyDrop.Clean_Memory(num: Integer);
begin
endrop[num] := nil;
endrop[num].Free;
end;

constructor TEnemyDrop.Create(num, lifes, sh: Integer; x, y, z, ww, hh,
  vv, degree: GLfloat);
begin
anumber := num;
number := num;
lifescount := lifes;
shape := sh;
xpos := x;
ypos := y;
zpos := z;
ydeg := degree;
w := ww;
h := hh;
v := vv;
Change := false;
sp_var := 0.0;
//move := endropinc[num];
ThisSec := GetTickCount;
LastSec := ThisSec;
end;

procedure TEnemyDrop.Draw(num : Integer; mode : GLenum);
const
mat_for_mouth : Array [0..3] of GLfloat = (0.9, 0.0, 0.0, 1.0);
m_o = 0.003;
st = 0.02;
begin
lxpos := xpos;
lzpos := zpos;
ThisSec := GetTickCount;
if ThisSec - LastSec > 1500 then begin
//move := Select_Way;
LastSec := GetTickCount;
end;
{
case move of
0 : zpos := zpos - st;
1 : xpos := xpos - st;
2 : zpos := zpos + st;
3 : xpos := xpos + st;
end;
}
glPushMatrix;
glTranslatef(xpos, ypos, zpos);
glRotatef(ydeg, 0.0, 1.0, 0.0);
if mode = GL_SELECT then glLoadName(anumber);
glCallList(drop);
glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, @mat_for_mouth);
glTranslatef(0.0, 1.35 + sp_var, 0.35);
glPushMatrix;
glScalef(1.0, 0.4, 0.5);
glutSolidCube(0.2);
glPopMatrix;
glTranslatef(0.0, 0.1 - sp_var, 0.0);
glPushMatrix;
glScalef(1.0, 0.4, 0.5);
glutSolidCube(0.2);
glPopMatrix;
glPopMatrix
end;

{ TGold }

destructor TGold.Clean_Memory(num: Integer);
begin
gold[num] := nil;
gold[num].Free;
end;

constructor TGold.Create(num: Integer; x, z: GLfloat);
begin
anumber := num;
xpos := x;
ypos := -3.55;
zpos := z;
ydeg := 0.0;
w := 0.5;
h := 0.5;
v := 0.5;
end;

procedure TGold.Draw(num : Integer; mode : GLenum);
begin
glPushMatrix;
glTranslatef(xpos, ypos, zpos);
glRotatef(ydeg, 0.0, 1.0, 0.0);
glRotatef(90.0, -1.0, 0.0, 0.0);
if mode = GL_SELECT then glLoadName(anumber);
glCallList(goldheap);
glPopMatrix;
end;

{ TExitDoor }
{
destructor TExitDoor.Clean_Memory;
begin
exitdoor := nil;
exitdoor.Free;
end;
 } {
constructor TExitDoor.Create(num : Integer; x, z: GLfloat);
begin
anumber := num;
xpos := x;
ypos := -3.0;
zpos := z;
ydeg := 0.0;
w := 0.9;
h := 1.9;
v := 0.9;
end;
  }                   (*
procedure TExitDoor.Draw(mode : GLenum);
begin
glPushMatrix;
glTranslatef(xpos, ypos, zpos);
glRotatef(ydeg, 0.0, 1.0, 0.0);
if mode = GL_SELECT then glLoadName(anumber);
glCallList(exdoor);
glPopMatrix;
{
if (YazevBomberMan <> nil)
and (YazevBomberMan.xpos + YazevBomberMan.w / 2 > xpos - w / 2)
and (YazevBomberMan.xpos - YazevBomberMan.w / 2 < xpos + w / 2)
and (YazevBomberMan.zpos + YazevBomberMan.v / 2 > zpos - v / 2)
and (YazevBomberMan.zpos - YazevBomberMan.v / 2 < zpos + v / 2)
 then begin
    YazevBomberMan.Clean_Memory;
 end;
 }
end;
                    *)
procedure TYazevBMLevel.Destroy_World;
begin
if Level <> nil then Level.Clean_Memory;
end;

procedure TYazevBMLevel.Window_ReDraw;
begin
glViewPort(0, 0, YazevTopView.ClientWidth, YazevTopView.ClientHeight);
glMatrixMode(GL_PROJECTION);
glLoadIdentity;
gluPerspective(80.0, 1.0, 0.01, 22.0);
glMatrixMode(GL_MODELVIEW);
glLoadIdentity;
//lzcam := lzcam + 0.25;
glTranslatef(xcam - lxcam, zcam - lzcam, ycam - lycam);// внимание!!!
glRotatef(90.0, 1.0, 0.0, 0.0); //~~~ эталон
{if YazevBomberMan <> nil then
with YazevBomberMan do begin
xcam := -xpos - 0.3;
zcam := -zpos - 3.0;
end;}
//glTranslatef(xcam, ycam, zcam);// ~~~ эталон
//glTranslatef(-0.5, 1.6, -16.0);

//********************************************************
//glRotatef(30.0, 0.0, -1.0, 0.0); //потом раскомментирую
//glRotatef(60.0, 1.0, 0.0, 0.0);
InvalidateRect(YazevTopView.Handle, nil, false);
end;

procedure TYazevBMLevel.Init_DirectInput;
begin
DirectInput8Create(hInstance, DirectInput_Version, IID_IDirectInput8, DI, nil);
DI.CreateDevice(GUID_SysKeyboard, DID, nil);
DID.SetDataFormat(c_dfDIKeyboard);
DID.SetCooperativeLevel(Handle, DISCL_FOREGROUND OR DISCL_EXCLUSIVE);
end;

procedure TYazevBMLevel.Check_Device;
const
obj_move = 0.5;
var
buts : Array [0..255] of Byte;
itog : HResult;
move : Single;
begin
ZeroMemory(@buts, SizeOf(buts));
itog := DID.GetDeviceState(SizeOf(buts), @buts);
if Failed (itog) then begin
itog := DID.Acquire;
while itog = DIERR_INPUTLOST do DID.Acquire;
end;
// перемещение камеры
with obj_sel do begin
move := YazevControlForm.YazevStepControl.Position / 100;
if ((buts[DIK_UP] or buts[DIK_W]) and $80 <> 0) then begin
if obj_num < 0 then begin
zcam := zcam + move;
lzcam := zcam;
end else
if key_delay then begin
Level.was_changed := true;
if obj_type = 'cubes' then cubes[obj_num].zpos := cubes[obj_num].zpos - obj_move else
if obj_type = 'walls' then walls[obj_num].zpos := walls[obj_num].zpos - obj_move else
if obj_type = 'gold' then gold[obj_num].zpos := gold[obj_num].zpos - obj_move else
if obj_type = 'encyl' then encyl[obj_num].zpos := encyl[obj_num].zpos - obj_move else
if obj_type = 'endrop' then endrop[obj_num].zpos := endrop[obj_num].zpos - obj_move else
if obj_type = 'ensph' then ensph[obj_num].zpos := ensph[obj_num].zpos - obj_move else
if obj_type = 'YazevBomberMan' then YazevBomberMan.zpos := YazevBomberMan.zpos - obj_move;
key_delay := false;
KeyDelay.Enabled := true;
end
end;
if ((buts[DIK_DOWN] or buts[DIK_S]) and $80 <> 0) then begin
if obj_num < 0 then begin
zcam := zcam - move;
lzcam := zcam;
end else
if key_delay then begin
Level.was_changed := true;
if obj_type = 'cubes' then cubes[obj_num].zpos := cubes[obj_num].zpos + obj_move else
if obj_type = 'walls' then walls[obj_num].zpos := walls[obj_num].zpos + obj_move else
if obj_type = 'gold' then gold[obj_num].zpos := gold[obj_num].zpos + obj_move else
if obj_type = 'encyl' then encyl[obj_num].zpos := encyl[obj_num].zpos + obj_move else
if obj_type = 'endrop' then endrop[obj_num].zpos := endrop[obj_num].zpos + obj_move else
if obj_type = 'ensph' then ensph[obj_num].zpos := ensph[obj_num].zpos + obj_move else
if obj_type = 'YazevBomberMan' then YazevBomberMan.zpos := YazevBomberMan.zpos + obj_move;
key_delay := false;
KeyDelay.Enabled := true;
end
end;
if ((buts[DIK_RIGHT] or buts[DIK_D]) and $80 <> 0) then begin
if obj_num < 0 then begin
xcam := xcam - move;
lxcam := xcam;
end else
if key_delay then begin
Level.was_changed := true;
if obj_type = 'cubes' then cubes[obj_num].xpos := cubes[obj_num].xpos + obj_move else
if obj_type = 'walls' then walls[obj_num].xpos := walls[obj_num].xpos + obj_move else
if obj_type = 'gold' then gold[obj_num].xpos := gold[obj_num].xpos + obj_move else
if obj_type = 'encyl' then encyl[obj_num].xpos := encyl[obj_num].xpos + obj_move else
if obj_type = 'endrop' then endrop[obj_num].xpos := endrop[obj_num].xpos + obj_move else
if obj_type = 'ensph' then ensph[obj_num].xpos := ensph[obj_num].xpos + obj_move else
if obj_type = 'YazevBomberMan' then YazevBomberMan.xpos := YazevBomberMan.xpos + obj_move;
key_delay := false;
KeyDelay.Enabled := true;
end
end;
if ((buts[DIK_LEFT] or buts[DIK_A]) and $80 <> 0) then begin
if obj_num < 0 then begin
xcam := xcam + move;
lxcam := xcam;
end else
if key_delay then begin
Level.was_changed := true;
if obj_type = 'cubes' then cubes[obj_num].xpos := cubes[obj_num].xpos - obj_move else
if obj_type = 'walls' then walls[obj_num].xpos := walls[obj_num].xpos - obj_move else
if obj_type = 'gold' then gold[obj_num].xpos := gold[obj_num].xpos - obj_move else
if obj_type = 'encyl' then encyl[obj_num].xpos := encyl[obj_num].xpos - obj_move else
if obj_type = 'endrop' then endrop[obj_num].xpos := endrop[obj_num].xpos - obj_move else
if obj_type = 'ensph' then ensph[obj_num].xpos := ensph[obj_num].xpos - obj_move else
if obj_type = 'YazevBomberMan' then YazevBomberMan.xpos := YazevBomberMan.xpos - obj_move;
key_delay := false;
KeyDelay.Enabled := true;
end
end;
if (buts[DIK_DELETE] and $80 <> 0) then begin
if (obj_type = 'cubes') and (cubes[obj_num] <> nil) then cubes[obj_num].Clean_Memory(obj_num);
if (obj_type = 'walls') and (walls[obj_num] <> nil) then walls[obj_num].Clean_Memory(obj_num);
if (obj_type = 'gold') and (gold[obj_num] <> nil) then gold[obj_num].Clean_Memory(obj_num);
if (obj_type = 'encyl') and (encyl[obj_num] <> nil) then encyl[obj_num].Clean_Memory(obj_num);
if (obj_type = 'endrop') and (endrop[obj_num] <> nil) then endrop[obj_num].Clean_Memory(obj_num);
if (obj_type = 'ensph') and (ensph[obj_num] <> nil) then ensph[obj_num].Clean_Memory(obj_num);
if (obj_type = 'YazevBomberMan') and (YazevBomberMan <> nil) then YazevBomberMan.Clean_Memory;
if obj_sel.obj_num > -1 then Level.was_changed := true;
obj_sel.obj_num := -1;
obj_sel.obj_type := '';
end;
if (buts[DIK_ESCAPE] and $80 <> 0) then begin
Close;
Exit;
end;
end;
end;

procedure TYazevBMLevel.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
Zoom(-0.3)
end;

procedure TYazevBMLevel.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
Zoom(0.3)
end;

procedure TYazevBMLevel.Zoom(z: Single);// внимание!!!
begin
lycam := ycam;
ycam := ycam + z;
glPushMatrix;
glTranslatef(0.0, ycam, 0.0);
glPopMatrix;
end;

{ TYazevTile }

destructor TYazevTile.Clean_Memory(i, j: Integer);
begin
tiles[i, j] := nil;
tiles[i, j].Free
end;

constructor TYazevTile.Create(i: Integer; x, z: GLfloat);
begin
anumber := i;
xpos := x - 0.5;
ypos := 0.0;//-1.77;
zpos := z - 0.5;
end;

procedure TYazevTile.Draw(i, j: Integer; mode : GLenum);
begin
glPushMatrix;
glTranslatef(xpos, ypos, zpos);
if mode = GL_SELECT then glLoadName(anumber);
glCallList(tile);
glPopMatrix;
end;

function TYazevBMLevel.ChoiceObj(x, y: GLint) : GLUint;
begin
glRenderMode(GL_SELECT);
glInitNames;
glPushName(0);
glGetIntegerv(GL_VIEWPORT, @ViewPort);
glMatrixMode(GL_PROJECTION);
glLoadIdentity;
gluPickMatrix(x, YazevTopView.Height - y, 1, 1, @ViewPort);
gluPerspective(80.0, 1.0, 0.01, 22.0);
glViewPort(0, 0, YazevTopView.ClientWidth, YazevTopView.ClientHeight);
glMatrixMode(GL_MODELVIEW);
glClear(GL_COLOR_BUFFER_BIT);
Draw_World(GL_SELECT);
Result := glRenderMode(GL_RENDER);
end;

procedure TYazevBMLevel.YazevTopViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
  hits, name : GLUint;
  count, i, j : Integer;
  label
  exit;
begin
hits := ChoiceObj(X, Y);
FormResize(self);
if hits = 1 then begin
if (not Select_Cube(1)) and (not Select_Wall(1)) and (not Select_Gold(1))
and (not Select_EnCyl(1)) and (not Select_EnDrop(1)) and (not Select_EnSph(1))
and (not Select_YazevBomberMan(1)) then begin
if objTypeBuild = 0 then with obj_sel do begin
obj_num := -1;
obj_type := '';
end;
case objTypeBuild of
1 : begin // cubes
name := SelectBuffer[(1 - 1) * 4 + 3];
for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) - 1 do
if (tiles[i+1][j+1] <> nil) and (Abs(name) = tiles[i+1][j+1].anumber) then begin
count := High(cubes) + 1;
SetLength(cubes, count + 1);
numlong := numlong + 1;
obj_sel.obj_num := count;
obj_sel.obj_type := 'cubes';
Level.was_changed := true;
try
cubes[count] := TYazevCube.Create(numlong, tiles[i+1][j+1].xpos+1, tiles[i+1][j+1].zpos+1);
except
//ShowMessage('');
end;

goto exit;
end
end; // 1
2 : begin // walls
name := SelectBuffer[(1 - 1) * 4 + 3];
for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) - 1 do
if (tiles[i+1][j+1] <> nil) and (Abs(name) = tiles[i+1][j+1].anumber) then begin
count := High(walls) + 1;
SetLength(walls, count + 1);
numlong := numlong + 1;
obj_sel.obj_num := count;
obj_sel.obj_type := 'walls';
Level.was_changed := true;
try
walls[count] := TYazevBrickWall.Create(numlong, tiles[i+1][j+1].xpos, tiles[i+1][j+1].zpos+0.5);
except
//ShowMessage('');
end;
//ShowMessage('a = ' + IntToStr(tiles[i+1][j+1].anumber));
goto exit;
end
end; // 2
3 : begin // gold
name := SelectBuffer[(1 - 1) * 4 + 3];
for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) - 1 do
if (tiles[i+1][j+1] <> nil) and (Abs(name) = tiles[i+1][j+1].anumber) then begin
count := High(gold) + 1;
SetLength(gold, count + 1);
numlong := numlong + 1;
obj_sel.obj_num := count;
obj_sel.obj_type := 'gold';
Level.was_changed := true;
try
gold[count] := TGold.Create(numlong, tiles[i+1][j+1].xpos, tiles[i+1][j+1].zpos+0.5);
except
//ShowMessage('');
end;
//ShowMessage('a = ' + IntToStr(tiles[i+1][j+1].anumber));
goto exit;
end
end; // 3
4 : begin // encyl
name := SelectBuffer[(1 - 1) * 4 + 3];
for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) - 1 do
if (tiles[i+1][j+1] <> nil) and (Abs(name) = tiles[i+1][j+1].anumber) then begin
count := High(encyl) + 1;
SetLength(encyl, count + 1);
numlong := numlong + 1;
obj_sel.obj_num := count;
obj_sel.obj_type := 'encyl';
Level.was_changed := true;
try
encyl[count] := TEnemyCyl.Create(numlong, 0, 0, tiles[i+1][j+1].xpos, -2.15, tiles[i+1][j+1].zpos, 1.0, 2.0, 1.0, 0.0);
except
//ShowMessage('');
end;
//ShowMessage('a = ' + IntToStr(tiles[i+1][j+1].anumber));
goto exit;
end
end; // 4
5 : begin // endrop
name := SelectBuffer[(1 - 1) * 4 + 3];
for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) - 1 do
if (tiles[i+1][j+1] <> nil) and (Abs(name) = tiles[i+1][j+1].anumber) then begin
count := High(endrop) + 1;
SetLength(endrop, count + 1);
numlong := numlong + 1;
obj_sel.obj_num := count;
obj_sel.obj_type := 'endrop';
Level.was_changed := true;
try
endrop[count] := TEnemyDrop.Create(numlong, 0, 2, tiles[i+1][j+1].xpos, -3.5, tiles[i+1][j+1].zpos, 1.0, 2.0, 1.0, 0.0);
except
//ShowMessage('');
end;
//ShowMessage('a = ' + IntToStr(tiles[i+1][j+1].anumber));
goto exit;
end
end; // 5
6 : begin // ensph
name := SelectBuffer[(1 - 1) * 4 + 3];
for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) - 1 do
if (tiles[i+1][j+1] <> nil) and (Abs(name) = tiles[i+1][j+1].anumber) then begin
count := High(ensph) + 1;
SetLength(ensph, count + 1);
numlong := numlong + 1;
obj_sel.obj_num := count;
obj_sel.obj_type := 'ensph';
Level.was_changed := true;
try
ensph[count] := TEnemySph.Create(numlong, 0, 1, tiles[i+1][j+1].xpos, -2.5, tiles[i+1][j+1].zpos, 1.0, 2.0, 1.0, 0.0);
except
//ShowMessage('');
end;
//ShowMessage('a = ' + IntToStr(tiles[i+1][j+1].anumber));
goto exit;
end
end; // 6
7 : begin // YazevBomberMan
name := SelectBuffer[(1 - 1) * 4 + 3];
for i := Low(tiles) to High(tiles) do
for j := Low(tiles[i]) to High(tiles[i]) - 1 do
if (tiles[i+1][j+1] <> nil) and (Abs(name) = tiles[i+1][j+1].anumber) then begin
//count := High(ensph) + 1;
//SetLength(ensph, count + 1);
numlong := numlong + 1;
obj_sel.obj_num := 0;
obj_sel.obj_type := 'YazevBomberMan';
Level.was_changed := true;
try
if YazevBomberMan = nil then
YazevBomberMan := TYazevBomberMan.Create(numlong, tiles[i+1][j+1].xpos-0.5, 0.0, tiles[i+1][j+1].zpos+0.5, 0.0)
else ShowMessage('The World can include only one YazevBomberMan');
except
//ShowMessage('');
end;
//ShowMessage('a = ' + IntToStr(tiles[i+1][j+1].anumber));
goto exit;
end
end; // 7
end; // case...of
end; // if...not...then
end else
if hits = 2 then begin
Select_Cube(2);
Select_Wall(2);
Select_Gold(2);
Select_EnCyl(2);
Select_EnDrop(2);
Select_EnSph(2);
Select_YazevBomberMan(2);
end else
if hits = 0 then begin
obj_sel.obj_num := -1;
obj_sel.obj_type := '';
end;
exit :
end;

procedure TYazevBMLevel.mmbCFormClick(Sender: TObject);
begin
YazevControlForm.Show
end;

procedure TYazevBMLevel.mmbCreateClick(Sender: TObject);
var
s : String;
but : Integer;
begin
levelNum := levelNum + 1;

if Level.was_changed then begin
but := MessageDlg('Do you wanna save your World?', mtConfirmation, mbYesNoCancel, 0);
case but of
mrYes :
if Level <> nil then begin
if Level.LevelLabel = '' then mmbSaveLevel.Click else Level.SaveCurrentFile;
end;
//mrCancel : Action := caNone;
end;
end;

GLactive := false;
Destroy_World;
s := InputBox('YazevBomberManDev - Level Label', 'Input Level name', 'Level01');
if Level = nil then Level := TYazevLevel.Create(YazevBMLevel, s, 7, 7, false);
Null;
mbPointer.OnMouseDown(mbPointer, mbLeft, [ssShift], 0, 0);
GLactive := true;
end;

procedure TYazevBMLevel.mbPointerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  const
  n : Array [0..7] of String = ('mbPointer', 'mbCube', 'mbWall', 'mbGold',
                                'mbEnCyl', 'mbEnDrop', 'mbEnSph',
                                'mbYazevBomberMan');
  var
  comp : TPanel;
  i : Integer;
  obj : TPanel;
begin
for i := Low(n) to High(n) do begin
comp := FindComponent(n[i]) as TPanel;
if comp.BevelInner = bvLowered then begin
comp.BevelInner := bvRaised;
comp.BevelOuter := bvRaised;
end;
end;
//
obj := nil;
if Sender is TPanel then obj := Sender as TPanel else
if ((Sender as TImage).Parent is TPanel) then obj := ((Sender as TImage).Parent as TPanel);
if obj.BevelInner = bvRaised then begin
obj.BevelInner := bvLowered;
obj.BevelOuter := bvLowered;
end;
objTypeBuild := 0;
end;

procedure TYazevBMLevel.mbCubeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
mbPointerMouseDown(Sender, Button, Shift, X, Y);
objTypeBuild := 1;
end;

function TYazevBMLevel.Select_Cube(hits : Integer) : Bool;
var
name, i, j : Integer;
begin
name := 0;
for j := 1 to hits do
name := SelectBuffer[(j - 1) * 4 + 3];
for i := Low(cubes) to High(cubes) do
if (cubes[i] <> nil) and (Abs(name) = cubes[i].anumber) then begin
with obj_sel do begin
obj_num := i;
obj_type := 'cubes';
end;
Result := true;
exit
end;
Result := false;
end;

procedure TYazevBMLevel.mbWallMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
mbPointerMouseDown(Sender, Button, Shift, X, Y);
objTypeBuild := 2;
end;

function TYazevBMLevel.Select_Wall(hits: Integer): Bool;
var
name, i, j : Integer;
begin
name := 0;
for j := 1 to hits do
name := SelectBuffer[(j - 1) * 4 + 3];
for i := Low(walls) to High(walls) do
if (walls[i] <> nil) and (Abs(name) = walls[i].anumber) then begin
with obj_sel do begin
obj_num := i;
obj_type := 'walls';
end;
Result := true;
exit;
end;
Result := false;
end;

procedure TYazevBMLevel.mbGoldMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
mbPointerMouseDown(Sender, Button, Shift, X, Y);
objTypeBuild := 3;
end;

function TYazevBMLevel.Select_Gold(hits: Integer): Bool;
var
name, i, j : Integer;
begin
name := 0;
for j := 1 to hits do
name := SelectBuffer[(j - 1) * 4 + 3];
for i := Low(gold) to High(gold) do
if (gold[i] <> nil) and (Abs(name) = gold[i].anumber) then begin
with obj_sel do begin
obj_num := i;
obj_type := 'gold';
end;
Result := true;
exit;
end;
Result := false;
end;

procedure TYazevBMLevel.mbEnCylMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
mbPointerMouseDown(Sender, Button, Shift, X, Y);
objTypeBuild := 4;
end;

function TYazevBMLevel.Select_EnCyl(hits: Integer): Bool;
var
name, i, j : Integer;
begin
name := 0;
for j := 1 to hits do
name := SelectBuffer[(j - 1) * 4 + 3];
for i := Low(encyl) to High(encyl) do
if (encyl[i] <> nil) and (Abs(name) = encyl[i].anumber) then begin
with obj_sel do begin
obj_num := i;
obj_type := 'encyl';
end;
Result := true;
exit;
end;
Result := false;
end;

procedure TYazevBMLevel.mbEnDropMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
mbPointerMouseDown(Sender, Button, Shift, X, Y);
objTypeBuild := 5;
end;

function TYazevBMLevel.Select_EnDrop(hits: Integer): Bool;
var
name, i, j : Integer;
begin
name := 0;
for j := 1 to hits do
name := SelectBuffer[(j - 1) * 4 + 3];
for i := Low(endrop) to High(endrop) do
if (endrop[i] <> nil) and (Abs(name) = endrop[i].anumber) then begin
with obj_sel do begin
obj_num := i;
obj_type := 'endrop';
end;
Result := true;
exit;
end;
Result := false;
end;

procedure TYazevBMLevel.mbEnSphMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
mbPointerMouseDown(Sender, Button, Shift, X, Y);
objTypeBuild := 6;
end;

function TYazevBMLevel.Select_EnSph(hits: Integer): Bool;
var
name, i, j : Integer;
begin
name := 0;
for j := 1 to hits do
name := SelectBuffer[(j - 1) * 4 + 3];
for i := Low(ensph) to High(ensph) do
if (ensph[i] <> nil) and (Abs(name) = ensph[i].anumber) then begin
with obj_sel do begin
obj_num := i;
obj_type := 'ensph';
end;
Result := true;
exit;
end;
Result := false;
end;

procedure TYazevBMLevel.mbYazevBomberManMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
mbPointerMouseDown(Sender, Button, Shift, X, Y);
objTypeBuild := 7;
end;

function TYazevBMLevel.Select_YazevBomberMan(hits: Integer): Bool;
var
name, j : Integer;
begin
name := 0;
for j := 1 to hits do
name := SelectBuffer[(j - 1) * 4 + 3];
if (YazevBomberMan <> nil) and (Abs(name) = YazevBomberMan.anumber) then begin
with obj_sel do begin
obj_num := 0;
obj_type := 'YazevBomberMan';
end;
Result := true;
exit;
end;
Result := false;
end;

procedure TYazevBMLevel.mmbLoadLevelClick(Sender: TObject);
var
openf : String;
but : Integer;
begin

if Level.was_changed then begin
but := MessageDlg('Do you wanna save your World?', mtConfirmation, mbYesNoCancel, 0);
case but of
mrYes :
if Level <> nil then begin
if Level.LevelLabel = '' then mmbSaveLevel.Click else Level.SaveCurrentFile;
end;
//mrCancel : Action := caNone;
end;
end;

if YazevOpenWorldFile.Execute then begin
//openf := 'H:\Yazev Yuriy\Delphi\YazevOpenGL\YazevBomberManDev\YazevLevel01.ywf';
openf := YazevOpenWorldFile.FileName;
GLactive := false;
Destroy_World;
if Level = nil then Level := TYazevLevel.Create(YazevBMLevel, openf, 1, 1, true);
//YazevLevelBuilder.Clear;
//Level.LoadLevel(openf, YazevBMLevel);
//Level.SetSize(Round(wii), Round(vii), false);
Null;
mbPointer.OnMouseDown(mbPointer, mbLeft, [ssShift], 0, 0);
GLactive := true;
end
end;

procedure TYazevBMLevel.Null;
begin
xcam := 0.0;
ycam := -2.0;
zcam := 0.0;
lxcam := 0.0;
lycam := 0.0;
lzcam := 0.0;
end;

procedure TYazevBMLevel.mmbSaveLevelClick(Sender: TObject);
const
ex = '.ywf';
var
s : String;
begin
if Level <> nil then begin
Level.was_changed := false;
YazevSaveWorldFile.FileName := Level.LevelCaption;
if YazevSaveWorldFile.Execute then begin
s := ExtractFilePath(YazevSaveWorldFile.FileName) + Level.GetName(YazevSaveWorldFile.FileName);
//ShowMessage(s);
Level.LevelLabel := s;
Level.LevelCaption := Level.GetName(s);
Caption := 'YazevBomberManDevelopmentStudio   developed by Yazev Yuriy:  ' + Level.LevelCaption;
Level.SaveLevel(s);
end
end
end;

procedure TYazevBMLevel.KeyDelayTimer(Sender: TObject);
begin
key_delay := true;
KeyDelay.Enabled := false;
end;

procedure TYazevBMLevel.mmbExitClick(Sender: TObject);
begin
Close
end;

procedure TYazevBMLevel.Rotate_90Click(Sender: TObject);
const
d = 90;
d2 = 270;
begin
with obj_sel do begin
if obj_type = 'encyl' then
encyl[obj_num].ydeg := d else
if obj_type = 'ensph' then
ensph[obj_num].ydeg := d2 else
if obj_type = 'endrop' then
endrop[obj_num].ydeg := d2 else
if obj_type = 'YazevBomberMan' then
YazevBomberMan.ydeg := d2;
end;
end;

procedure TYazevBMLevel.Rotate_180Click(Sender: TObject);
const
d = 180;
begin
with obj_sel do begin
if obj_type = 'encyl' then
encyl[obj_num].ydeg := d else
if obj_type = 'ensph' then
ensph[obj_num].ydeg := d else
if obj_type = 'endrop' then
endrop[obj_num].ydeg := d else
if obj_type = 'YazevBomberMan' then
YazevBomberMan.ydeg := d;
end;
end;

procedure TYazevBMLevel.Rotate_270Click(Sender: TObject);
const
d = 90;
d2 = 270;
begin
with obj_sel do begin
if obj_type = 'encyl' then
encyl[obj_num].ydeg := d2 else
if obj_type = 'ensph' then
ensph[obj_num].ydeg := d else
if obj_type = 'endrop' then
endrop[obj_num].ydeg := d else
if obj_type = 'YazevBomberMan' then
YazevBomberMan.ydeg := d;
end;
end;

procedure TYazevBMLevel.Rotate_360Click(Sender: TObject);
const
d = 0;
begin
with obj_sel do begin
if obj_type = 'encyl' then
encyl[obj_num].ydeg := d else
if obj_type = 'ensph' then
ensph[obj_num].ydeg := d else
if obj_type = 'endrop' then
endrop[obj_num].ydeg := d else
if obj_type = 'YazevBomberMan' then
YazevBomberMan.ydeg := d;
end;
end;

procedure TYazevBMLevel.mmbAboutClick(Sender: TObject);
begin
YazevAboutForm.ShowModal
end;

procedure TYazevBMLevel.mmbRegClick(Sender: TObject);
var
Reg : TRegistry;
begin
Reg := TRegistry.Create;
Reg.RootKey := HKEY_CLASSES_ROOT;
Reg.OpenKey('.YWF', true);
Reg.WriteString('', 'YWFfile');
Reg.CloseKey;
Reg.CreateKey('YWF' + 'file_cyd');
Reg.OpenKey('YWFfile\DefaultIcon', true);
Reg.WriteString('', Application.ExeName + ', 0');
Reg.CloseKey;
Reg.OpenKey('YWFfile\shell\open\command', true);
Reg.WriteString('', Application.ExeName + ' "%1"');
Reg.CloseKey;
Reg.Free;
end;

procedure TYazevBMLevel.YazevGameStartUpTimer(Sender: TObject);
var
i : Integer;
s : String;
begin
if ParamCount > 0 then begin
s := ParamStr(1);
for i := 2 to ParamCount do
s := s + ' ' + ParamStr(i);
if Level = nil then Level := TYazevLevel.Create(YazevBMLevel, s, 1, 1, true);
//ShowMessage(s);
end;
YazevGameStartUp.Enabled := false;
end;

end.
