unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Menus, StdCtrls, Grids, IBDatabase, DB, IBCustomDataSet, IBTable, DBGrids, 
  UN_DLL_MX, ExtCtrls, sPanel, acSlider, sGroupBox, sSkinProvider, sSkinManager, 
  acDBGrid, sLabel, acDBTextFX, sEdit;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N18: TMenuItem;
    N11: TMenuItem;
    N17: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    IBTable1: TIBTable;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBTable2: TIBTable;
    IBTransaction2: TIBTransaction;
    StringGrid2: TStringGrid;
    IBTable3: TIBTable;
    IBTransaction3: TIBTransaction;
    StringGrid4: TStringGrid;
    StringGrid5: TStringGrid;
    Label6: TsLabel;
    sSlider1: TsSlider;
    sGroupBox1: TsGroupBox;
    sGroupBox2: TsGroupBox;
    StringGrid3: TStringGrid;
    sGroupBox3: TsGroupBox;
    StringGrid1: TStringGrid;
    sGroupBox4: TsGroupBox;
    sGroupBox5: TsGroupBox;
    sGroupBox6: TsGroupBox;
    sSkinManager1: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    sEdit1: TsEdit;
    sLabelFX1: TsLabelFX;
    procedure N3Click(Sender: TObject);
    procedure N15Click(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure ReadTable1;
    procedure InitMatLabMCL;
    procedure ReadTable2;
    procedure ReadTable3;
    procedure OpenTables;
    procedure N6Click(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  Form1: TForm1;
  Flag_MCR_Initialize : Boolean = False;
  perX_ptr : pmxArray;
  perF_ptr, perA_ptr, perB_ptr, perLB_ptr : pmxArray;
  //perF,perX ,perA,  perB,  perLB : array of array of Double;
  perF: array[1..100,1..1] of double;
  perB: array[1..100,1..1] of double;
  perA: array of array of Double;
  //perA: array[1..3,1..4] of double;
  perLB: array[1..100,1..1] of double;
  perX: array[1..100,1..1] of double;

implementation
{$R *.dfm}
//Данные_Загрузить из БД
procedure TForm1.N3Click(Sender: TObject);
begin
  OpenTables;
  ReadTable1;
  ReadTable2;
  ReadTable3;
end;

  procedure TForm1.OpenTables;
  begin
    IBTable1.Open;
    IBTable1.FetchAll;
    IBTable2.Open;
    IBTable2.FetchAll;
    IBTable3.Open;
    IBTable3.FetchAll;
  end;

  procedure TForm1.ReadTable1;
  var i,j:integer;
  begin

  IBTable1.First;
  StringGrid1.RowCount:= 2;
  StringGrid1.ColCount:= IBTable1.RecordCount+1;
  //SetLength(perF,IBTable1.RecordCount+1,2);
 // SetLength(perLB, IBTable1.RecordCount+1,2);
  StringGrid1.Cells[0,1]:= 'Коэффициенты';
   for i:=1 to IBTable1.RecordCount do
   StringGrid1.Cells[i,1]:='P'+inttostr(i);
   i:=1;
  while not IBTable1.Eof do
    begin
    StringGrid1.Cells[i,1] := IBTable1.Fields[4].asString;
    perF[i,1] := IBTable1.Fields[4].AsFloat;
    inc(i);
    IBTable1.Next;
  end;
  end;

  procedure TForm1.ReadTable2;
  var i,j,row:Integer;
  begin

  StringGrid2.RowCount:= IBTable3.RecordCount+1;
  StringGrid2.ColCount:=IBTable1.RecordCount+1;
  SetLength(perA,IBTable3.RecordCount,IBTable1.RecordCount);
  for i:=1 to IBTable3.RecordCount do
    StringGrid2.Cells[0,i] := 'b'+ inttostr(i);
    for j:=1 to IBTable1.RecordCount do
    StringGrid2.Cells[j,0]:='P'+inttostr(j);
    row:=1;
    i:=1;
  IBTable2.First;
  while not IBTable2.Eof do
  begin
    if (i<=StringGrid1.ColCount-1) then
    begin
      StringGrid2.Cells[i,row]:= IBTable2.Fields[2].AsString;
      perA[row-1,i-1] :=  IBTable2.Fields[2].asFloat;
      inc(i);
    end
    else
    begin
      i:=1;
      inc(row);
      StringGrid2.Cells[i,row]:= IBTable2.Fields[2].AsString;
      perA[row-1,0] :=  IBTable2.Fields[2].asFloat;
      inc(i);
    end;
    IBTable2.Next;
  end;
  end;

  procedure TForm1.ReadTable3;
  var i:Integer;
  begin


  IBTable3.First;
  StringGrid3.RowCount:= IBTable1.RecordCount+1;
  StringGrid3.ColCount:= IBTable3.RecordCount-1;
 // SetLength(perB, IBTable3.RecordCount,1);
  StringGrid3.Cells[1,0]:= 'b';
   StringGrid3.Cells[2,0]:= 'lb';
   for i:=1 to IBTable3.RecordCount do
   StringGrid3.Cells[0,i]:='b'+inttostr(i);
   i:=1;
  while not IBTable3.Eof do
    begin
    StringGrid3.Cells[1,i] := IBTable3.Fields[1].asString;
    //StringGrid3.Cells[2,i] := IBTable3.Fields[2].asString;
    perB[i,1] :=   IBTable3.Fields[1].asFloat;
    inc(i);
    IBTable3.Next;
  end;

  IBTable3.First;
  StringGrid4.RowCount:= IBTable1.RecordCount+1;
  StringGrid4.ColCount:= IBTable3.RecordCount-1;

  //StringGrid4.Cells[1,0]:= 'b';
  StringGrid4.Cells[1,0]:= 'lb';
   for i:=1 to IBTable3.RecordCount do
   StringGrid4.Cells[0,i]:='b'+inttostr(i);
   i:=1;
  while not IBTable3.Eof do
    begin
    StringGrid4.Cells[1,i] := IBTable3.Fields[2].asString;
    //StringGrid4.Cells[2,i] := IBTable3.Fields[2].asString;
    perLB[i,1] := IBTable3.Fields[2].asFloat;
    inc(i);
    IBTable3.Next;
  end;
  end;

//Вывод, план
procedure TForm1.N15Click(Sender: TObject);
var i,j :integer;
P: PDouble;
Row: Integer;
k:double;
begin

  perA_ptr := mxCreateDoubleMatrix(IBTable1.RecordCount,IBTable3.RecordCount,mxREAL);
  P :=  mxGetPr(perA_ptr);
  for Row := 0 to high(perA) do
  begin
  Move(Pointer(perA[Row])^, P^, SizeOf(Double)*Length(perA[Row]));
  inc(P, Length(perA[Row]));
  end;
  perA_ptr:=mxTranspose(perA_ptr);

  perB_ptr := mxCreateDoubleMatrix(IBTable3.RecordCount,1,mxREAL);
  Move(perB, mxGetPr(perB_ptr)^, IBTable3.RecordCount*sizeof(double));
  perB_ptr:=mxTranspose(perB_ptr);


  if not sSlider1.SliderOn then
    for i:=1 to IBTable1.RecordCount do
      perF[i,1] := -(perF[i,1]);
  perF_ptr := mxCreateDoubleMatrix(1,IBTable1.RecordCount,mxREAL);
  Move(perF, mxGetPr(perF_ptr)^, IBTable1.RecordCount*sizeof(double));
  perF_ptr:=mxTranspose(perF_ptr);
  if not sSlider1.SliderOn then
    for i:=1 to IBTable1.RecordCount do
      perF[i,1] := -(perF[i,1]);
  perLB_ptr := mxCreateDoubleMatrix(1,IBTable1.RecordCount,mxREAL);
  Move(perLB, mxGetPr(perLB_ptr)^, IBTable1.RecordCount*sizeof(double));
  perLB_ptr:=mxTranspose(perLB_ptr);

  _mlflp121(1,perX_ptr,perF_ptr,perA_ptr,perB_ptr,perLB_ptr);
  if perX_ptr<> nil then
  begin
      perX_ptr := mxTranspose(perX_ptr);
      Move(mxGetPr(perX_ptr)^,perX,IBTable1.RecordCount*sizeof(double));
  for i:=1 to IBTable1.RecordCount do
   begin
      Form1.StringGrid5.Cells[0,i]:='P'+inttostr(i);
      StringGrid5.Cells[1,i] := FloatToStrF(perX[i,1], fffixed,4,2);
   end;
   k:=0;
   for i:=1 to StringGrid1.ColCount-1 do
   k:=k+(StrToFloat(StringGrid1.Cells[i,1])*StrToFloat(StringGrid5.Cells[1,i]));
   sEdit1.Text := FloatToStr(k);
   Application.MessageBox('Успех!', 'Результат');
  end
  else
      
end;

procedure TForm1.InitMatLabMCL;
begin
  if Flag_MCR_Initialize=False then
  begin
    mclInitializeApplication(0,0);
    _linprogInitialize;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    InitMatLabMCL;
    StringGrid5.Cells[0,0]:= 'P';

    StringGrid5.Cells[1,0]:= 'Решение';
    StringGrid1.ColWidths[0] := 110;

end;

procedure TForm1.N6Click(Sender: TObject);begin
Application.Terminate;
end;

end.